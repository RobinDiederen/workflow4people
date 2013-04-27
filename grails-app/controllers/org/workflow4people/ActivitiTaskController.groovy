package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*
import org.open_t.dialog.command.Command

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.workflow4people.activiti.command.*

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class ActivitiTaskController {

    ProcessEngine activitiProcessEngine
	RepositoryService activitiRepositoryService
	ManagementService activitiManagementService
	RuntimeService activitiRuntimeService
	IdentityService activitiIdentityService
	HistoryService activitiHistoryService
	FormService activitiFormService
	TaskService activitiTaskService
	def fileService

    def index = { 	
		redirect (action:list)
	}
	
	def list() {		
		[ request:request, listConfig:TaskCommand.listConfig]
	}

	def jsonlist() {				
		def datalist=activitiTaskService.createTaskQuery()
		
		switch(params.iSortCol_0) {
			case '0':
				println "AAAA"
				datalist=datalist.orderByTaskId()
			break
						
			case '1':
				println "BBBB"
				datalist=datalist.orderByProcessInstanceId()
			break
			
		}
				
		switch (params.sSortDir_0) {
			case 'asc':
				datalist=datalist.asc()
			break
			case 'desc':
				datalist=datalist.desc()
			break
		}
		
		Integer firstResult=params.iDisplayStart?new Integer(params.iDisplayStart):0
		Integer maxResults=params.iDisplayLength?new Integer(params.iDisplayLength):10
		
		datalist=datalist.listPage(firstResult,maxResults)
		
		def totalRecords=activitiTaskService.createTaskQuery().count()

		datalist=datalist.collect { it ->
			def task = new TaskCommand(taskId:it.id) 
			task.getFrom(it)
			task
		}
		render TaskCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
	}
	
	def dialog() {
		def id=params.id.split("_")[1]
		def task=activitiTaskService.createTaskQuery().taskId(id).singleResult()		
		def taskCommand=new TaskCommand(taskId:id)
		taskCommand.getFrom(task)
		[taskCommand:taskCommand]
	}
	
	def submitdialog = { 
		TaskCommand taskCommand ->
		//def taskCommand=new TaskCommand(params)
		//taskCommand.properties = params
		
		def successFlag=false
		def resultMessage="Error occurred while saving task"		
		def activitiTask
		try {			
			activitiTask=activitiTaskService.createTaskQuery().taskId(taskCommand.taskId).singleResult()		
			activitiTask.description=taskCommand.description
			activitiTask.assignee=taskCommand.assignee
			activitiTask.priority=taskCommand.priority
			println "Setting due date to ${taskCommand.dueDate}"
			activitiTask.dueDate=taskCommand.dueDate
			activitiTask.name=taskCommand.name
			activitiTaskService.saveTask(activitiTask)
			successFlag=true
			resultMessage="Saved task ${activitiTask}"
		} catch (Exception e) {
			resultMessage=e.message	
		}
		def result = [
			success:successFlag,
			message:resultMessage,
			id: taskCommand.id
		]
		def res=[result:result]
		render res as JSON
	}
	
	def delete = {
		def id=params.id.split("_")[1]
		def success
		def message
		try {
			activitiTaskService.deleteTask(id)
			success=true
			message="Task ${id} deleted"
			
		} catch (Exception e) {
			success=false
			message=e.message
			
		}
	
		def result = [
			success:success,
			message:message,
			id: params.id
		]
		def res=[result:result]
		render res as JSON
	}
	
}
