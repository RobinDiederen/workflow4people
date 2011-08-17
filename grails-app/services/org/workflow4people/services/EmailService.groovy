package org.workflow4people.services

import org.workflow4people.ApplicationConfiguration
import org.workflow4people.Workflow

class EmailService {
	def documentService
	def templateService
	def wf4pConfigService
    boolean transactional = true


	def sendEmailByDocumentId(String mailTo, String mailFrom, String mailSubject, String documentId, String action) {
	  
	  def outputPath = ApplicationConfiguration.findByConfigKey('template.outputPath').configValue;
	  
		switch (action) {
			case "form-request":			
	  try {
					println "Received a request for sending mail from " + mailFrom + " to " + mailTo + " with subject " + mailSubject + " as response to action " + action + " on document " + documentId + "."
					
					def did = documentId.toLong()
					def document = documentService.getDocument(did)
					if (document) { 
						println "Fetched document with id " + did 
						
						println "Sending mail using template '${outputPath}/${document.header.documentType.text()}/mail.gsp'"
						def template = templateService.runTemplate("${outputPath}/${document.header.documentType.text()}/mail.gsp",[document:document])
						sendMail {
							to mailTo
							from mailFrom
							subject mailSubject
							html template
						}
										
						println "Mail has been sent!"
					}
	  } catch (Exception exc) { println "ERROR2: ${exc}" }					
					break				
			
			case "form-task":			
					println "Received a request for sending mail from " + mailFrom + " to " + mailTo + " with subject " + mailSubject + " as response to action " + action + " on document " + documentId + "."
					
					def did = documentId.toLong()
					def document = documentService.getDocument(did)
					if (document) { 
						println "Fetched document with id " + did 
						
						def template = templateService.runTemplate("${outputPath}/${document.header.documentType.text()}/mail.gsp",[document:document])
						sendMail {
							to mailTo
							from mailFrom
							subject mailSubject
							html template
						}
										
						println "Mail has been sent!"
					}					
					break				
				
			default:
				break			
		}
	}
	
	def sendEmailByBody(String mailTo, String mailFrom, String mailSubject, String mailMessage) {
		println "Received a request for sending mail from " + mailFrom + " to " + mailTo + " with subject " + mailSubject + "."
		
		sendMail {
			to mailTo
			from mailFrom
			subject mailSubject
			html mailMessage
		}		
	}
	
}
