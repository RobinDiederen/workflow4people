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
import org.jbpm.api.TaskService;
import org.springframework.beans.factory.InitializingBean;


/**
 * Take Task Endpoint
 * SOAP service that takes a task from a taks pool and assigns that task to a user.
 * @author Joost Horward
 */
class TakeTaskEndpoint implements InitializingBean {	
	def processEngine
	def taskService
	
	void afterPropertiesSet() {
		taskService=processEngine.getTaskService()
	}


	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
		log.debug("Processing TakeTask service request ${request.name()}")
		log.debug("Task id: ${request.request.taskId.text()} - User id: ${request.request.userId.text()}")
		if (request.request.userId.text()!="")	{
			taskService.takeTask(request.request.taskId.text(),request.request.userId.text())
		} else {
			taskService.takeTask(request.request.taskId.text(),null)
		}
		def response = {TakeTaskResponse(xmlns:namespace) 
			{
				confirmation("OK")
			}               
		}
		return response
    }
}