package org.workflow4people

import grails.plugins.springsecurity.Secured

import java.text.SimpleDateFormat

@Secured(['ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class TaskSessionController {
	def taskSessionService
	def wf4pConfigService
	
	def index = { 
		redirect(action: "list")
	}
	
	def list = {
		def taskSessionList = taskSessionService.listTaskSessions()
		
		def taskSessionIntList = []
		taskSessionList.each { item ->
			taskSessionIntList.add(item.substring(item.indexOf('-') + 1) as Integer)
		}
		taskSessionIntList.sort()
		
		def taskSessionMap = []
		
		taskSessionIntList.each { item ->
			def taskSessionItem = taskSessionService.getTaskSessionDrescription("wfptid-${item}")
			
			def lastUpdatedLong = new Long(taskSessionItem.lastUpdated.toString())
			def lastUpdatedDate = new Date(lastUpdatedLong)
			def dateTimeformatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss")
			def lastUpdated = dateTimeformatter.format(lastUpdatedDate)
			
			def timeRemaining = taskSessionService.getTimeRemaining(lastUpdatedLong)
			def hoursRemaining = ((timeRemaining/(1000*60*60)) as Long) % 24;
			def minutesRemaining = ((timeRemaining/(1000*60)) as Long) % 60;
			def secondsRemaining = ((timeRemaining/1000) as Long) % 60;
			def timeRemainingStr = ""
			if (timeRemaining > 0) {
				timeRemainingStr = "time left: ${hoursRemaining > 9 ? hoursRemaining : '0' + hoursRemaining}:${minutesRemaining > 9 ? minutesRemaining : '0' + minutesRemaining}:${secondsRemaining > 9 ? secondsRemaining : '0' + secondsRemaining}";
			} else {
				timeRemainingStr = """<span style="font-weight: bold;">timed out</span>"""
			}
			
			println "taskSessionItem: ${taskSessionItem}"
			def itemMap = [taskId: item, userName: taskSessionItem.userName, userRealName: taskSessionItem.userRealName, sessionId: taskSessionItem.sessionId, userIpAddress: taskSessionItem.userIpAddress, userAgent: taskSessionItem.userAgent, lastUpdated: lastUpdated + " (" + timeRemainingStr + ")"]
			taskSessionMap.add(itemMap)
		}
		
		[taskSessionList: taskSessionMap]
	}
	
	def remove = {
		taskSessionService.removeTaskSessionBrutely("wfptid-${params.id}")
		
		redirect(action: "list")
	}

}

