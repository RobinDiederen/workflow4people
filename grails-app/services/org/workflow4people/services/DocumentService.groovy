/*
 * Workflow4people
 * Copyright 2009-2013, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */

/**
 * Document service class. 
 * Provides document services  
 * 
 * @author Joost Horward
 */

package org.workflow4people.services
import org.springframework.beans.factory.InitializingBean;
import org.workflow4people.*;

import org.open_t.cmis.services.*
import org.open_t.cmis.*
import java.text.*;
import groovy.lang.Binding;
import groovy.xml.StreamingMarkupBuilder
import java.util.Date;

import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.xpath.*
import javax.xml.namespace.*;
import org.jbpm.api.model.*
import org.springframework.transaction.annotation.*


class DocumentService implements InitializingBean {
	
	static transactional = false
	
	def cmisServiceProxy
	def dataDistributionService
	
	def domFactory
	
	// This is called after all Spring beans are initialized
	void afterPropertiesSet() {
		// Create the DocumentBuilderFactory
		domFactory =DocumentBuilderFactory.newInstance()
		domFactory.setNamespaceAware(true)
	}
	
    Wf4pNamespaceContext nsContext = new Wf4pNamespaceContext()
	
	/**
	 * Create a document binding for a Groovy script
	 * 
	 * @param document
	 * @return
	 */
    Binding binding(Document document) {		
		groovy.lang.Binding binding = new Binding()		
		binding.document=document
		return binding
	}
	
	/**
	 * Create a new XML document in the database
	 * 
	 * @param document
	 * @return
	 * @throws DocumentException
	 */
	
