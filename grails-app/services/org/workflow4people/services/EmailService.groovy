package org.workflow4people.services

class EmailService {
	def documentService
	def templateService
    boolean transactional = true

	def sendEmailByDocumentId(String mailTo, String mailFrom, String mailSubject, String documentId, String action) {
	
		switch (action) {
			case "form-request":			
					println "Received a request for sending mail from " + mailFrom + " to " + mailTo + " with subject " + mailSubject + " as response to action " + action + " on document " + documentId + "."
					
					def did = documentId.toLong()
					def document = documentService.getDocument(did)
					if (document) { 
						println "Fetched document with id " + did 
						
						def template = templateService.runTemplate("/Users/robindiederen/Development/MGZL/Workflow4People/wfp-forms/forms/mez/mail.gsp",[document:document])
						sendMail {
							to mailTo
							from mailFrom
							subject mailSubject
							html template
						}
										
						println "Mail has been sent!"
					}					
					break				
			
			case "form-task":			
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