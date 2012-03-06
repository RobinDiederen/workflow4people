package org.workflow4people.services

class TaskSessionService {
	def wf4pConfigService
    static transactional = true

	// Get a task session
	def getTaskSession(def taskId, def userName, def userRealName, def sessionId, def userIpAddress, def userAgent) {	
		
		BigInteger configuredTaskTimeOut = 60 //default
		BigInteger calculatedTimeOut = 0
		if (wf4pConfigService.getConfigValue("task.session.timeout")) {
			configuredTaskTimeOut = wf4pConfigService.getConfigValue("task.session.timeout") as BigInteger
		}
		calculatedTimeOut = (configuredTaskTimeOut * 1000)
		
		def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()	
		def taskInServlet = servletContext.getAttribute(taskId)
		
		if (taskInServlet) {
			BigInteger lastUpdated = taskInServlet.lastUpdated as BigInteger
			
			def cal = Calendar.instance 
			BigInteger currEpochTime = cal.time.time
			
			if ((currEpochTime - lastUpdated) > calculatedTimeOut) {
				servletContext.removeAttribute(taskId)
				return [active: false, owner: false, session: [userName: "false-nobody", userRealName: "false-nobody", lastUpdated: "", sessionId: "", userIpAddress: "", userAgent: ""]]
			} else {
				def isOwner = false
				if ((taskInServlet.userName == userName) && (taskInServlet.sessionId == sessionId) && (taskInServlet.userIpAddress == userIpAddress) && (taskInServlet.userAgent == userAgent)) {
					isOwner = true
				}
				return [active: true, owner: isOwner, session: taskInServlet]
			}
		
		} else {
			return [active: false, owner: false, session: [userName: "false-nobody", userRealName: "false-nobody", lastUpdated: "", sessionId: "", userIpAddress: "", userAgent: ""]]
		}
	}

	// Set a task session   
  def setTaskSession(def taskId, def userName, def userRealName, def sessionId, def userIpAddress, def userAgent) {
    
		BigInteger configuredTaskTimeOut = 60 //default
		BigInteger calculatedTimeOut = 0
		if (wf4pConfigService.getConfigValue("task.session.timeout")) {
			configuredTaskTimeOut = wf4pConfigService.getConfigValue("task.session.timeout") as BigInteger
		}
		calculatedTimeOut = (configuredTaskTimeOut * 1000)
		
		def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()	
		def taskInServlet = servletContext.getAttribute(taskId)
		
		def cal = Calendar.instance 
		BigInteger currEpochTime = cal.time.time
			
		if (taskInServlet) {
			BigInteger lastUpdated = taskInServlet.lastUpdated as BigInteger
			
			if ((currEpochTime - lastUpdated) > calculatedTimeOut) {
				String sLastUpdated = currEpochTime as String
				def newTaskSession = [userName: userName, userRealName: userRealName, lastUpdated: sLastUpdated, sessionId: sessionId, userIpAddress: userIpAddress, userAgent: userAgent]
				servletContext.setAttribute(taskId, newTaskSession)
				return [active: true, owner: true, session: newTaskSession]
			} else {
				def isOwner = false
				if ((taskInServlet.userName == userName) && (taskInServlet.sessionId == sessionId) && (taskInServlet.userIpAddress == userIpAddress) && (taskInServlet.userAgent == userAgent)) {
					isOwner = true
				}
				
				if (isOwner) {
					taskInServlet.lastUpdated = currEpochTime
					servletContext.setAttribute(taskId, taskInServlet)
					return [active: true, owner: true, session: taskInServlet]
				}	else {
					return [active: true, owner: false, session: taskInServlet]
				}
			}
		
		} else {
			def newTaskSession = [userName: userName, userRealName: userRealName, lastUpdated: currEpochTime, sessionId: sessionId, userIpAddress: userIpAddress, userAgent: userAgent]
			servletContext.setAttribute(taskId, newTaskSession)
			return [active: true, owner: true, session: newTaskSession]
		}
	}

	// Remove a task session
	// Can only be performed if requested by the owner of the task
	def removeTaskSession(def taskId, def userName, def userRealName, def sessionId, def userIpAddress, def userAgent) {
		
		def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()	
		def taskInServlet = servletContext.getAttribute(taskId)
		
		if (taskInServlet) {
						
			def isOwner = false
			if ((taskInServlet.userName == userName) && (taskInServlet.sessionId == sessionId) && (taskInServlet.userIpAddress == userIpAddress) && (taskInServlet.userAgent == userAgent)) {
				isOwner = true
			}
			
			if (isOwner) {
				servletContext.removeAttribute(taskId)
				return [active: false, owner: false, session: [userName: "false-nobody", userRealName: "false-nobody", lastUpdated: "", sessionId: "", userIpAddress: "", userAgent: ""]]
			} else {
				return [active: true, owner: false, session: taskInServlet]
			}
		
		} else {
			return [active: false, owner: false, session: [userName: "false-nobody", userRealName: "false-nobody", lastUpdated: "", sessionId: "", userIpAddress: "", userAgent: ""]]
		}
	}

	// Remove task sessions
	def removeTaskSessions(/*def userName, def userRealName, */def sessionId) {
		def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()
		def servletAttributesEnum = servletContext.getAttributeNames()	
		def servletAttributesList = servletAttributesEnum.toList()
		def filterList = []
		
		servletAttributesList.each { item ->
			if (item.contains('wfptid-')) {
				
				def taskInServlet = servletContext.getAttribute(item)
		
				if (taskInServlet) {
					if (/*(taskInServlet.userName == userName) && (taskInServlet.userRealName == userRealName) && */(taskInServlet.sessionId == sessionId)) {
						servletContext.removeAttribute(item)
					}
				}
				
			}
		}
		
		return true
	}
	
	// Remove a task session, using brute force
	// Can only be performed from the backend (so this is for admins)
	def removeTaskSessionBrutely(def taskId) {
			def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()
			def taskInServlet = servletContext.getAttribute(taskId)
			
			if (taskInServlet) {
				servletContext.removeAttribute(taskId)
				return "true"	
			} else {
				return "false"
			}
	}
	
	// Produce a list of all existing task sessions stored in the server session
	def listTaskSessions() {
		def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()
		def servletAttributesEnum = servletContext.getAttributeNames()	
		def servletAttributesList = servletAttributesEnum.toList()
		def filterList = []
		
		servletAttributesList.each { item ->
			if (item.contains('wfptid-')) {
				filterList.add(item)					
			}
		}			
		return filterList
	}
	
	// Give a description of a task session fit for the back-end usage
	def getTaskSessionDrescription(taskId) {
		def servletContext = org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext()		
		def taskInServlet = servletContext.getAttribute(taskId)	
		return taskInServlet		
	}
	
	def getTimeRemaining(def lastUpdated) {	
			BigInteger configuredTaskTimeOut = 60 // default in seconds, in case setting is missing in configuration menu
			BigInteger calculatedTimeOut = 0
			
			lastUpdated = lastUpdated as BigInteger
			
			if (wf4pConfigService.getConfigValue("task.session.timeout")) {
				configuredTaskTimeOut = wf4pConfigService.getConfigValue("task.session.timeout") as BigInteger
			}
			calculatedTimeOut = (configuredTaskTimeOut * 1000)
			
			def cal = Calendar.instance 
			BigInteger currEpochTime = cal.time.time
			
			return calculatedTimeOut - (currEpochTime - lastUpdated)
	}

}

