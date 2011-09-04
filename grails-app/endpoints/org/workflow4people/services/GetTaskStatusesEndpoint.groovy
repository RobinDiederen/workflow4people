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
 * Get Task Statuses Endpoint
 * SOAP service that gets all task statuses to be used in forms
 * @author Joost Horward
 */
package org.workflow4people.services

import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.workflow4people.*;

class GetTaskStatusesEndpoint {
	def workflowService


	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		TaskStatus.withTransaction { status ->
			log.debug("Processing GetTaskStatuses service request ${request.name()}")
		
			//def workflowDefinitionList=workflowDefinitionService.getWorkflowDefinitions(request.request.includeUnpublished.text()=="true")
			def taskStatusList=workflowService.getTaskStatuses()
			
		
	    
			def response = { GetTaskStatusesResponse(xmlns:namespace) 
				{			
					taskStatuses ('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
				
						taskStatusList.each { ts ->
						taskStatus {							
							name(ts.name)
							title(ts.title)
							description(ts.description)
							cssClass(ts.cssClass)							
								
							}										
						}
					}
				}
			}
	    	return response		        		
	
		}
		
	}
}