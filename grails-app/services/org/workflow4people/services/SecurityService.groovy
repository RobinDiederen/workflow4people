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
import org.workflow4people.*;
import org.grails.plugins.springsecurity.service.*
import org.springframework.security.*;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken

/**
 * Security service class
 * Provides the security services that are exposed through web services
 *
 * @author Joost Horward
 */

class SecurityService {
	AuthenticateService authenticateService
	AuthenticationManager authenticationManager

    boolean transactional = true
    
    boolean hasAccessToForm(String username,String workflowName,String formName,String documentId, String action) {
    	def hasAccess=false
    	
    	Person.withTransaction {
    	Person user=Person.findByUsername(username)
    	def workflow=WorkflowDefinition.findByName(workflowName)
    	def form
    	if(formName) {
    		form=Form.findByWorkflowAndName(workflow,formName)
    	}
    	
    	
    	if(form) {
    	user.authorities.each { authority ->
			def fpa=FormPermission.findAllByAuthorityAndForm(authority,form)
			fpa.each { fp ->
				fp.role?.roleAction?.each { roleAction -> 
					if (action==roleAction.name) {
						hasAccess=true
						return true
					}
				}
			}
    	}
    	}
    	
    	user.authorities.each { authority ->
			def wpa=WorkflowPermission.findAllByAuthorityAndWorkflow(authority,workflow)
			wpa.each { wp ->
				wp?.role?.roleAction?.each { roleAction -> 
					if (action==roleAction.name) {
						hasAccess=true
						return true
					}
				}
			}
		}
		
    	}
		return hasAccess			
	}
    
    def getFeatures(String username) {
    	def features=[]
    	Person.withTransaction {
    	Person user=Person.findByUsername(username)
    	user.authorities.each { authority ->
    		def fp=FeaturePermission.findAllByAuthority(authority)
    			fp.each { theFp ->
    				theFp.role?.roleAction?.each { roleAction -> 
    				if ("show"==roleAction.name) {
    					features+=theFp.feature.name
    				}
				}
    		}
    	}
    	}
    	return features
    }
    
    def authenticate(String username, String password) {
    	try {
    	  def token = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password))
    	} catch (AuthenticationException authenticationException) {
    		return false
    	}
    	return true    	
    }
    
    def getPerson(String username) {
    	return Person.findByUsername(username)    	
    }
    
}
