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
	CmisService cmisService
	
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
	

    //TODO make sure original user is preserved in XML when overwriting
    
    
    def storeDocument(document) throws DocumentException {
    	def theDocumentId
    	//def theDocumentIndexId
    	def hackProcessId=null
    	def hackDueDate=null
    	
    	Document.withTransaction { status ->
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
    	ProcessInstance processInstance=null
    	if (header.documentId?.text().size()>0) {    		
    		def theId=header.documentId.text().asType(Integer)	
    		if (header.taskOutcome?.text().size()>0) {
    			// find the process instance, part of the duedate hack
    			//processInstance=executionService.findExecutionById(taskService.getTask(header.taskId.text()).getExecutionId()).getProcessInstance()
    			
    			//taskService.completeTask(header.taskId.text(),header.taskOutcome.text())    			
    		}   
    		documentInstance=Document.get(theId)
    		def olddocument = new XmlSlurper().parseText(documentInstance.xmlDocument)
    		document.header.user=olddocument.header.user
    		document.header.group=olddocument.header.user.group    		

    	} else {    		
    		documentInstance = new Document()
        	documentInstance.user=header.user.name
        	documentInstance.groupId=header.group
    		startProcess=true    		
		}
    	    	
    	def documentType= DocumentType.findByName(header.documentType.text());
    	if(!documentType) {
    		throw new DocumentException("Unknown document type")
    	}
    	documentInstance.documentType=documentType	
    	documentInstance.xmlDocument=xmlDocument

    	documentInstance.documentStatus=header.documentStatus
		//return new GroovyShell(binding()).evaluate("\""+documentType.descriptionTemplate+"\"")		

    	documentInstance.save(failonError:true)

    	documentInstance.documentDescription=new GroovyShell(binding(documentInstance)).evaluate("\""+documentType.descriptionTemplate+"\"")
    	
    	if (cmisService.enabled) {
    		println "Creating case ${documentInstance.id}"
    		def cmisObjectId=cmisService.createCase(documentInstance.id)
    	
    		documentInstance.cmisFolderObjectId=cmisObjectId
    	    		
    		documentInstance.cmisFolderUrl=cmisService.caseFolderUrl(documentInstance)
    		println "The folder url is ${documentInstance.cmisFolderUrl}"
    	} else {
    		println "CMIS disabled, skipping case folder creation"
    	}
		
    	documentInstance.save(failonError:true)
    	
    	if (header.documentId?.text().size()>0) {    		
    		def theId=header.documentId.text().asType(Integer)	
    		if (header.taskOutcome?.text().size()>0) {
    			// find the process instance, part of the duedate hack
    			processInstance= executionService.findExecutionById(taskService.getTask(header.taskId.text()).getExecutionId()).getProcessInstance()
    			//OpenExecution executionInstance = (OpenExecution) executionService.findExecutionById(taskService.getTask(header.taskId.text()))    				
    			//processInstance = (OpenProcessInstance) executionInstance.getExecutionId().getProcessInstance()
    			taskService.completeTask(header.taskId.text(),header.taskOutcome.text())    			
    		}   

    	} 
    	// Get the document again because it might have changed
    	def did=documentInstance.id
    	documentInstance=Document.get(did)
    	document = new XmlSlurper().parseText(documentInstance.xmlDocument)
    	header=document.header
    	log.debug "After re-getting the document the document is now ${documentInstance.xmlDocument}"
    	
    	if (startProcess) {
    		LinkedHashMap variableMap = new LinkedHashMap()    							
    		variableMap.put("documentId",documentInstance.id)
    		variableMap.put("user",documentInstance.user)
    		// The home group is the first group that has the type home
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
    		
    		variableMap.put("group",homeGroup)
    		
			processInstance = executionService.startProcessInstanceByKey(header.documentType.text(),variableMap)
			
			// Store the document again, now with the processInstanceId in it.
			document.header.processInstanceId=processInstance.id
			document.header.documentId=documentInstance.id
			documentInstance.xmlDocument=outputBuilder.bind { mkp.yield document }
    		documentInstance.save()        					
    	}
    	
    	//Duedate hack
    	
    	if (processInstance) {
    		log.debug "Duedate hack #1"
    		hackProcessId=processInstance.id
    		//def pi=executionService.findProcessInstanceById(processInstance.id)
    		log.debug "Duedate hack #2"
    		if (executionService.findProcessInstanceById(processInstance.id)) {
    			def processDueDate = executionService.getVariable(processInstance.id,"processDueDate")
    			log.debug "Duedate hack #3"
    		
    			//def dueDate = pi.getVariable("processDueDate")
    			def dueDate = executionService.getVariable(processInstance.id,"processDueDate")
    			def theDueDate=dueDate?dueDate:processDueDate
				hackDueDate=theDueDate
    			log.debug("Not setting the due date to  ... ${theDueDate}")
    			log.debug("The process instance is ${processInstance}")
    		
    			if (theDueDate) {
    				taskService.createTaskQuery().processInstanceId(processInstance.id).list().each { task ->
    					log.debug "Setting the due date of task ${task}"
    					task.setDuedate(theDueDate)
    			}
    		}
		}	
    		
    	}
    	
    	indexDocument(documentInstance)
    	 
    	       	
    	theDocumentId=documentInstance.id
    	//documentInstance.id
	  } // withTransaction
    	
    	/*Document.withTransaction {    		
    		def di=Document.get(theDocumentId)
    		searchableService.index(di)
    	}*/
    	
    	if (hackProcessId) {
    		log.debug("Hack #2")
    		if (hackDueDate) {
    			taskService.createTaskQuery().processInstanceId(hackProcessId).list().each { task ->
    				log.debug "Setting the due date of task ${task}"
    				task.setDuedate(hackDueDate)
    				taskService.saveTask(task)
    			}
    		}
    		
    		
    	}
    	
    	
    	theDocumentId 
    }
    
    def indexDocument(Document documentInstance){
    	
    	def builder = domFactory.newDocumentBuilder()
    	def doc     = builder.parse(new ByteArrayInputStream(documentInstance.xmlDocument.bytes))
    	def indexEntry
    	
    	//documentInstance.documentIndex.each { theDoc -> 
    	//	theDoc.removeFromDocument(documentInstance)
    	//	theDoc.delete()
		//}
    	
    	def xpath = XPathFactory.newInstance().newXPath()
		xpath.setNamespaceContext(nsContext)
    	
    	documentInstance.documentType.documentIndexField.each { field ->
    		log.debug "Processing xpath expression ${field.xpath} ..."
    		
    		def expr = xpath.compile(field.xpath)    		
    		def nodes   = expr.evaluate(doc, XPathConstants.NODESET)
    		
    		// Delete any previous index keys
    		DocumentIndex.findAllByNameAndDocument(field.name,documentInstance).each { theIndex ->
    			documentInstance.removeFromDocumentIndex(theIndex)    			
    			theIndex.delete()
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
    		  indexEntry.save()
    		  
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
    
    def luceneSearch(String query, def params,String userName="",boolean userDocumentsOnly=true) {
    	if (userName!="") {
    		if(userDocumentsOnly) {
    			if (query!="" && query!="*") {
    				query="(${query}) AND user:${userName}"
    			} else {
    				query="user:${userName}"
    			}
    		} else {
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
    	println "The query is: ${query}"
    	return searchableService.search(query, params)
    }
    
    def getDocumentIndexFields() {
    	def documentIndexFields=DocumentIndexField.findAllByPublish(true)
    	documentIndexFields+=[['name':'$/Document/id','title':'Nummer'],['name':'dateCreated','title':'Aanmaak Datum'],['name':'lastUpdated','title':'Bijwerk Datum'],['name':'completionDate','title':'Eind Datum'],['name':'documentType','title':'Document Type'],['name':'documentDescription','title':'Omschrijving'],['name':'user','title':'Gebruiker'],['name':'groupId','title':'Groep'],['name':'status','title':'Status'],['name':'processingDays','title':'Doorlooptijd']]
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


