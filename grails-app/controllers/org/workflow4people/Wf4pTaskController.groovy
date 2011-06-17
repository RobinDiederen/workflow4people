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
import grails.plugins.springsecurity.Secured

import org.jbpm.api.task.*;
import org.jbpm.api.*;
import org.jbpm.api.identity.*
import org.springframework.beans.factory.InitializingBean;
import groovy.xml.StreamingMarkupBuilder

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
	def documentService
	
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
	
    def reassign = {
	    
	    if (params.taskId) {
	    
	        def taskInstance = taskService.getTask(params.taskId)
	        
            if (!taskInstance) {
                flash.message = "task.not.found"
                flash.args = [params.taskId]
                flash.defaultMessage = "Task not found with id ${params.taskId}"
                redirect(action: (params.previousAction == "userlist" ? params.previousAction : "list"))
                return
            }
            else if (!taskInstance.assignee) {
                flash.message = "task.can.not.be.reassigned"
                flash.args = [params.taskId]
                flash.defaultMessage = "Task with id ${params.taskId} can not be reassigned"
                redirect(action: (params.previousAction == "userlist" ? params.previousAction : "list"))
                return
            }
            else {
                def currentAssignee = identityService.findUserById(taskInstance.assignee)
                // TODOD this should be the task group, and if it doesn't exist there should be no error but the full list of users.
                def groupName = taskService.getVariable(params.taskId, "group")
                if (groupName) {
                    def group = Authority.findByAuthority(groupName)
                    def userList = group.getPeople().sort({it.familyName+it.givenName})
                    return [taskInstance: taskInstance, currentAssignee: currentAssignee, userList: userList]
                }
                else {
                    flash.message = "task.has.invalid.group"
                    flash.args = [params.taskId]
                    flash.defaultMessage = "Task with id ${params.taskId} has an invalid group variable"
                    redirect(action: (params.previousAction == "userlist" ? params.previousAction : "list"))
                    return
                }
            }
            
        }
        else {
            flash.message = "task.not.found"
            flash.args = [params.taskId]
            flash.defaultMessage = "Task not found with id ${params.taskId}"
            redirect(action: (params.previousAction == "userlist" ? params.previousAction : "list"))
        }
	    
	}
	
	def doreassign = {
	    
	    def taskInstance = taskService.getTask(params.taskId)
	    
	    if (taskInstance && taskInstance.assignee) {
	        
            def currentAssignee = identityService.findUserById(taskInstance.assignee)
	        //def userList = identityService.findUsers().sort({it.familyName+it.givenName})
	        
	        def groupId = taskService.getVariable(params.taskId, "group")
	        if (!groupId) {
                flash.message = "group.not.found"
                flash.args = [params.taskId]
                flash.defaultMessage = "Group variable not found for task id ${params.taskId}"
                render(view: "reassign", model: [taskInstance: taskInstance, currentAssignee: currentAssignee, userList: userList])
                return
	        }
            def group = Authority.findByAuthority(groupId)
            def userList = group.getPeople().sort({it.familyName+it.givenName})
	        
	        if (params.taskVersion) {
	            def taskVersion = params.taskVersion.toInteger()
	            if (taskInstance.dbversion > taskVersion) {
	                
	                flash.message = "task.optimistic.locking.failure"
                    flash.args = [params.taskId]
                    flash.defaultMessage = "Another user has updated this Task while you were editing"
                    render(view: "reassign", model: [taskInstance: taskInstance, currentAssignee: currentAssignee, userList: userList])
                    return
                }
            }
            
	        def reassignTo = identityService.findUserById(params.reassignTo)
	        params.reassignTo = (params.reassignTo == "" ? null : params.reassignTo)
	        
	        if (/*(!params.reassignTo || */reassignTo/*)*/ && params.reassignTo != taskInstance.assignee) {
	        
	            try {
	                //if (!params.reassignTo) {
                    //    if (!groupId) {
                    //        flash.message = "group.not.found"
                    //        flash.args = [params.taskId]
                    //        flash.defaultMessage = "Group variable not found for task id ${params.taskId}"
                    //        render(view: "reassign", model: [taskInstance: taskInstance, currentAssignee: currentAssignee, userList: userList])
                    //        return
                    //    }
	                ///    taskService.addTaskParticipatingGroup(params.taskId, groupId, Participation.CANDIDATE) 
	                //}
	                
	                executionService.setVariable(taskInstance.getExecutionId(), "user", params.reassignTo)
	                
	                taskService.assignTask(params.taskId, params.reassignTo)
	                
	                flash.message = "task.reassigned"
                    flash.args = [params.taskId]
                    flash.defaultMessage = "Task ${params.taskId} has been reassigned to ${params.reassignTo ? params.reassignTo : 'the group ' + groupId}"
                    redirect(action: "show", params: [taskId: params.taskId])
	            }
	            catch (Exception e) {
	                flash.message = "task.exception"
                    flash.args = [params.taskId]
                    flash.defaultMessage = "An error occurred while reassigning the task (${e.getMessage()})"
                    render(view: "reassign", model: [taskInstance: taskInstance, currentAssignee: currentAssignee, userList: userList])
	            }
	        
	        }
	        else {
                flash.message = "task.reassignTo.invalid"
                flash.args = [params.taskId]
                flash.defaultMessage = "The user you selected is invalid"
                render(view: "reassign", model: [taskInstance: taskInstance, currentAssignee: currentAssignee, userList: userList])
                return
	        }	        
	    }
	    else {
            flash.message = "task.not.found"
            flash.args = [params.taskId]
            flash.defaultMessage = "Task not found with id ${params.taskId}"
            redirect(action: "list")
	    }
	    
	}
    
}
