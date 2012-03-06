package org.workflow4people.services

import org.springframework.beans.factory.InitializingBean;
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.workflow4people.*;

/**
 * GetTaskSession Endpoint 
 * SOAP service that returns session for a task
 * @author Robin Diederen
 * @author Jacques Gehlen
 */
class GetTaskSessionEndpoint {
	
	def taskSessionService

	def static namespace = "http://www.workflow4people.org/services"
	
	def invoke = { request ->
		log.debug("Processing GetTaskSessionRequest")

		def pTaskId = request.request.taskId.text()
		def pUserName = request.request.userName.text()
		def pUserRealName = request.request.userRealName.text()
		def pSessionId = request.request.sessionId.text()
		def pUserIpAddress = request.request.userIpAddress.text()
		def pUserAgent = request.request.userAgent.text()
		
		def taskSessionResult
		if (pTaskId) {
			taskSessionResult = taskSessionService.getTaskSession(pTaskId, pUserName, pUserRealName, pSessionId, pUserIpAddress, pUserAgent)
		}
		
		def response = {
	    GetTaskSessionResponse(xmlns: namespace) {
	    	active taskSessionResult.active
	    	owner taskSessionResult.owner
	    	session {
	    		 taskId pTaskId
	    		 userName taskSessionResult.session.userName
	    		 userRealName taskSessionResult.session.userRealName
	    		 lastUpdated taskSessionResult.session.lastUpdated
	    		 sessionId taskSessionResult.session.sessionId
	    		 userIpAddress taskSessionResult.session.userIpAddress
	    		 userAgent taskSessionResult.session.userAgent
	    	}
	    }
      
    	return response
		}
	}
}
