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
package org.workflow4people
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.springframework.beans.factory.InitializingBean;

/**
 * Controller for WfpProcesInstance domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class Wf4pProcessInstanceController implements InitializingBean {
	def processEngine
	def currentTime
	def executionService
	def repositoryService
	def taskService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		repositoryService=processEngine.getRepositoryService()
		taskService=processEngine.getTaskService()
	}

    def index = { 
	        redirect(action:list)			
	}
    
    def list = {
    		// get the Process Definition
    		def pdQuery=repositoryService.createProcessDefinitionQuery()    	   
    		pdQuery.processDefinitionId(params.processId)			
    		def processDefinition = pdQuery.uniqueResult() 			

    		// get the list of Process Instances
    		def query=executionService.createProcessInstanceQuery()    	   
    		query.processDefinitionId(params.processId)			    		
    		render(view:'list',model:["processInstanceList":query.list(),"processDefinition":processDefinition])
    	}
	
	def create = {
			
			def pi = executionService.startProcessInstanceByKey(params.processName)
			
		    if (pi?.id) {
		      flash.message = "Process instance - ${pi.id} created successfully"
		    } else {
		      flash.message = "Process instance not created! (${params.processName})"
		    }
	        //redirect(action:'instances',params:[processId:params.processId])            
	        redirect(action:'list',params:params)
	    }
	
	def show = {
			// get the process instance
			log.debug "processInstanceId=${params.processInstanceId}"
			def query=executionService.createProcessInstanceQuery()    	   
    		query.processInstanceId(params.processInstanceId)
    		def processInstance=query.uniqueResult()
    		if (!processInstance) {
    			redirect(action:list)
    			return
    		}
    		    		
    		org.jbpm.api.TaskQuery taskQuery=taskService.createTaskQuery()
    		taskQuery.processInstanceId(params.processInstanceId)
    		def taskList = taskQuery.list()
    		
    		
    		
    		
    		
    		render(view:'show',model:["processInstance":processInstance,"taskList":taskList,"taskService":taskService,"executionService":executionService])
	}
	
	
	
}
