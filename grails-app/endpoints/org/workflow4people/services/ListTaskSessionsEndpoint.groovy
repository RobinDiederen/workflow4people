package org.workflow4people.services

import org.springframework.beans.factory.InitializingBean;
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.workflow4people.*;

/**
 * ListTaskSessionsEndpoint Endpoint 
 * SOAP service that returns active sessions, if found
 * @author Robin Diederen
 */
class ListTaskSessionsEndpoint {
	def workflowService
	def sessionFactory
	def documentService
	def taskSessionService

	def static namespace = "http://www.workflow4people.org/services"
	
	def invoke = { request ->
		log.debug("Processing ListTaskSessionsRequest")

		def listTaskSessionsResult
		listTaskSessionsResult = taskSessionService.listTaskSessions()

		def response = {
		    getTaskSessionResponse(xmlns: namespace) {
		    	taskSessions listTaskSessionsResult
	    }
      
    	return response
  		}
	}
}