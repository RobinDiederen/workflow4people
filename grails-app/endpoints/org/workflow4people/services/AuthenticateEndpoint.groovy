/*
 * Workflow4people
 * Copyright 2009, Open-T B.V., and individual contributors as indicated
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
import org.workflow4people.*
/**
 * Take Task Endpoint
 * SOAP service that takes a task from a taks pool and assigns that task to a user.
 * @author Joost Horward
 */

class AuthenticateEndpoint {
	def securityService
	

	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing Authenticate service request ${request.name()}")
		
		def theAccess=securityService.authenticate(request.request.userName.text(),request.request.password.text())
		
		def person
		def theFeatures
		def userGroupList=[]
		
		if (theAccess) {
			Person.withTransaction {
				
				person=securityService.getPerson(request.request.userName.text())
				def p=org.workflow4people.Person.get(person.id)
				theFeatures=securityService.getFeatures(request.request.userName.text())
				try {
					userGroupList=p?.authorities?.sort { it.authority }
				} catch (Exception e) {
					log.error e.message
				}
			
				log.debug "The person is ${person} ${theFeatures}"
				def response = { AuthenticateResponse(xmlns:namespace) {
					access(theAccess)
			
		
					if (theAccess) {				
						userDetails {
							name (person.username)					
							realName(person.userRealName)
							familyName(person.familyName)
							givenName(person.givenName)
							email(person.email)					
							features {					
								theFeatures.each { theFeature ->
									feature(theFeature)							
								}						
							}
						}
						userGroups {
							userGroupList.each { aUserGroup ->
									userGroup {
										name aUserGroup.authority
											description aUserGroup.description
											type aUserGroup.authorityType
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
}