/*

 * Workflow4people
 * Copyright 2009-2010, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */
package org.workflow4people
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

import org.jbpm.api.task.*;
import org.jbpm.api.*;
import org.jbpm.api.identity.*
import org.springframework.beans.factory.InitializingBean;
/**
 * Controller for WfpTask domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class Wf4pTaskController implements InitializingBean {
	def processEngine
	def currentTime
	ExecutionService executionService
	def repositoryService
	TaskService taskService
	IdentityService identityService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		repositoryService=processEngine.getRepositoryService()
		taskService=processEngine.getTaskService()
		identityService=processEngine.getIdentityService()
	}
	
	
	
    def index = { }
    
    def show = {
    	def task = taskService.getTask(params.taskId)
    	def processInstance=executionService.findExecutionById(task.executionId).getProcessInstance()
    	["task":task,"taskService":taskService,"processInstance":processInstance]
    }
	
	def complete = {
			def theOutcome = params._action_complete
			org.jbpm.api.task.Task task = taskService.getTask(params.taskId)
	    	flash.message = "Task &quot;${task.name}&quot; (${params.taskId}) completed with outcome &quot;${theOutcome}&quot;"
	    		
	    	// get the processInstanceId and processDefinitionId from this task 
			Execution execution=executionService.findProcessInstanceById(task.executionId)
			ProcessInstance processInstance=execution.getProcessInstance() 
			
			def processInstanceId=processInstance.getId()
			def processDefinitionId=execution.getProcessDefinitionId()
			
	    	// Complete the task with indicated outcome
			
	    	taskService.completeTask(params.taskId,theOutcome)
	    	// If the process instance has not ended, go back to it.
	    	// If not, go back to the process definition list
	    	if(executionService?.findProcessInstanceById(processInstanceId)) {
	    		def theParams = ['processInstanceId':processInstanceId]
	    		redirect(controller:'wf4pProcessInstance',action:'show',params:theParams)
	    		
	    	} else {
	    		def theParams = ['processDefinitionId':processDefinitionId]
	    		redirect(controller:'wf4pProcessDefinition',action:'show',params:theParams)	
	    	}
			
	}
	
	def list = {
		
		def taskTotal=taskService.createTaskQuery().count();		
		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
		params.offset = params.offset ? params.offset?.toInteger():0
	
				
		def query = taskService.createTaskQuery();
	

		query.page(params.offset,params.max)
		
		["taskList":query.list(),"taskService":taskService,taskTotal:taskTotal,params:params]
	}
	
	def userlist = {
				
				def userList=identityService.findUsers().sort({it.familyName+it.givenName})
				if(!params.userId){
					params.userId=userList[0].getId()
				}
				def taskTotal = taskService.createTaskQuery().assignee(params.userId).count()
				
				
				params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
				params.offset = params.offset ? params.offset?.toInteger():0
				
				def personalTaskList=taskService.createTaskQuery().assignee(params.userId).orderDesc(TaskQuery.PROPERTY_CREATEDATE).page(params.offset,params.max).list()
								
				
				["personalTaskList":personalTaskList,"taskService":taskService,"userList":userList,params:params,taskTotal:taskTotal]
			
		}
    
	def grouplist = {
			
			def userList=identityService.findUsers().sort({it.familyName+it.givenName})
			if(!params.userId){
				params.userId=userList[0].getId()
			}
			def taskTotal = taskService.createTaskQuery().candidate(params.userId).count()
			
			
			params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
			params.offset = params.offset ? params.offset?.toInteger():0
			
			def groupTaskList=taskService.createTaskQuery().candidate(params.userId).orderDesc(TaskQuery.PROPERTY_CREATEDATE).page(params.offset,params.max).list()
							
			
			["groupTaskList":groupTaskList,"taskService":taskService,"userList":userList,params:params,taskTotal:taskTotal]
		
	}

    
    
    
}
