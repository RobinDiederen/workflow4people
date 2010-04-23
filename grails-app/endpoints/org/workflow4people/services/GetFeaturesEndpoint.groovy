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
import org.workflow4people.services.SecurityService;


/**
 * Get Features Endpoint 
 * SOAP service that returns a list of features available to a given user
 * @author Joost Horward
 */
class GetFeaturesEndpoint {
	def securityService

	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing Authenticate service request ${request.name()}")
		
		def theFeatures=securityService.getFeatures(request.request.userName.text())
		
		def response = {GetFeaturesResponse(xmlns:namespace) 
			{ 
				features {
					theFeatures.each { theFeature ->
						feature(theFeature)
					}					
				}
			}               
		}
		return response
    }
}