	def createDocument(document) throws DocumentException {
		def theDocumentId
		def startProcess=false
		def currentUserName
		def currentUser
    	Document.withNewTransaction { status ->
			log.debug "createDocument Transaction #1 - newTransaction:${status.isNewTransaction()}"
			
			currentUserName="${document?.header?.user?.name?.text()}"
			currentUser=Person.findByUsername(currentUserName)
    		def header=document.header
    		log.debug "The document id is ${header.documentId} and the type is ${header.documentType}"
    		def outputBuilder = new StreamingMarkupBuilder()

    		String xmlDocument = outputBuilder.bind{
    			// Only needed if you want <?xml etc. at the top of the XML document
    			// mkp.xmlDeclaration()
    			mkp.yield document 
    		}	
    		
    		def	documentInstance = new Document()
			documentInstance.user=header.user.name
			documentInstance.groupId=header.group
    	    
    		def documentType= DocumentType.findByName(header.documentType.text());
    		if(!documentType) {
    			throw new DocumentException("Unknown document type:"+header.documentType.text())
    		}
    		documentInstance.documentType=documentType	
    		documentInstance.xmlDocument=xmlDocument
    		documentInstance.documentStatus=header.documentStatus
			
			// Needed to get ID
    		documentInstance.save(failOnError:true,flush:true)
			
			//TODO make slurped document available to binding
    		documentInstance.documentDescription=new GroovyShell(binding(documentInstance)).evaluate("\""+documentType.descriptionTemplate+"\"")		

    		createCaseFolder(documentInstance,document)
			
    		documentInstance.save(failOnError:true,flush:true)
    		theDocumentId=documentInstance.id
    		// Get the document again because it might have changed
    		// In particular at the start of the process the jPDL can change the document
    	}
		
		
		
		Document.withNewTransaction { status ->
			log.debug "createDocument Transaction #2 - newTransaction:${status.isNewTransaction()}"
    		def documentInstance=Document.get(theDocumentId)
    		document = new XmlSlurper().parseText(documentInstance.xmlDocument)
    		def header=document.header
    		log.debug "After re-getting the document the document is now ${documentInstance.xmlDocument}"
    	
    		if (header.workflowName.text()) {
				log.debug "starting process by creating a workflow domain object"
				def workflowDefinition=WorkflowDefinition.findByName(header.workflowName.text())
    			def workflow=new Workflow()
	    		workflow.document=documentInstance
	    		workflow.workflowDefinition=workflowDefinition
	    		workflow.name=workflowDefinition.name
	    		workflow.priority=0
	    		workflow.externalId="1"
	    		workflow.workflowEngine=workflowDefinition.workflowEngine
	    		workflow.save(flush:true,failOnError:true)
	    		log.debug "Done. Workflow id = ${workflow.id}"
    		}
    		theDocumentId=documentInstance.id
	  } // withTransaction
	return 	theDocumentId
	}
	
	
	@Transactional
	def updateDocument(document)throws DocumentException {
		def theDocumentId
		def startProcess=false
		def currentUserName
		def currentUser
		//Document.withTransaction { status ->
			//println "UPDATEDOCUMENT TRANSACTION 1: ${status.isNewTransaction()}"
		
			
			currentUserName="${document?.header?.user?.name?.text()}"
			currentUser=Person.findByUsername(currentUserName)
			def header=document.header
			log.debug "The document id is ${header.documentId} and the type is ${header.documentType}"
			def outputBuilder = new StreamingMarkupBuilder()

			String xmlDocument = outputBuilder.bind{
				// Only needed if you want <?xml etc. at the top of the XML document
				// mkp.xmlDeclaration()
				mkp.yield document
			}
			def documentInstance
			
			
			def theId=header.documentId.text().asType(Integer)
			documentInstance=Document.get(theId)
			def olddocument = new XmlSlurper().parseText(documentInstance.xmlDocument)
			document.header.user=olddocument.header.user
			document.header.group=olddocument.header.user.group
			
			def documentType= documentInstance.documentType
			documentInstance.xmlDocument=xmlDocument
			documentInstance.documentStatus=header.documentStatus
			
			// Needed to get ID
			
			//TODO make slurped document available to binding
			documentInstance.documentDescription=new GroovyShell(binding(documentInstance)).evaluate("\""+documentType.descriptionTemplate+"\"")

			documentInstance.save(failOnError:true,flush:true)
			theDocumentId=documentInstance.id
			// Get the document again because it might have changed
			// In particular at the start of the process the jPDL can change the document
			
			
			// Process task part of header:
			// - transition
			// - status update
			// priority update
			
			if ((header.task?.id?.text().size()>0)) {
				def id = new java.lang.Long(header.task?.id?.text())
				def task=Task.get(id)
				task.noMessage=true
				if (header?.task?.outcome?.text().size()>0) {
					task.outcome=header.task.outcome.text()
					task.workflow.log("Completed task ${task.name} with outcome ${task.outcome}",currentUser)
					task.noMessage=false
				}
				def formatter = new SimpleDateFormat("yyyy-MM-dd")
				if (header?.task?.dueDate?.text().size()>0) {
					task.dueDate=(Date)formatter.parse(header?.task?.dueDate?.text())
					task.workflow.log("Changed due date of task ${task.name} to ${task.dueDate}",currentUser)
				}
				
				if (header?.task?.priority.text().size()>0) {
					task.priority=new java.lang.Integer(header?.task?.priority?.text())
				}
				
				if (header?.task?.status?.text().size()>0) {
					if(task.taskStatus?.name!=header.task.status.text()) {
						def theTaskStatus=TaskStatus.findByName(header.task.status.text())
						if (theTaskStatus) {
							task.taskStatus=theTaskStatus
							task.statusUser=currentUserName
							task.workflow.log("Changed status of task ${task.name} to ${task.status}",currentUser)
						}
					}
					
				}
				task.save(failOnError:true,flush:false)
			}
			// Flush is needed, otherwise indexDocument will produce an unflushed collection exception
			documentInstance.save(failOnError:true,flush:true)
			indexDocument(documentInstance)
			documentInstance.id
		//}
	}
	   
    // This is not transactional on purpose. 
    def storeDocument(document) throws DocumentException {
		if (document.header.documentId?.text().size()>0) {
			Document.withTransaction {
				def documentId=updateDocument(document)
				dataDistributionService.afterUpdate(documentId)
			}
		} else {
			createDocument(document)
		}
    }
    
