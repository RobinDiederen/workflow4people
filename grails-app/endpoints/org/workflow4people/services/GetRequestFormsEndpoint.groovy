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


class GetRequestFormsEndpoint {
	def formService
	
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing GetRequestForms service request ${request.name()}")
		
		def requestForms=formService.getRequestForms(request.request.userId.text(),request.request.includeUnpublished.text()=="true")
	    
		def response = { GetRequestFormsResponse(xmlns:namespace) 
				{			
					forms ('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
				
						requestForms.each { requestForm ->
						form {				
							def baseUrl=ApplicationHolder.application.getClassForName("org.workflow4people.ApplicationConfiguration").findByConfigKey('xforms.baseUrl').configValue;
							url("${baseUrl}/request/${requestForm.workflow.name}/${requestForm.name}")
							name(requestForm.name)
							title(requestForm.title)
							description(requestForm.description)
							action(requestForm.formAction.name)
						}										
					}
				}
			}
	    	return response		        		
		}
	}
}