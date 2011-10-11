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
 * Get Request Forms Endpoint
 * SOAP service that gets all request forms to be shown in the ui
 * @author Joost Horward
 */
package org.workflow4people.services

import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.workflow4people.*;

class GetWorkflowDefinitionsEndpoint {
	def workflowDefinitionService


	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		Document.withTransaction { status ->
			log.debug("Processing GetWorkflowDefinitions service request ${request.name()}")
		
			//def workflowDefinitionList=workflowDefinitionService.getWorkflowDefinitions(request.request.includeUnpublished.text()=="true")
			def workflowDefinitionList=workflowDefinitionService.getWorkflowDefinitions(request.request.includeUnpublished.text()=="true")
			
		  def user = Person.findByUsername(request.request.userId.text())
		  def autorities = user.getAuthorities()
		  
		  def role = Role.findByName("requestor")
		  
		  for (int i = 0; i < workflowDefinitionList.size(); i++) {
		  
		    def workflowPermissionCount = 0
		    def workflowPermissions = WorkflowPermission.withCriteria {
          eq('workflow', workflowDefinitionList[i])
          eq('role', role)
		    }
		    
		    workflowPermissions.each { wp ->
	        autorities.each { a ->
	          if (wp.authority.authority == a.authority) {
	            workflowPermissionCount++
	          }		      
	        }
		    }
		    
		    if (workflowPermissionCount == 0) {
		      workflowDefinitionList.remove(i)
		      i--
		    }
		  }
	    
			def response = { GetWorkflowDefinitionsResponse(xmlns:namespace) 
				{			
					workflowDefinitions ('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
				
						workflowDefinitionList.each { wfd ->
						workflowDefinition {							
							name(wfd.name)
							title(wfd.title)
							description(wfd.description)
							
							//if (wfd.documentType) {
								documentType(wfd.documentType?.name)
						//	}
							
							published(wfd.publish)
							
							forms {
								wfd.form.each { frm ->
									url("")
									name(frm.name)
									title(frm.title)
									description(frm.description)
									//action(frm.formAction?.name)
									}
									
								}
								
							}										
						}
					}
				}
			}
	    	return response		        		
	
		}
		
	}
}