	/**
	 * Get the home group of this document
	 * This is used by the JBPMService which stores this value in a process variable
	 * 
	 * @param documentInstance
	 * @return
	 */    
    def getHomeGroup(def documentInstance) {

		def homeGroup = null
		//def homeGroupInstance=identityService.findGroupsByUserAndGroupType(documentInstance.user,'home')[0]
		def person=Person.findByUsername(documentInstance.user)
		def homeGroupInstance=person?.authorities.find { it.authorityType == 'home' }
		
		if (person!=null && homeGroupInstance!=null) {
		    //homeGroup = homeGroupInstance.name
			homeGroup = homeGroupInstance.authority	
		}
		else {
		    // Fall back on identity.group.home.default if the user has no home group
			homeGroup=ApplicationConfiguration.findByConfigKey('identity.group.home.default').configValue
		}
		// Fall back on home if identity.group.home.default does not exist
		
		if (!homeGroup) {
			homeGroup="home"
		}
		return homeGroup
    }
    
	/**
	 * Create a case folder in the DMS using CMIS
	 * @param documentInstance
	 * @param document
	 * @return
	 */    
    def createCaseFolder(def documentInstance,document) {
    	String val= ApplicationConfiguration.findByConfigKey('cmis.enabled').configValue    	
    	def cmisEnabled= (val.toLowerCase()=="true" || val=="1")
    	
	    if (cmisEnabled && documentInstance.documentType.useCmis) {
	    	if (!cmisServiceProxy.initialized) {
	    		String cmisPassword= ApplicationConfiguration.findByConfigKey('cmis.password').configValue
	    		String cmisUsername= ApplicationConfiguration.findByConfigKey('cmis.username').configValue
	    		String cmisUrl = ApplicationConfiguration.findByConfigKey('cmis.url').configValue
	    		cmisServiceProxy.init(cmisUrl,cmisUsername,cmisPassword)
	    	}
			log.debug "Creating case ${documentInstance.id}"
		  	def cmisPathTemplate=documentInstance.documentType.cmisPathTemplate
	    	
	    	def cmisPath=new GroovyShell(new Binding([document:documentInstance,xmlDocument:document])).evaluate('"""'+cmisPathTemplate+'"""')
	    	cmisPath=cmisPath.trim()
	    	documentInstance.cmisPath=cmisPath
	    	documentInstance.save(failOnError:true)
	    	
	    	def pathElements=cmisPath.split("/")
	    	
	    	def parent=cmisServiceProxy.getEntryByPath("/")
	    	
	    	def path=""
	    	pathElements.each { pathElement ->
	    		if (pathElement.length()>0) {
	
		    		path+="/"+pathElement
		    		def entry=cmisServiceProxy.getEntryByPath(path)
		    		if(!entry) {
		    			cmisServiceProxy.createFolder(parent.objectId,pathElement,"Created by wfp document service")
		    			parent=cmisServiceProxy.getEntryByPath(path)
		    		} else {
		    			parent=entry
		    		}
	    		}
	    	}
	    	
	    	return cmisPath			
	
		} else {
			//log.debug "CMIS disabled, skipping case folder creation"
		}
    }

