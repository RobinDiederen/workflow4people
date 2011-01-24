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
import org.workflow4people.*;

// TODO make tFindTasks sensitive to supplied processInstanceId

/**
 * Find Tasks Endpoint 
 * SOAP service that returns a list of tasks for a given user
 * @author Joost Horward
 */
class FindTasksEndpoint implements InitializingBean {
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
	
		
		// Make sure we have an open session
		Document.withTransaction { status ->
	
		log.debug("Processing FindTasks service request ${request.name()}")
		log.debug("User id: ${request.request.userId.text()}")
		
		def max=10
		def maxText=request.request.paginate.max.text() 
		if (maxText){
			max=new Integer(maxText)
		}		
		
		def page=1
		def pageText=request.request.paginate.page.text() 
		if (pageText) {
			page=new Integer(pageText)
		}
		
		def firstResult=(page-1)*max
		def maxResults=max
		
		
		
		
		//def taskList = taskService.findPersonalTasks(request.request.userId.text())
		
		TaskQuery tq=taskService.createTaskQuery();
		tq.assignee(request.request.userId.text())
		tq.orderAsc(TaskQuery.PROPERTY_DUEDATE)		
		tq.page(firstResult,maxResults)
		log.debug "The list"
		def taskList=tq.list()
		
		TaskQuery countTq=taskService.createTaskQuery();
		countTq.assignee(request.request.userId.text())
		
		log.debug "The count"
		def personTaskCount=countTq.count()
		
		log.debug "Person task count: ${personTaskCount}"
        println "Person task count: ${personTaskCount}"
		TaskQuery grpTq=taskService.createTaskQuery();
		grpTq.candidate(request.request.userId.text())
		grpTq.orderAsc(TaskQuery.PROPERTY_DUEDATE)		
		grpTq.page(firstResult,maxResults)
		def grpTaskList=grpTq.list()
		
		TaskQuery countGrpTq=taskService.createTaskQuery();
		countGrpTq.candidate(request.request.userId.text())		
		def groupTaskCount=countGrpTq.count()
		log.debug "Group task count: ${groupTaskCount}"
		println "Group task count: ${groupTaskCount}"
		int theSize=Math.max(personTaskCount, groupTaskCount)		
		int theTotalPages=((theSize -1)/ maxResults) +1		
        
	    def response =  { FindTasksResponse(xmlns:namespace) {
	    	paginateResult {
	    		"page " (page)
	    		totalPages(theTotalPages)
	    		totalResults(theSize)
	    	}
	    	
	    	
			personalTaskList {
				taskList.each { theTask ->
					task('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
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
						
						// TODO cut this out for speed reasons really need to make it configurable
						/*
						form {
							Execution execution=executionService.findExecutionById(theTask.executionId)
							def processDefinitionId = execution.getProcessDefinitionId()
							
							ProcessDefinitionQuery pdQuery=repositoryService.createProcessDefinitionQuery()    	   
							pdQuery.processDefinitionId(processDefinitionId)			
							def processDefinition = pdQuery.uniqueResult() 			
							def processName=processDefinition.name
													
							def formName=executionService.getVariable(theTask.executionId, "formName")
							if (formName?.size()<1) formName=theTask.name
							
							def formId=executionService.getVariable(theTask.executionId, "formId")
							// TODO needs to be configurable
							
							def baseUrl=ApplicationHolder.application.getClassForName("org.workflow4people.ApplicationConfiguration").findByConfigKey('xforms.baseUrl').configValue;
							url("${baseUrl}/${processName}/${formName}/${theTask.id}/0")
						}
						*/
						/*
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
						*/						
					}
				}
        		
        	}
	    
			groupTaskList {
				grpTaskList.each { theTask ->
					task('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
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

						// TODO cut this out for speed reasons really need to make it configurable
						/*
						form {
							Execution execution=executionService.findExecutionById(theTask.executionId)
							def processDefinitionId = execution.getProcessDefinitionId()
							
							ProcessDefinitionQuery pdQuery=repositoryService.createProcessDefinitionQuery()    	   
							pdQuery.processDefinitionId(processDefinitionId)			
							def processDefinition = pdQuery.uniqueResult() 			
							def processName=processDefinition.name
													
							def formName=executionService.getVariable(theTask.executionId, "formName")
							if (formName?.size()<1) formName=theTask.name
							
							def formId=executionService.getVariable(theTask.executionId, "formId")
							
							def baseUrl=ApplicationHolder.application.getClassForName("org.workflow4people.ApplicationConfiguration").findByConfigKey('xforms.baseUrl').configValue;							
							url("${baseUrl}/${processName}/${formName}/${theTask.id}/0")
						}
						*/
						/*
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
						*/				
					}
				}
        		
        	}
			
	    }	
			
        }
		return response
		// withTransaction
		}
    }
}