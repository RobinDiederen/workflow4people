package org.workflow4people.services

import org.workflow4people.*;

class SendEmailEndpoint {
	def emailService
	def documentService
	
	def static namespace = "http://www.workflow4people.org/services"
				
	def invoke = { request ->
	
		log.debug "Received SOAP request for sending an email message!"
		
		def mailFrom = ""
		def mailTo = ""
		def mailSubject = ""
		def mailDocumentId = ""
		def mailAction = ""
		def mailMessage = ""
		
		if ((request.EmailMessage.from.text()) && (request.EmailMessage.to.text()) && (request.EmailMessage.to.text()) && (((request.EmailMessage.documentId.text()) && (request.EmailMessage.action.text())) || (request.EmailMessage.message.text()))) {
			
			mailFrom = request.EmailMessage.from.text()
			mailTo = request.EmailMessage.to.text()
			mailSubject = request.EmailMessage.subject.text()
		
			if ((request.EmailMessage.documentId.text()) && (request.EmailMessage.action.text())) {
				mailDocumentId = request.EmailMessage.documentId.text()
				mailAction = request.EmailMessage.action.text()
				
				emailService.sendEmailByDocumentId(mailTo, mailFrom, mailSubject, mailDocumentId, mailAction)
			
			} else if ((request.EmailMessage.from.text()) && (request.EmailMessage.to.text()) && (request.EmailMessage.to.text()) && (request.EmailMessage.message.text()))  {
				mailMessage = request.EmailMessage.message.text()
				emailService.sendEmailByBody(mailFrom, mailTo, mailSubject, mailMessage)				
			
			} else {
			log.debug "Not all of the required arguments for sending an email have been specified, not sending mail…"	
			}
		}
	}
}