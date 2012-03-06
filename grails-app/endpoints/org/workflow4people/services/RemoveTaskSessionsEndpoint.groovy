package org.workflow4people.services

import org.springframework.beans.factory.InitializingBean;
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.workflow4people.*;

/**
 * RemoveTaskSession Endpoint 
 * SOAP service that removes all active task sessions of a user
 * @author Jacques Gehlen
 */
class RemoveTaskSessionsEndpoint {
	
	def taskSessionService

	def static namespace = "http://www.workflow4people.org/services"
	
	def invoke = { request ->
		log.debug("Processing RemoveTaskSessionsRequest")

		//def pUserName = request.request.userName.text()
		//def pUserRealName = request.request.userRealName.text()
		def pSessionId = request.request.sessionId.text()
		
		def taskSessionResult = taskSessionService.removeTaskSessions(/*pUserName, pUserRealName, */pSessionId)
		
		def response = {
	    RemoveTaskSessionsResponse(xmlns: namespace) {
	    	result taskSessionResult
	    }
      
    	return response
		}
	}
}
