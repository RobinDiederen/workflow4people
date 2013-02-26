/*

 * Workflow4people
 * Copyright 2009-2011, Open-T B.V., and individual contributors as indicated
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

/*
 * Event listener for events in data distrubution 
 * @author Joost Horward
 */
package org.workflow4people.services
import org.workflow4people.*
import grails.plugin.jms.*
import groovy.xml.StreamingMarkupBuilder
import org.apache.activemq.Message
import org.apache.activemq.ScheduledMessage

class DataDistributionService {
	def jmsService
	def documentService
	def wf4pConfigService
	static transactional=false
	static exposes = ['jms']
	/*
	 * Send message containing document to queue
	 * Fetches the document from the document service and sends the entire document in the message
	 */
	def sendMessage(topic,documentId,event){
		def wfpid=wf4pConfigService.getConfigValue("wfp.id")		
		log.debug "sending document ${documentId} to topic ${topic}"
		def outputBuilder = new StreamingMarkupBuilder()
		//Document.withTransaction { trx ->		
			def document=documentService.getDocument(documentId)	
			document.header.remote.master=wfpid
			String xmlDocument = outputBuilder.bind{
				// Only needed if you want <?xml etc. at the top of the XML document
				// mkp.xmlDeclaration()
				mkp.yield document
			}
			jmsService.send(topic:topic,[id:documentId,document:xmlDocument,event:event],"dds")  { 
				Message msg ->
				msg.setProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY,5000)
			}
		//}
		log.debug "sending document ${documentId} to topic ${topic} completed"				 
	}
	
	/*
	 * Used after a document is updated, notify other wfp instances
	 */	
	
	@Subscriber(topic="wfp.event")
	void eventHandler(msg) {
		log.debug "Received wfp.event message: ${msg}"
		def topic="wfp.remote.rx"
		//
		if (msg.source!='dds' && msg.eventType in ['afterCreateDocument','afterSetDocument','afterUpdateDocument']) {
			
			def wfpid=wf4pConfigService.getConfigValue("wfp.id")			
			def outputBuilder = new StreamingMarkupBuilder()

			def document = new XmlSlurper().parseText(msg.xmlDocument)
			
			//figure out if we have remote recipients
			if (document.header.remote?.recipients?.id?.size()>0) {
				log.debug "We have recipients ( ${document.header.remote?.recipients} ), so we'll send a message to the remote wfp"
				document.header.remote.originator=wfpid
				String xmlDocument = outputBuilder.bind{
					// Only needed if you want <?xml etc. at the top of the XML document
					// mkp.xmlDeclaration()
					mkp.yield document
				}
				// Tell the world!
				jmsService.send(topic:topic,[id:document.header.documentId.text(),document:xmlDocument,event:msg.eventType],"dds")  {
					Message theMsg ->
					theMsg.setProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY,5000)
				}
				log.debug "sending document ${document.header.documentId.text()} to topic ${topic} completed"
			}
						
		}
		return null	
	}
	
	void afterUpdate(documentId) {
		println "DDS AFTERUPDATE"
		def doc=documentService.getDocument(documentId)
		log.debug "Recipients: ${doc.header.remote?.recipients}"
		if(doc.header.remote?.recipients) {
			sendMessage("wfp.remote.tx",documentId,'update') 
		}			    
  	}
	
	/*
	 * Used after a document is created, notify other wfp instances
	 * This is an unusual case where we know already at creation time that remote wfp's will be involved
	 */
	
	void afterInsert(documentId) {
		def doc=documentService.getDocument(documentId)
		
		if(doc.header.remote?.recipients) {
			sendMessage("wfp.remote.tx",documentId,'new') 
		}
	}
	
	/*
	 * Notify other nodes of deletion of a document.
	 * This happens just BEFORE the actual deletion so that we can still send the document in the message
	 * After deletion essential information such as the recipient list is lost
	 */
	void beforeDelete(documentId) {documentInstance=documentInstance.merge()
		sendMessage("wfp.remote.tx",documentId,'delete')	
    }
	
	/*
	 * Check if the local XML store contains a document that relates to the given remote document
	 * The masterDocumentId is one of the dynamic index fields so it cannot be done using a simple query
	 */
	def getLocalDocument (doc){
		// Check if we already know this document
		//def masterDocumentIdIndexField=DocumentIndexField.findByName("masterDocumentId")
		//def masterIndexField=DocumentIndexField.findByName("masterDocumentId")
		
		// get the master document Id and master id
		def masterDocumentId=doc.header.remote.masterDocumentId.text()
		def master=doc.header.remote.master.text()
		
		// Get all the index entries for this master document id (that will be for any master)
		def docindex=DocumentIndex.findByNameAndValue("index_masterDocumentId",masterDocumentId)
		
		return docindex?.document
	}
	
	def reparse(xml){
		def outputBuilder= new StreamingMarkupBuilder()
		String result = outputBuilder.bind { mkp.yield xml }
		println "The reparsing result result is ${result}"
		return new XmlSlurper().parseText(result)
	}
	
	/*
	 * Receive remote notification message
	 * There is a single remote queue per wfp instance now, this ensures messages are always processed in the right order 
	 */
	
	@Subscriber(topic="wfp.remote.rx")
	def ddsrx(msg) {
			
		// get document
		log.debug "wfp.remote.rx received: ${msg.id}"
		def doc = new XmlSlurper().parseText(msg.document)
		log.debug "Received Recipients: ${doc.header.remote?.recipients} Master: ${doc.header.remote?.master}"
		
		// Check if it's for me
		def wfpid=wf4pConfigService.getConfigValue("wfp.id")
		log.debug "My id is ${wfpid}"
		def forMe=doc.header.remote?.recipients.id.findAll { it.text() == wfpid }.size()>0
		log.debug "forMe=${forMe}"		
		// Only respond if it's for me and it's not my own message
		if (forMe && doc.header.remote.originator.text()!=wfpid) {
			def localDoc=getLocalDocument(doc)
			
			// yes -> update document
			if (localDoc) {
				log.debug "update"
				def localXmlDocument=new XmlSlurper().parseText(localDoc.xmlDocument)
				def newXmlDocument=doc
				
				newXmlDocument.header.replaceNode { mkp.yield (localXmlDocument.header)   }
				newXmlDocument=reparse(newXmlDocument)
				// Set the outcome. This needs some sanity checking! We might be in the wrong state for this...				
				newXmlDocument.header.task.outcome=doc.header.remote.remoteOutcome.text()
				
				def localProcessId=localXmlDocument.header.processInstanceId.text()
				def workflow=Workflow.get(localProcessId)
				// This needs a sanity check!!!!
				def taskId=Task.findByWorkflow(workflow).id
				println "The task id is ${taskId}"
				newXmlDocument.header.task.id=taskId
				
				newXmlDocument=reparse(newXmlDocument)
				
				documentService.storeDocument(newXmlDocument,"dds")
				log.debug "update - completed"
			} else {
			// no -> create new document
				// Massage the header
				log.debug "new"
				doc.header.documentId=""
				doc.header.outcome=""
				doc.header.taskId=""
				doc.header.user.name=doc.header.remote.master?.text()
				doc.header.user.displayName=doc.header.remote.master?.text()
				doc.header.user.email="test@test.test"
				doc.header.group=doc.header.remote.master?.text()
				documentService.storeDocument(doc,"dds")
				log.debug "new - completed"
			}
		} else {
			log.debug "Not processed."
		}
		
		return null
	}
}