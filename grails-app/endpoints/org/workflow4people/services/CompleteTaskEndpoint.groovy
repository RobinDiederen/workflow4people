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
import org.jbpm.api.TaskService;
import org.jbpm.api.task.*;
import org.springframework.beans.factory.InitializingBean;

import java.util.*;


/**
 * Complete Task Endpoint 
 * SOAP service that completes a task
 * @author Joost Horward
 */
class CompleteTaskEndpoint implements InitializingBean {
	def processEngine
	TaskService taskService
	
	void afterPropertiesSet() {
		taskService=processEngine.getTaskService()
	}

	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing CompleteTask service request ${request.name()}")
		log.debug("Task id: ${request.request.taskId.text()} - Outcome: ${request.request.outcome.text()}")
		
		LinkedHashMap variableMap = new LinkedHashMap()
		request.request.variables.variable.each { v ->					
			variableMap.put(v.name.text(), v.value.text())			
		}
		log.debug("The variable map is: ${variableMap}")
		
		if (variableMap.size()>0) {
			taskService.completeTask(request.request.taskId.text(),request.request.outcome.text(),variableMap)
		} else {
			taskService.completeTask(request.request.taskId.text(),request.request.outcome.text())
		}
		
		def response = { CompleteTaskResponse(xmlns:namespace) 
			{
				confirmation("OK")
			}
		}
		return response
		

                
    }
}