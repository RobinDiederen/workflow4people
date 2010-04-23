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
import org.jbpm.api.ExecutionService;
import org.jbpm.api.IdentityService;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.* 
import org.springframework.beans.factory.InitializingBean;


import org.jbpm.api.listener.*
import org.jbpm.api.listener.EventListener

/**
 * Due date bug workaround
 * Keep this as an example of how to provide event handlers in a Grails service class
 *
 * @author Joost Horward
 */
class SetDueDateService implements EventListener, InitializingBean{

    boolean transactional = true
    	
	def processEngine
	TaskService taskService
	ExecutionService executionService
    	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()		
		taskService=processEngine.getTaskService()
	}

    void notify(EventListenerExecution execution) {
    	taskService=processEngine.getTaskService()
    	def processDueDate=execution.getVariable("processDueDate")
    	
    	def processInstanceId=execution.getProcessInstance().id
    	log.debug "The process instance id is ${processInstanceId}"
    	def query=taskService.createTaskQuery().processInstanceId(processInstanceId);
    	log.debug "The query is ${query}"
    	Task task= query.uniqueResult()
    	log.debug "The task is ${task}"
    	task.setDuedate (processDueDate)
    }
}
