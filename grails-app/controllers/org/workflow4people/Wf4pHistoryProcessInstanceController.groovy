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
import grails.plugins.springsecurity.Secured
import org.jbpm.api.*
import org.jbpm.api.history.*
import org.springframework.beans.factory.InitializingBean

/**
 * Controller for WfpHistoryProcessInstance
 * 
 * @author Joost Horward
 */


@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class Wf4pHistoryProcessInstanceController implements InitializingBean{

	def processEngine
	def currentTime
	def executionService
	def repositoryService
	def taskService
	def historyService

	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		repositoryService=processEngine.getRepositoryService()
		taskService=processEngine.getTaskService()
		historyService=processEngine.getHistoryService()
	}
	
	
    def index = { }
    
    def list = {  
    		
    	// get the Process Definition
    	ProcessDefinitionQuery pdQuery=repositoryService.createProcessDefinitionQuery()    	   
    	pdQuery.processDefinitionId(params.id)			
    	def processDefinition = pdQuery.uniqueResult() 	
    	
    	// get the total number of history items
    	def historyProcessInstanceTotal=historyService.createHistoryProcessInstanceQuery().processDefinitionId(processDefinition.id).count()
 
    	// get the history items, limited by pagination
		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
		params.offset = params.offset ? params.offset?.toInteger():0		
		def historyProcessInstanceList=historyService.createHistoryProcessInstanceQuery().processDefinitionId(processDefinition.id).orderDesc(HistoryProcessInstanceQuery.PROPERTY_STARTTIME).page(params.offset,params.max).list()
		
		[processDefinition:processDefinition,historyProcessInstanceList:historyProcessInstanceList,historyProcessInstanceTotal:historyProcessInstanceTotal,params:params]	
    }
    
    def show = {  
    		
        	// get the Process instance
        	HistoryProcessInstanceQuery hpiQuery=historyService.createHistoryProcessInstanceQuery()    	   
        	
        	hpiQuery.processInstanceId(params.id)			
        	def historyProcessInstance = hpiQuery.uniqueResult() 	
        	
        	// get the total number of history tasks
        	def historyTaskTotal=historyService.createHistoryTaskQuery().executionId(historyProcessInstance.processInstanceId).count()
     
        	// get the history items, limited by pagination
    		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
    		params.offset = params.offset ? params.offset?.toInteger():0		
    		def historyTaskList=historyService.createHistoryTaskQuery().executionId(historyProcessInstance.processInstanceId).orderAsc(HistoryTaskQuery.PROPERTY_CREATETIME).page(params.offset,params.max).list()
    		
    		[historyProcessInstance:historyProcessInstance,historyTaskList:historyTaskList,historyTaskTotal:historyTaskTotal,params:params]	
        }
    
    
    
}