	@Transactional
    public void indexDocument(Document documentInstance){
    	println "indexing"
    	def builder = domFactory.newDocumentBuilder()
		try {
			//Document.withTransaction {
	    	def doc     = builder.parse(new ByteArrayInputStream(documentInstance.xmlDocument.bytes))
	    	def indexEntry
	    	
	    	log.debug "Context is: " + nsContext
	    	
	    	def xpath = XPathFactory.newInstance().newXPath()
			xpath.setNamespaceContext(nsContext)
			
			def slurpedDoc = new XmlSlurper().parseText(documentInstance.xmlDocument)
			
			DocumentIndex.findAllByDocument(documentInstance).each { theIndex ->
				documentInstance.removeFromDocumentIndex(theIndex)
				theIndex.delete(flush:false)
	    	}
	    	
	    	documentInstance.documentType.documentIndexField.each { field ->
				if (field.xpath && field.xpath.length()>0) {
		    		log.debug field
		    		log.debug "Processing xpath expression ${field.name} ${field.xpath} ..."
		    		
		    		def expr = xpath.compile(field.xpath)    		
		    		def nodes   = expr.evaluate(doc, XPathConstants.NODESET)
		    		
		    		// Delete any previous index keys
					/*
		    		DocumentIndex.findAllByNameAndDocument(field.name,documentInstance).each { theIndex ->
		    			documentInstance.removeFromDocumentIndex(theIndex)    			
		    			theIndex.delete(flush:false)
		    			
		    		}
		    		*/
		    		// Store all values that match the Xpath expression
					nodes.each {
						log.debug "Index field ${field.name} has value ${it.textContent}"    		  
						indexEntry=new DocumentIndex()
						indexEntry.name=field.name		  
						documentInstance.addToDocumentIndex(indexEntry)    			  
						indexEntry.value=it.textContent
						indexEntry.save(flush:false,failOnError:true)
		    		}
				}
				
				if (field.script && field.script.length()>0) {
					log.debug field
					log.debug "Processing script expression ${field.script} ..."
					
								
					def indexExpressionDelegate=new IndexExpressionDelegate([doc:slurpedDoc])
					def result=indexExpressionDelegate.run(field.script)
					def resultlist= result instanceof java.util.List?result:[result]
					
					
					// Delete any previous index keys
					DocumentIndex.findAllByNameAndDocument(field.name,documentInstance).each { theIndex ->
						documentInstance.removeFromDocumentIndex(theIndex)
						theIndex.delete(flush:false)
						
					}
					
					// Store all values that match the expression
					resultlist.each { val ->
						log.debug "Index field ${field.name} has value ${val}"
						indexEntry=new DocumentIndex()
						indexEntry.name=field.name
						documentInstance.addToDocumentIndex(indexEntry)
						indexEntry.value=val
						indexEntry.save(flush:false,failOnError:true)
					}
				}
				
				
	    	}
			//}
		} catch (Exception e) {
			log.error "Exception while indexing document ${documentInstance}: ${e.message}"
		}
    }
    
    
    
    /**
     * Get a document from the database. The header of the document is modified to reflect the current 
     * @param documentId The ID of the document to fetch
     */
    @Transactional
    def getDocument(java.lang.Long documentId) {  	
		log.debug "The document id is ${documentId}"
		def document=Document.get(documentId)		
		def xmlDocument = new XmlSlurper().parseText(document.xmlDocument)
		xmlDocument.header.taskId=""
		xmlDocument.header.taskOutcome=""    		
		xmlDocument.header.dateCreated= "${document.dateCreated.format('yyyy-MM-dd')}T${document.dateCreated.format('HH:mm:ss')}"
		xmlDocument.header.lastUpdated= "${document.lastUpdated.format('yyyy-MM-dd')}T${document.lastUpdated.format('HH:mm:ss')}"
		xmlDocument.header.user.name=document.user
		xmlDocument.header.group=document.groupId
		xmlDocument.header.documentDescription=document.documentDescription
	
		xmlDocument.header.cmis.folderUrl=document.cmisFolderUrl
		xmlDocument.header.cmis.folderObjectId=document.cmisFolderObjectId
		xmlDocument.header.cmis.path=document.cmisPath
		document.discard()
		return xmlDocument
    }
    
