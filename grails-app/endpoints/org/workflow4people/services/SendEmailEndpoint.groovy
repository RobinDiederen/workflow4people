package org.workflow4people.services
import org.apache.commons.codec.binary.Base64
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
				
				// Attachment handling
				if ((request.EmailMessage.attachmentdata.text()) && request.EmailMessage.attachmentfilename.text()) {
					log.debug "Mail with attachment"
					
					Base64 coder = new Base64()					
					String fileDataB64 = request.EmailMessage.attachmentdata.text()
					byte[] fileDataBytes = coder.decodeBase64(fileDataB64.getBytes())
					//String drs = new String(fileDataBytes)

					String attachmentFileName = request.EmailMessage.attachmentfilename.text()	
					
					emailService.sendEmailByDocumentId(mailTo, mailFrom, mailSubject, mailDocumentId, mailAction, true, fileDataBytes, attachmentFileName)
				} else {
					log.debug "Mail without attachment"
					emailService.sendEmailByDocumentId(mailTo, mailFrom, mailSubject, mailDocumentId, mailAction, false, null, null)					
				}								
			
			} else if ((request.EmailMessage.from.text()) && (request.EmailMessage.to.text()) && (request.EmailMessage.to.text()) && (request.EmailMessage.message.text()))  {
				mailMessage = request.EmailMessage.message.text()
				emailService.sendEmailByBody(mailFrom, mailTo, mailSubject, mailMessage)				
			
			} else {
			log.debug "Not all of the required arguments for sending an email have been specified, not sending mail…"	
			}
		}
	}
}