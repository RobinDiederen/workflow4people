/*

 * Workflow4people
 * Copyright 2009-2010, Open-T B.V., and individual contributors as indicated
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

import org.jbpm.api.ExecutionService;
import org.jbpm.api.IdentityService;
import org.jbpm.api.TaskService;
import org.jbpm.api.* 
import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.xpath.*
import javax.xml.namespace.*;
import org.jbpm.api.model.*

import org.compass.core.engine.SearchEngineQueryParseException

class DocumentService implements InitializingBean {
	
	static transactional = true
	def processEngine
	TaskService taskService
	ExecutionService executionService
	IdentityService identityService
	def cmisServiceProxy
	
	def domFactory
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()		
		taskService=processEngine.getTaskService()
		identityService=processEngine.getIdentityService()
		
		domFactory =DocumentBuilderFactory.newInstance()
		domFactory.setNamespaceAware(true)
	}
	
	
    
    Wf4pNamespaceContext nsContext = new Wf4pNamespaceContext()
	def  searchableService
    
    Binding binding(Document document) {		
		groovy.lang.Binding binding = new Binding()		
		binding.document=document
		return binding
	}
	   
    
    def storeDocument(document) throws DocumentException {
    	def theDocumentId
    	
    	Document.withTransaction { status ->
			def currentUser="${document?.header?.user?.name?.text()}"
    		def header=document.header
    		log.debug "The document id is ${header.documentId} and the type is ${header.documentType}"
    		def outputBuilder = new StreamingMarkupBuilder()

    		String xmlDocument = outputBuilder.bind{
    			// Only needed if you want <?xml etc. at the top of the XML document
    			// mkp.xmlDeclaration()
    			mkp.yield document 
    		}	
    		def documentInstance
    		// If the document ID is known, store the document over the existing one
    		// If the document ID is not known, store a new instance, and start a new workflow
    	
    		def startProcess=false
    		//ProcessInstance processInstance=null
    		
    		
    		if (header.documentId?.text().size()>0) {    		
    			def theId=header.documentId.text().asType(Integer)
    		// Pushed down to make it transaction aware	
    		//	if (header.taskOutcome?.text().size()>0) {    			
    		//		taskService.completeTask(header.taskId.text(),header.taskOutcome.text())    			
    		//	}   
    			// For an existing document, the owner remains the owner.
    			documentInstance=Document.get(theId)
    			def olddocument = new XmlSlurper().parseText(documentInstance.xmlDocument)
    			document.header.user=olddocument.header.user
    			document.header.group=olddocument.header.user.group    		

			} else {
				// For a new document, the requestor becomes the owner
				documentInstance = new Document()
				documentInstance.user=header.user.name
				documentInstance.groupId=header.group
				startProcess=true    		
			}
    	    
    		def documentType= DocumentType.findByName(header.documentType.text());
    		if(!documentType) {
    			throw new DocumentException("Unknown document type:"+header.documentType.text())
    		}
    		documentInstance.documentType=documentType	
    		documentInstance.xmlDocument=xmlDocument
    		documentInstance.documentStatus=header.documentStatus
		
    		documentInstance.save(failOnError:true)
    		documentInstance.documentDescription=new GroovyShell(binding(documentInstance)).evaluate("\""+documentType.descriptionTemplate+"\"")
    		
    		createCaseFolder(documentInstance,document)		
    		documentInstance.save(failOnError:true)
    	
    		// Get the document again because it might have changed
    		// In particular at the start of the process the jPDL can change the document
    		
    		documentInstance=Document.get(documentInstance.id)
    		document = new XmlSlurper().parseText(documentInstance.xmlDocument)
    		header=document.header
    		log.debug "After re-getting the document the document is now ${documentInstance.xmlDocument}"
    	/*
	    	if (startProcess) {
	    	
	    		LinkedHashMap variableMap = new LinkedHashMap()    							
	    		variableMap.put("documentId",documentInstance.id)
	    		variableMap.put("user",documentInstance.user)
	    		variableMap.put("group",getHomeGroup(documentInstance))
	    		
				processInstance = executionService.startProcessInstanceByKey(header.workflowName.text(),variableMap)
			
	    		
				// Store the document again, now with the processInstanceId in it.
				document.header.processInstanceId=processInstance.id
				document.header.documentId=documentInstance.id
				documentInstance.xmlDocument=outputBuilder.bind { mkp.yield document }
	    		documentInstance.save(failOnError:true)        					
			}*/
    		
    		if (startProcess) {
    			log.debug "starting process by creating a workflow domain object"
    			def workflow=new Workflow()
	    		workflow.document=documentInstance
	    		def workflowDefinition=WorkflowDefinition.findByName(header.workflowName.text())
	    		workflow.workflowDefinition=workflowDefinition
	    		workflow.name=workflowDefinition.name
	    		workflow.priority=0
	    		workflow.externalId="1"
	    		workflow.workflowEngine=workflowDefinition.workflowEngine
	    		workflow.save(failOnError:true)
	    		log.debug "Done."
    		}
    		/*
    		if ((header.taskId?.text().size()>0) && (header.taskOutcome?.text().size()>0)) {    			
				//taskService.completeTask(header.taskId.text(),header.taskOutcome.text())
				def id = new java.lang.Long(header.taskId?.text())
				def task=Task.get(id)
				task.outcome=header.taskOutcome?.text()
				task.save(failOnError:true)
			}
			*/
			
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
					task.noMessage=false
				}
				def formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss")				
				if (header?.task?.dueDate?.text().size()>0) {
					task.dueDate=(Date)formatter.parse(header?.task?.dueDate?.text())
				}
				
				if (header?.task?.priority.text().size()>0) {
					task.priority=new java.lang.Integer(header?.task?.priority?.text())
				}
				
				if (header?.task?.status?.text().size()>0) {
					if(task.taskStatus?.name!=header.task.status.text()) {
						def theTaskStatus=TaskStatus.findByName(header.task.status.text())
						if (theTaskStatus) {
							task.taskStatus=theTaskStatus
							task.statusUser=currentUser
						}
					} 
					
				}
				task.save(failOnError:true)
			}
			   
    		
    	
    		indexDocument(documentInstance)

    		//theDocumentId=documentInstance.id
    		documentInstance.id
	  } // withTransaction
    }
    
    
    def getHomeGroup(def documentInstance) {

		def homeGroup = null
		def homeGroupInstance=identityService.findGroupsByUserAndGroupType(documentInstance.user,'home')[0]
		if (homeGroupInstance) {
		    homeGroup = homeGroupInstance.name
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
	    	documentInstance.save()
	    	
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


    def indexDocument(Document documentInstance){
    	
    	def builder = domFactory.newDocumentBuilder()
    	def doc     = builder.parse(new ByteArrayInputStream(documentInstance.xmlDocument.bytes))
    	def indexEntry
    	
    	//documentInstance.documentIndex.each { theDoc -> 
    	//	theDoc.removeFromDocument(documentInstance)
    	//	theDoc.delete()
		//}
    	
    	log.debug "Context is: " + nsContext
    	
    	def xpath = XPathFactory.newInstance().newXPath()
		xpath.setNamespaceContext(nsContext)
    	
    	documentInstance.documentType.documentIndexField.each { field ->
    		log.debug field
    		log.debug "Processing xpath expression ${field.xpath} ..."
    		
    		def expr = xpath.compile(field.xpath)    		
    		def nodes   = expr.evaluate(doc, XPathConstants.NODESET)
    		
    		// Delete any previous index keys
    		DocumentIndex.findAllByNameAndDocument(field.name,documentInstance).each { theIndex ->
    			documentInstance.removeFromDocumentIndex(theIndex)    			
    			theIndex.delete(flush:true)
    			
    		}
    		// Store all values that match the Xpath expression
    		nodes.each {
    		  log.debug "Index field ${field.name} has value ${it.textContent}"    		  
    		  //indexEntry=DocumentIndex.findByNameAndDocument(field.name,documentInstance)
    		  //if (!indexEntry){
    			  indexEntry=new DocumentIndex()
    		  	  indexEntry.name=field.name
    			  //indexEntry.document=documentInstance
    			  //indexEntry.addToDocument(documentInstance)
    		  
    			  documentInstance.addToDocumentIndex(indexEntry)
    			  
    		  //}
    		  indexEntry.value=it.textContent
    		  indexEntry.save(flush:true)
    		  //theDocumentIndexId=indexEntry.id
    		}
    	}
    	//searchableService.index(documentInstance)
    }
    
    
    
    
    
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
    	
    	return xmlDocument
    }
    
    // Just save the xml, nothing smart going on here ...
    def setDocument(document) {  	
    	def theId=document.header.documentId.text().asType(Long)
    	def documentInstance=Document.get(theId)
    	def outputBuilder = new StreamingMarkupBuilder()
    	documentInstance.xmlDocument= outputBuilder.bind { mkp.yield document }
    	
    	// Get processingDays and completionDate from the XML
    	documentInstance.processingDays=new Double(document.header.processingDays.text())
    	documentInstance.documentStatus=document.header.documentStatus.text()
    	def formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss")
    	documentInstance.completionDate=(Date)formatter.parse(document.header.completionDate.text())
    	log.debug "Setting document ${theId}"
    	log.debug documentInstance.xmlDocument
    	documentInstance.save()
    }
    
    
    
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


