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
 * TaskQuery Endpoint 
 * SOAP service that returns a list of tasks for a given user
 * @author Joost Horward
 */
class TaskQueryEndpoint implements InitializingBean {
	def processEngine
	TaskService taskService
	ExecutionService executionService
	RepositoryService repositoryService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		repositoryService=processEngine.getRepositoryService()
		taskService=processEngine.getTaskService()
	}
	
	def createTaskQuery (request) {
		TaskQuery tq=taskService.createTaskQuery();
		
		if (request.request.activityName.text()) {
			tq.assignee(request.request.activityName.text())
		}
		
		if (request.request.assignee.text()) {
			tq.assignee(request.request.assignee.text())
		}
		
		if (request.request.candidate.text()) {
			tq.candidate(request.request.candidate.text())
		}
		
		if (request.request.suspended.text()=="true") {
			tq.suspended()
		}
		
		if (request.request.suspended.text()=="false") {
			tq.notSuspended()
		}
		
		if (request.request.orderAsc.text()) {
			println "ASC"
			tq.orderAsc(request.request.orderAsc.text())
		}
		
		if (request.request.orderDesc.text()) {
			println "DESC"
			tq.orderDesc(request.request.orderDesc.text())
		}
		
		
		
		if (request.request.processDefinitionId.text()) {
			tq.processDefinitionId(request.request.processDefinitionId.text())
		}
		
		if (request.request.processInstanceId.text()) {
			tq.processInstanceId(request.request.processInstanceId.text())
		}
		
		if (request.request.unassigned.text()=="true") {
			println "UNASSIGNED"
			tq.unassigned()
		}
		
		return tq
	}
	

	def static namespace = "http://www.workflow4people.org/services"
		
	
	def invoke = { request ->
	
		
		// Make sure we have an open session
		Document.withTransaction { status ->
	
		log.debug("Processing TaskQuery service request ${request.name()}")
		log.debug("User id: ${request.request.userId.text()}")
		
		TaskQuery tq =createTaskQuery(request)

		if (request.request.firstResult.text() && request.request.maxResults.text()) {			
			//tq.page(new Integer(request.request.firstResult.text()),new Integer(request.request.maxResults.text()))			
		}
		def theTaskList=tq.list()
		// Poor man's pagination, the one in Hibernate doesn't work properly with JBPM somehow
		if (request.request.firstResult.text() && request.request.maxResults.text()) {
			int first=new Integer(request.request.firstResult.text())
			int last=first+new Integer(request.request.maxResults.text())-1
			def tl=[]
			for (i in first..last) {
				if (theTaskList[i]) {
					tl+=theTaskList[i]
				}
			}
			theTaskList=tl
				
		}
		
		
		log.debug "The count"
		
		TaskQuery countTq =createTaskQuery(request)
		
		def taskCount=countTq.count()
		
		println "TASKCOUNT: ${taskCount}"
		
	    def response =  { TaskQueryResponse(xmlns:namespace) {
	    	
			taskList {
				theTaskList.each { theTask ->
				
				
					task('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
						
						activityName(theTask.activityName)						
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
							def baseUrl=ApplicationHolder.application.getClassForName("org.workflow4people.ApplicationConfiguration").findByConfigKey('xforms.baseUrl').configValue;

							url("${baseUrl}/taskForm/${theTask.id}/0")
							name(theTask.formResourceName ? theTask.formResourceName : theTask.name)
						}
						
						if (request.request.returnOutcomes.text()=="true") {
							def outcomeList = taskService.getOutcomes(theTask.id)				
							outcomes { outcomeList.each { theOutcome ->							
									if (theOutcome!='completed') {
										outcome(theOutcome)
									}
								}
							}
						}
						
						if (request.request.returnVariables.text()=="true") {
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
        		
        	}	
	    	total(taskCount)

        	}
		}
		return response

		}

		// withTransaction
		}
		
    }