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

/**
 * Get Task Endpoint
 * SOAP service that gets task details
 * @author Joost Horward
 */
package org.workflow4people.services

import org.jbpm.api.ProcessInstanceQuery;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.task.*;
import org.jbpm.pvm.internal.session.*;
import org.jbpm.api.*
import org.springframework.beans.factory.InitializingBean;
import org.codehaus.groovy.grails.commons.ApplicationHolder


class GetTaskEndpoint implements InitializingBean {
	def processEngine
	TaskService taskService
	ExecutionService executionService
	RepositoryService repositoryService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		repositoryService=processEngine.getRepositoryService()
		taskService=processEngine.getTaskService()
	}
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing GetTask service request ${request.name()}")
		log.debug("Task id: ${request.request.taskId.text()}")
		
		def theTask = taskService.getTask(request.request.taskId.text())
		if (theTask) {
		
			Execution execution=executionService.findExecutionById(theTask.executionId)
			def theProcessDefinitionId = execution.getProcessDefinitionId()
			ProcessDefinitionQuery pdQuery=repositoryService.createProcessDefinitionQuery()    	   
			pdQuery.processDefinitionId(theProcessDefinitionId)			
			def processDefinition = pdQuery.uniqueResult() 			
			def theProcessName=processDefinition.name
	    
		def response = { GetTaskResponse(xmlns:namespace) {
			task ('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
				assignee(theTask.assignee)
				description(theTask.description)
				createDate("${theTask.createTime.format('yyyy-MM-dd')}T${theTask.createTime.format('HH:mm:ss')}")
				if (theTask.duedate) {
					dueDate("${theTask.duedate.format('yyyy-MM-dd')}T${theTask.duedate.format('HH:mm:ss')}")
				} else {
					dueDate('xsi:nil':'true')
				}
				executionId(theTask.executionId)
				name(theTask.name)
				id(theTask.id)
				priority(theTask.priority)
				form {							
							
													
							def formName=executionService.getVariable(theTask.executionId, "formName")
							if (formName?.size()<1) formName=theTask.name
							
							def formId=executionService.getVariable(theTask.executionId, "formId")
							// TODO needs to be configurable
							
							def baseUrl=ApplicationHolder.application.getClassForName("org.workflow4people.ApplicationConfiguration").findByConfigKey('xforms.baseUrl').configValue;
							url("${baseUrl}/${theProcessName}/${formName}/${theTask.id}/0")
							//url("${baseUrl}/taskForm/${theTask.id}/0")
							name(theTask.formResourceName ? theTask.formResourceName : theTask.name)
						}
				
				
				processDefinitionId (theProcessDefinitionId)
				processName(theProcessName)
				def outcomeList = taskService.getOutcomes(theTask.id)				
				outcomes { outcomeList.each { theOutcome ->
						if (theOutcome!='completed') {
						outcome(theOutcome)
						}
					}
				}
				def variableNameList = taskService.getVariableNames(theTask.id)				
				variables { variableNameList.each { variableName ->							
						variable {
							name(variableName)
							value(taskService.getVariable(theTask.id, variableName))
						}
					}
				}						
			}
		}
	    }
	    return response
		} else
			throw new Exception("Task not found")        		
    }
}