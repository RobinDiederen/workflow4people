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

import org.jbpm.api.ExecutionService;
import org.springframework.beans.factory.InitializingBean;

/**
 * Start Process Instance Endpoint
 * SOAP service that starts a process instance.
 * @author Joost Horward
 */
class StartProcessInstanceEndpoint implements InitializingBean {
	
	def processEngine
	ExecutionService executionService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
	}

	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing StartProcessInstance service request ${request.name()}")
		log.debug("ProcessDefinition id: ${request.request.processDefinitioId.text()}")
		
		def pi=null
		
		LinkedHashMap variableMap = new LinkedHashMap()
		request.request.variables.variable.each { v ->					
			variableMap.put(v.name.text(), v.value.text())			
		}
		
		if (variableMap.size()>0) {
			if (request.request.processDefinitionId.text()) {
				pi = executionService.startProcessInstanceById(request.request.processDefinitionId.text(),variableMap)
			} else {
				pi = executionService.startProcessInstanceByKey(request.request.processDefinitionKey.text(),variableMap)
			}
		} else {
			if (request.request.processDefinitionId.text()) {
				pi = executionService.startProcessInstanceById(request.request.processDefinitionId.text())
			} else {
				pi = executionService.startProcessInstanceByKey(request.request.processDefinitionKey.text())
			}
		}
		
	    def response = { StartProcessInstanceResponse(xmlns:namespace) 
    		{
				ProcessInstance ('xmlns:xsi':'http://www.w3.org/2001/XMLSchema-instance') {
					id(pi.id)
					key(pi.key)
					name(pi.name)
					state(pi.state)
					priority(pi.priority)
					
					isEnded(pi.isEnded())
					isSuspended(pi.isSuspended())						
				}
			}
	    }
	    return response
	    
		     		
    }
}