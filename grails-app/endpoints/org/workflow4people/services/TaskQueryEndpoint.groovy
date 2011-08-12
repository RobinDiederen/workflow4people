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

import org.springframework.beans.factory.InitializingBean;
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.workflow4people.*;

// TODO make tFindTasks sensitive to supplied processInstanceId

/**
 * TaskQuery Endpoint 
 * SOAP service that returns a list of tasks for a given user
 * @author Joost Horward
 */
class TaskQueryEndpoint {
	def workflowService
	def sessionFactory

	def static namespace = "http://www.workflow4people.org/services"
		
	
	def invoke = { request ->
		log.debug("Processing TaskQuery service request ${request.name()}")
		log.debug("User id: ${request.request.userId.text()}")
	
		def params=[:]
		
		if (request.request.firstResult.text()) params["offset"]=request.request.firstResult.text()		
		
		if (request.request.maxResults.text()) params["max"]=request.request.maxResults.text()
		
		if (request.request.orderAsc.text()) {			
			println "ASC"			
			params+=[sort:request.request.orderAsc.text(),order:"asc"]
		}
		
		if (request.request.orderDesc.text()) {
			println "DESC"			
			params+=[sort:request.request.orderDesc.text(),order:"desc"]
		}

		if (request.request.documentType.text()) {
			println "Requested document type " + request.request.documentType.text()
			params+=[documentType:request.request.documentType.text()]
		}
		
		if (request.request.processStatus.text()) {
			println "Requested process status " + request.request.processStatus.text()
			params+=[processStatus:request.request.processStatus.text()]
		}
		
		if (request.request.fromDueDate.text() && request.request.toDueDate.text()) {
			println "Requested date range " + request.request.fromDueDate.text() + " to " + request.request.toDueDate.text()
			params+=[fromDueDate:request.request.fromDueDate.text(),toDueDate:request.request.toDueDate.text()]
		}
		
		def res 
		if (request.request.assignee.text()) {
			println "Requested tasks for assignee " + request.request.assignee.text()
			res=workflowService.findTasksByUser(request.request.assignee.text(),params)
		}
		
		if (request.request.candidate.text()) {
			println "CANDIDATE: ${request.request.candidate.text()}"
			res=workflowService.findTasksByCandidate(request.request.candidate.text(),params)
		}
		
		
		//def res=workflowService.findTasksByUser(request.request.userId.text(),params)
		def theTaskList=res.taskList
		def theTaskCount=res.taskCount
		
	    def response =  { TaskQueryResponse(xmlns:namespace) {
	    	org.workflow4people.Task.withTransaction{
	    		def hibSession = sessionFactory.currentSession
				
			taskList {
				theTaskList.each { theTask ->
						theTask=hibSession.merge(theTask)
				
					task('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
						
						activityName(theTask.name)						
						assignee(theTask.assignee)
						
						description(theTask.description)
						
						createDate("${theTask.dateCreated.format('yyyy-MM-dd')}T${theTask.dateCreated.format('HH:mm:ss')}")
						
						if (theTask.dueDate) {
							dueDate("${theTask.dueDate.format('yyyy-MM-dd')}T${theTask.dueDate.format('HH:mm:ss')}")
						} else {
							dueDate('xsi:nil':'true')
						}
						
						executionId(theTask?.workflow?.id)
						
						
						name(theTask.name)
						id(theTask.id)
						priority(theTask.priority)
						cssClass(theTask.cssClass)
						
						form {
							def baseUrl=ApplicationHolder.application.getClassForName("org.workflow4people.ApplicationConfiguration").findByConfigKey('xforms.baseUrl').configValue;

							url("${baseUrl}/taskForm/${theTask.id}/0")
							name(theTask.form?.name)
						}
						//processDefinitionId("${theTask.workflow.workflowDefinition.name}")
						//processName("${theTask.workflow.name}")
						processStatus("${theTask.workflow?.status}")
						
						
						if (request.request.returnOutcomes.text()=="true") {
							def outcomeList = theTask.transitions.split(",")				
							outcomes { outcomeList.each { theOutcome ->							
									if (theOutcome!='completed') {
										outcome(theOutcome)
									}
								}
							}
						}
						
						
						/*
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
						*/						
					}
				}
        		
        	}	
	    	total(theTaskCount)

        	}
	    }
		}
		return response

		}

		// withTransaction
		
		
    }