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

import org.apache.commons.io.FileUtils;

class DocumentService implements InitializingBean {
	
	static transactional = false
	
	def cmisServiceProxy
	def dataDistributionService
	def jmsService
	
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
		binding.doc=new XmlSlurper().parseText(document.xmlDocument)
		return binding
	}
	
	/**
	 * Create a new XML document in the database
	 * 
	 * @param document slurped XML document
	 * @return
	 * @throws DocumentException
	 */
	
	def createDocument(document,source="service") throws DocumentException {
		def startProcess=false
		def currentUserName
		def currentUser
		
		def theDocumentId
		def xmlDocument
    	Document.withNewTransaction { status ->
			log.debug "createDocument Transaction #1 - newTransaction:${status.isNewTransaction()}"
			
			currentUserName="${document?.header?.user?.name?.text()}"
			currentUser=Person.findByUsername(currentUserName)
    		def header=document.header
    		log.debug "The document id is ${header.documentId} and the type is ${header.documentType}"
			
			def documentType= DocumentType.findByName(header?.documentType?.text());
			if(!documentType) {
				throw new RuntimeException("Unknown document type:"+header?.documentType?.text())
			}
			
			def	documentInstance = new Document(name:'new',
												documentType:documentType,
												documentStatus:header?.documentStatus?.text(),
												user:header?.user?.name.text(),
												groupId:header?.group?.text()
												).save(failOnError:true,flush:true)
			
    		def outputBuilder = new StreamingMarkupBuilder()			
			document.header.documentId=documentInstance.id

    		documentInstance.xmlDocument = outputBuilder.bind{
    			// Only needed if you want <?xml etc. at the top of the XML document
    			// mkp.xmlDeclaration()
    			mkp.yield document 
    		}	
			
			documentInstance.documentDescription=new GroovyShell(binding(documentInstance)).evaluate("\""+documentType.descriptionTemplate+"\"")
			documentInstance.name=new GroovyShell(binding(documentInstance)).evaluate("\""+documentType.nameTemplate+"\"")
			
			moveDocumentToDefaultPath(documentInstance,document)
			
    		createCaseFolder(documentInstance,document)
			generateOfficeDoc(documentInstance,document)
			
    		documentInstance.save(failOnError:true,flush:true)
    	/*	theDocumentId=documentInstance.id
    		// Get the document again because it might have changed
    		// In particular at the start of the process the jPDL can change the document?!
    	}
		
		Document.withNewTransaction { status ->
			log.debug "createDocument Transaction #2 - newTransaction:${status.isNewTransaction()}"
    		def documentInstance=Document.get(theDocumentId)
    		document = new XmlSlurper().parseText(documentInstance.xmlDocument)
    		def header=document.header
    		log.debug "After re-getting the document the document is now ${documentInstance.xmlDocument}"
    	*/
    		if (header.workflowName.text()) {
				log.debug "starting process by creating a workflow domain object"
				def workflowDefinition=WorkflowDefinition.findByName(header.workflowName.text())
				if (workflowDefinition && workflowDefinition.run) {
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
    		}
			theDocumentId=documentInstance.id
			xmlDocument=documentInstance.xmlDocument
    		
	  } // withNewTransaction
		def msg=[eventType:"afterCreateDocument",source:source,xmlDocument:xmlDocument]
		jmsService.send(topic:"wfp.event",msg,"standard",null)
	return 	theDocumentId
	}
	
	
	@Transactional
	def updateDocument(document,source="service")throws DocumentException {
		def theDocumentId
		def startProcess=false
		def currentUserName
		def currentUser
		String xmlDocument
		//Document.withTransaction { status ->
			//println "UPDATEDOCUMENT TRANSACTION 1: ${status.isNewTransaction()}"
		
			
			currentUserName="${document?.header?.user?.name?.text()}"
			currentUser=Person.findByUsername(currentUserName)
			def header=document.header
			log.debug "The document id is ${header.documentId} and the type is ${header.documentType}"
			def outputBuilder = new StreamingMarkupBuilder()

			xmlDocument = outputBuilder.bind{
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
			def msg=[eventType:"afterUpdateDocument",source:source,xmlDocument:xmlDocument]
			jmsService.send(topic:"wfp.event",msg,"standard",null)
			
		//}
	}
	   
    // This is not transactional on purpose. 
    def storeDocument(document,source="service") throws DocumentException {
		if (document?.header?.documentId?.text().size()>0) {
			Document.withTransaction {
				def documentId=updateDocument(document,source)

			}
		} else {
			createDocument(document,source)
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
	    	
			cmisServiceProxy.createPath(cmisPath)			
	    	return cmisPath			
	
		} else {
			//log.debug "CMIS disabled, skipping case folder creation"
		}
    }
	
	private boolean initializeCMIS(docInstance) {
		if (cmisServiceProxy.initialized) {
			return true
		} else {
			// Is CMIS enabled in application
			String value = ApplicationConfiguration.findByConfigKey('cmis.enabled').configValue
			def cmisEnabled = (value.toLowerCase() == "true" || value == "1")
			// Is CMIS enabled in documentType
			if (cmisEnabled && docInstance.documentType.useCmis) {
				String cmisPassword= ApplicationConfiguration.findByConfigKey('cmis.password').configValue
				String cmisUsername= ApplicationConfiguration.findByConfigKey('cmis.username').configValue
				String cmisUrl = ApplicationConfiguration.findByConfigKey('cmis.url').configValue
				cmisServiceProxy.init(cmisUrl,cmisUsername,cmisPassword)
			}
		}
		return cmisServiceProxy.initialized
	}
	
	/**
	 * Create a docx or odt document in the DMS using CMIS
	 * @param documentInstance
	 * @param document
	 * @return
	 */
	def generateOfficeDoc(def documentInstance,document) {
		def result
		
		// Do not run without script block
		if (!(document?.documentType?.cmisDocumentScript?.size()>0)) {
			return // do nothing
		}
		
		// Init CMIS if needed
		if (!initializeCMIS(documentInstance)) {
			return // do nothing
		}
		
		// Get values from script
		def officeDocConfig = new OfficeDocConfigDelegate(documentInstance, document)
		def cmisResultFile = officeDocConfig.processedDocumentFileName
		def cmisResultPath = officeDocConfig.processedDocumentFilePath
		def cmisTemplFilePath  = officeDocConfig.processedTemplateFilePath //including file
		def fieldMap = officeDocConfig.processedDocumentFields

		// Validate the cmis path values
		def templateInCmis = (cmisTemplFilePath) ? cmisServiceProxy.getObjectByPath(cmisTemplFilePath) : null
		if (!templateInCmis) {
			log.error "No Document template found"
			return
		}
		def resultPathInCmis
		if (cmisResultPath) {
			resultPathInCmis = cmisServiceProxy.getObjectByPath(cmisResultPath)
			if (!resultPathInCmis) {
				resultPathInCmis = cmisServiceProxy.createPath(cmisResultPath)
			} else if (cmisResultFile) {
				def cmisObject = cmisServiceProxy.getObjectByPath(new File(cmisResultPath, cmisResultFile).toString())
				if (cmisObject) {
					log.error "Duplicate result file"
					return
				}
			} else {
				log.error "No result filename"
				return
			}
		} else {
			log.error "No Document result path"
			return
		}

		// Create a local workdir
		String myUUID = UUID.randomUUID().toString()
		String tmpDir = System.getProperty("java.io.tmpdir")
		File workFolder = new File(tmpDir, "WF4P_" + myUUID)
		workFolder.mkdirs()
		
		try	{
			// Template file
			File tmpFile = new File(workFolder, "template.zip")
		
			// Download template from cmis
			BufferedOutputStream outputStream = null
			try {
				outputStream = new BufferedOutputStream(new FileOutputStream(tmpFile))
				outputStream << templateInCmis.contentStream.stream
			} finally {
				outputStream?.close()
			}
		
			File unzipFolder = new File(workFolder, "/unzip")
			
			// Extract document
			AntBuilder antBuilder = new AntBuilder()
			HashMap<String, Object> extractParams = new HashMap<String, Object>()
			extractParams.put("src", tmpFile)
			extractParams.put("dest", unzipFolder)
			extractParams.put("overwrite", "true")
			antBuilder.invokeMethod("unzip", extractParams)
			
			// Read document content (content.xml or word/document.xml)
			def content = new File(unzipFolder, "/word/document.xml") //DOCX
			if (!content.exists()) {
				content = new File(unzipFolder, "/content.xml") //ODT
			}
			String contentString = FileUtils.readFileToString(content, "UTF-8");
			
			// Replace placeHolders with values
			fieldMap?.each { key, value ->
				contentString = contentString.replaceAll('\\$\\{' + key + '\\}', value)
			}
			
			// Write new content back
			FileUtils.writeStringToFile(content, contentString, "UTF-8");
			
			// Result file
			tmpFile = new File(workFolder, "result.zip")

			// Create document
			HashMap<String, Object> createParams = new HashMap<String, Object>();
			createParams.put("destfile", tmpFile);
			createParams.put("basedir", unzipFolder);
			createParams.put("includes", "**/*.*");
			createParams.put("excludes", "");
			createParams.put("encoding", "UTF-8");
			antBuilder.invokeMethod("zip", createParams);
		
			// Upload file to cmis
			result = cmisServiceProxy.createDocument(resultPathInCmis, tmpFile.toString(), cmisResultFile)
		} finally {
			// Remove from tmp dir
			if (workFolder?.exists()) {
				FileUtils.deleteDirectory(workFolder)
			}
		}
		
		return result
	}
	
	
	/**
	 * Move document to it's default path
	 * Create the path if it doesn't exist
	 * @param documentInstance
	 * @param document
	 * @return
	 */
	@Transactional
	def moveDocumentToDefaultPath(def documentInstance,document) {
		
		log.debug "Creating document path folder for ${documentInstance.id}"
		def pathTemplate=documentInstance.documentType.pathTemplate
		
		def path=new GroovyShell(new Binding([document:documentInstance,xmlDocument:document])).evaluate('"""'+pathTemplate+'"""')
    	path=path.trim()
    	
    	def pathElements=path.split("/")
    	
    	def parent=null
    	
    	def currentPath=""
    	pathElements.each { pathElement ->
    		if (pathElement.length()>0) {
				
	    		currentPath+="/"+pathElement
	    		def doc=Document.findByNameAndParent(pathElement,parent)
				
	    		if(!doc) {				
					def documentType=parent?.documentType?.defaultChildDocumentType 
					documentType=documentType?:DocumentType.findByName('Folder')
					doc=new Document(name:pathElement,documentDescription:pathElement,documentType:documentType,xmlDocument:"""<test></test>""")
					doc.parent=parent
					doc.save(failOnError:true)	    			
	    			parent=doc	    			
	    		} else {
					if (doc!=documentInstance) {
						parent=doc
					}
	    		}
	    		
    		}
    	}
		
		documentInstance.parent=parent
		documentInstance.save(failOnError:true)
		
    	return path
    					
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
						log.debug "Index field ${field.name} has value ${it.textDocument}"    		  
						indexEntry=new DocumentIndex()
						indexEntry.name=field.name		  
						documentInstance.addToDocumentIndex(indexEntry)    			  
						indexEntry.value=it.textDocument
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
		log.trace "The document id is ${documentId}"
		def document=Document.get(documentId)
		if (!document) throw new RuntimeException("Document ${documentId} does not exist")
		def xmlDocument = new XmlSlurper().parseText(document.xmlDocument)
		xmlDocument.header.taskId=""
		xmlDocument.header.taskOutcome=""    		
		xmlDocument.header.dateCreated= "${document.dateCreated.format('yyyy-MM-dd')}T${document.dateCreated.format('HH:mm:ss')}"
		xmlDocument.header.lastUpdated= "${document.lastUpdated.format('yyyy-MM-dd')}T${document.lastUpdated.format('HH:mm:ss')}"
		xmlDocument.header.user.name=document.user
		xmlDocument.header.group=document.groupId
		xmlDocument.header.documentDescription=document.documentDescription
	
		//xmlDocument.header.cmis.folderUrl=document.cmisFolderUrl
		xmlDocument.header.cmis.folderObjectId=document.cmisFolderObjectId
		xmlDocument.header.cmis.path=document.cmisPath
		//document.discard()
		return xmlDocument
    }
    
	/**
	 * Just save the xml, nothing smart going on here ...
	 * @param document a Slurped XML document
	 * @return
	 */
	@Transactional
    def setDocument(document,source="service") {  	
    	def theId=document.header.documentId.text().asType(Long)
    	def documentInstance=Document.get(theId)
		if (!documentInstance) throw new RuntimeException("Document ${theId} does not exist")
		
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
		
    	log.trace "Setting document ${theId}"
    	log.trace documentInstance.xmlDocument
    	documentInstance.save(flush:true,failOnError:true)
		
		def msg=[eventType:"afterSetDocument",source:source,xmlDocument:documentInstance.xmlDocument]
		jmsService.send(topic:"wfp.event",msg,"standard",null)
    }
   
    def getDocumentIndexFields() {
    	def documentIndexFields=DocumentIndexField.findAllByPublish(true)
    	documentIndexFields+=[['name':'$/Document/id','title':'Nummer'],['name':'dateCreated','title':'Aanmaak Datum'],['name':'lastUpdated','title':'Bijwerk Datum'],['name':'completionDate','title':'Eind Datum'],['name':'documentType','title':'Document Type'],['name':'documentDescription','title':'Omschrijving'],['name':'user','title':'Gebruiker'],['name':'groupId','title':'Groep'],['name':'documentStatus','title':'Status'],['name':'processingDays','title':'Doorlooptijd']]
    	documentIndexFields.sort {it.title}                      
    	                      
		return documentIndexFields
    }
	
	
	
	///// copied in from contentService HERE
	
	
	/**
	 * Find a content object based on it's path
	 * Returns null if the object cannot be found
	 * @param path
	 * @return Document object
	 */
	def findByPath(path) {
		def pathElements=path?path.split("/"):[]
		def content=null
		pathElements.each { pathElement ->
			content=Document.findByParentAndName(content,pathElement)
		}
		return content?.active?content:null
	}
	
	/**
	 * Find a file attachment URL based on it's path
	 * @param path
	 * @return URL
	 */
	def findFileUrlByPath(path) {
		dialogService.check(path!=null && path.contains.("/"),"content.findFileUrlByPath.invalidpath")
		def lastSlash=path.lastIndexOf('/');
		def contentPath=path.substring(0,lastSlash)
		def filename=path.substring(lastSlash+1)
		dialogService.check(filename!=null,"content.findFileUrlByPath.missingfilename")
		def content=findByPath(contentPath)
		dialogService.check(content!=null,"content.findFileUrlByPath.notfound")
		def url=fileService.fileUrl(Document,content.id,"images")+"/${filename}"
	}
	
	/**
	 * Recursively copy content
	 * @param content
	 * @return
	 */
	
	def treeCopy(Document content) {
		log.trace "Copying content ${content.id} ($content.name})"
		def copyDocument=new Document()
		def domainClass=grailsApplication.getDomainClass('org.catviz.Document')
		domainClass.persistentProperties.each { prop ->
			if (prop.name!="children" && prop.name !="contentHistory") {
				copyDocument."${prop.name}" = content."${prop.name}"
			}
		}
		Document.findAllByParent(content).each { childDocument ->
			log.debug "CHILDCONTENT ${childDocument}"
			def copyChildDocument=treeCopy(childDocument)
			copyDocument.addToChildren(copyChildDocument)

			
		}
		return copyDocument
	}
	
	/**
	 * Recursively delete content tree
	 * UNNECESSARY! the delete just cascades
	 * TODO check if we need to check templates and layouts for orphanage
	 *
	 * @param content
	 * @return
	 */
	def treeDelete(Document content) {
		log.trace "deleting ${content}"
		dialogService.check(content!=null,"content.treeDelete.contentisnull")
		Document.findAllByParent(content).each { childDocument ->
			log.trace "deleting child content ${childDocument}"
			treeDelete(childDocument)
		}
		//content.parent=null
		//content.delete(flush:true)
		content.delete()
	}
	
	/**
	 * Move content to another location
	 * @param content1 The content to be moved
	 * @param content2 The destination reference content
	 * @param where The postion relative to content2 where content1 should be placed. May be "inside", "before" or "after"
	 * @return
	 */
	def moveDocument(Document content1,Document content2,String where){		
		def originalParent=content1.parent
		
		switch(where) {
		
			case "inside":
				content1.parent=content2
				content1.save(flush:true)
				def maxPosition=Document.findAllByParent(content2,[sort:'position',order:'desc',max:1])[0]?.position
				content1.position=maxPosition ? maxPosition+1 : 1
				content1.save(flush:true)
				break
				
			case "before":
				content1.parent=content2.parent
				
				def position=content2.position
				content1.position=content2.position
				content1.save(flush:true)
				
				def n=1
				Document.findAllByParent(content2.parent,[sort:'position',order:'asc']).each { content ->
					content.position=n++
					content.save(flush:true)
					log.debug "${content.name}: ${content.position}"
				}
								
				if (content1.position>content2.position) {
					log.debug "Swapping ${content1.id} and ${content2.id}"
					swapDocumentPosition(content1,content2)
				}
				
				Document.findAllByParent(content2.parent,[sort:'position',order:'asc']).each { content ->
					log.debug "${content.name}: ${content.position}"
				}
				
														
				break
			case "after":
				
				content1.parent=content2.parent
				
				def position=content2.position
				content1.position=content2.position
				content1.save(flush:true)
				
				def n=1
				Document.findAllByParent(content2.parent,[sort:'position',order:'asc']).each { content ->
					content.position=n++
					content.save(flush:true)
				}
				
				if (content1.position<content2.position) {
					swapDocumentPosition(content1,content2)
				}
								
				break
		}
		// Fix the positions of the original part of the tree
		if(originalParent) {
			def n=1
			Document.findAllByParent(originalParent,[sort:'position',order:'asc']).each { content ->
			content.position=n++
			content.save(flush:true)
		}
	
		}
		
		
		
	}
	
	/**
	 * Swap position of 2 items in a position-sorted list
	 * Ietms should have a 'position' property
	 * @param item1
	 * @param item2
	 * @return
	 */
	def swapPosition(item1,item2) {
		def p1= item1.position
		def p2 = item2.position
		item1.position=p2
		item2.position=p1
	}
	
	/**
	 * Swap 2 position of 2 content items
	 * @param item1
	 * @param item2
	 * @return
	 */
	def swapDocumentPosition(item1,item2) {
		def p1= item1.position
		def p2 = item2.position
		item1.position=p2
		item2.position=p1
		item1.save(flush:true)
		item2.save(flush:true)
	}
	
	/**
	 * Convert string into camelCase
	 * @param s
	 * @return camelCased String
	 */
	def camelCase(String s) {
		return s.substring(0,1).toLowerCase()+s.substring(1)
	}
	
	
    
}

class DocumentException extends Exception {
	DocumentException(String s) {
		super(s)
	};
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