    // Just save the xml, nothing smart going on here ...
	@Transactional
    def setDocument(document) {  	
    	def theId=document.header.documentId.text().asType(Long)
    	def documentInstance=Document.get(theId)
    	def outputBuilder = new StreamingMarkupBuilder()
    	documentInstance.xmlDocument= outputBuilder.bind { mkp.yield document }
    	
    	// Get processingDays and completionDate from the XML
    	documentInstance.processingDays=new Double(document.header.processingDays?.text())
    	documentInstance.documentStatus=document.header.documentStatus?.text()
    	
		def formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss")
		// Fill completion date, null if unparseable
		try {
			documentInstance.completionDate=(Date)formatter.parse(document.header.completionDate?.text())
		} catch (Exception e) {
			documentInstance.completionDate=null
		}
		
    	log.debug "Setting document ${theId}"
    	log.debug documentInstance.xmlDocument
    	documentInstance.save(flush:true,failOnError:true)
		
		//dataDistributionService.afterUpdate(documentInstance.id)
    }
    
    
    /*
    def getAllDocumentHeaders(String userName,boolean userDocumentsOnly) {
    	def allDocuments
    	if(userDocumentsOnly) {
    		allDocuments=Document.findAllByUser(userName);
    	} else {
    		def groupNames=identityService.findGroupIdsByUser(userName)
    		log.debug groupNames
    		def c = Document.createCriteria()
    		allDocuments=c.list {
    			or {
    				eq("user",userName)
    				if(groupNames) {
    				'in'("groupId",groupNames)
    				}				
    			}
    		}    		
    	}
    	
    	def documentheaders    	
    	documentheaders = allDocuments.collect {
    		try {
    		  getDocument(it.id).header
    		} catch (Exception e) {
    			""
    		}	
    	}
    	return documentheaders
    }
    */
    /*
    def luceneSearch(String query, def params,String userName="",boolean userDocumentsOnly=true,boolean groupDocumentsOnly=true) {
    	if (userName!="") {
    		if(userDocumentsOnly) {
    			if (query!="" && query!="*") {
    				query="(${query}) AND user:${userName}"
    			} else {
    				query="user:${userName}"
    			}
    		} else if (groupDocumentsOnly) {
        		def groupNames=identityService.findGroupIdsByUser(userName)
        		def groupClause=""
        		groupNames.each { groupClause += " OR groupId:${it}"}
        		if (query!="" && query!="*") {
        			query="(${query}) AND (user:${userName} ${groupClause})"
        		} else {
        			query="user:${userName} ${groupClause}"
        		}
    		}
    	}
    	//params.analyzer="standard"
    	log.debug "The query is: ${query}"
    	log.debug "The query is: ${query}"
    	return searchableService.search(query, params)
    }
    */
	
    def getDocumentIndexFields() {
    	def documentIndexFields=DocumentIndexField.findAllByPublish(true)
    	documentIndexFields+=[['name':'$/Document/id','title':'Nummer'],['name':'dateCreated','title':'Aanmaak Datum'],['name':'lastUpdated','title':'Bijwerk Datum'],['name':'completionDate','title':'Eind Datum'],['name':'documentType','title':'Document Type'],['name':'documentDescription','title':'Omschrijving'],['name':'user','title':'Gebruiker'],['name':'groupId','title':'Groep'],['name':'documentStatus','title':'Status'],['name':'processingDays','title':'Doorlooptijd']]
    	documentIndexFields.sort {it.title}                      
    	                      
		return documentIndexFields
    }
    
}

class DocumentException extends Exception {
	DocumentException(String s) {super(s)};
}


public class Wf4pNamespaceContext implements NamespaceContext {

    public String getNamespaceURI(String prefix) {
        if (prefix == null) throw new NullPointerException("Null prefix");
        else if (Namespace.findByPrefix(prefix)) {        	 
        	return (Namespace.findByPrefix(prefix).uri);
        }
        else if ("xml".equals(prefix)) return XMLConstants.XML_NS_URI;
        return XMLConstants.NULL_NS_URI;
    }

    // This method isn't necessary for XPath processing.
    public String getPrefix(String uri) {
        throw new UnsupportedOperationException();
    }

    // This method isn't necessary for XPath processing either.
    public Iterator getPrefixes(String uri) {
        throw new UnsupportedOperationException();
    }

}


