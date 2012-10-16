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

import org.springframework.beans.factory.InitializingBean;
import org.codehaus.groovy.grails.commons.ApplicationHolder

import org.springframework.orm.hibernate3.SessionFactoryUtils
import org.springframework.orm.hibernate3.SessionHolder



class GetTaskEndpoint {
	def processEngine
	def workflowService
	
	def sessionFactory
		
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing GetTask service request ${request.name()}")
		log.debug("Task id: ${request.request.taskId.text()}")
		def theTask = workflowService.getTask(request.request.taskId.text())

		
		if (theTask) {
		

	    
		def response = { GetTaskResponse(xmlns:namespace) {
			org.workflow4people.Task.withTransaction {
				
				def hibSession = sessionFactory.currentSession
				theTask=hibSession.merge(theTask)
			task ('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
				assignee(theTask.assignee)
				
				description(theTask.description)
				createDate("${theTask.dateCreated.format('yyyy-MM-dd')}T${theTask.dateCreated.format('HH:mm:ss')}")
				if (theTask.dueDate) {
					dueDate("${theTask.dueDate.format('yyyy-MM-dd')}T${theTask.dueDate.format('HH:mm:ss')}")
				} else {
					dueDate('xsi:nil':'true')
				}
				executionId(theTask.workflow.id)
				name(theTask.name)
				id(theTask.id)
				priority(theTask.priority)
				form {
							def formName=theTask.form.name
							if (formName?.size()<1) formName=theTask.name							
							url("http://www.wedontcareabouttheurlanymore.org")				
							name(theTask.form.name)
						}
				processDefinitionId (theTask.workflow.workflowDefinition.id)				 
				processName(theTask.workflow.workflowDefinition.name)
				
				def outcomeList = theTask.transitions?.split(",")				
				outcomes { outcomeList.each { theOutcome ->							
						if (theOutcome!='completed') {
							outcome(theOutcome)
						}
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