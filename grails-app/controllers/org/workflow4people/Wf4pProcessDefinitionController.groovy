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
import org.jbpm.api.*
import org.springframework.beans.factory.InitializingBean
/**
 * Controller for WfpProcessDefinition
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class Wf4pProcessDefinitionController implements InitializingBean{
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
		
		
		def processDefinitionTotal = repositoryService.createProcessDefinitionQuery().count()
		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
		params.offset = params.offset ? params.offset?.toInteger():0
		
		def processDefinitionList=repositoryService.createProcessDefinitionQuery().orderDesc(ProcessDefinitionQuery.PROPERTY_DEPLOYMENT_TIMESTAMP).page(params.offset,params.max).list()
				
		return [processDefinitionList: processDefinitionList,processDefinitionTotal:processDefinitionTotal]
	}
	
	def create ={}
	
    def install = {
	        def file = request.getFile('processdefinition')
	        
	        if(file && !file.empty){
	        	def is = file.inputStream
	        	def deploymentId=0
	        	def deployedFilename=""

                try{
                	
            	deployedFilename=file.getOriginalFilename()
                
            	file.transferTo(new File("/tmp/${deployedFilename}"))
                
                // addResourceFromInputStream is sensitive to the extension of the name given like below
                /*
                 * commented out not to mess up the test db too much
                 */
                def f=new File ("/tmp/${deployedFilename}")
                def deployment=repositoryService.createDeployment().addResourceFromFile(f);
                //def deployment = repositoryService.createDeployment().addResourceFromInputStream(deployedFilename,is);
                
                deployment.setName(deployedFilename)
                deploymentId=deployment.deploy()               
       			log.debug("And the filename is: ${file.getOriginalFilename()}")

            	
            	def f2=new File ("/tmp/${deployedFilename}")
       			def processXML = new XmlSlurper().parse(f2)
       			
       			def processName=processXML.@name.text()
       			def processDescription=processXML.@description.text()
       			println "The process name is: ${processName}"
       			
       			def processDefinition=WorkflowDefinition.findByName(processName)
       			if (processDefinition) {
       				println "Found workflow definition for process ${processName}"
       			} else {
       				println "Workflow definition for process ${processName} not found!"
       			}
       			
       			processXML.task.each  { task ->
       				def taskName=task.@name.text()
       				println "Found task: ${taskName}"
       				def form=Form.findByName(taskName)
       				if (form) {
       					println "Found form for task ${taskName}"
       				} else {
       					println "Form for task ${taskName} not found!"
       				}
       				
       				// find the first task, and make it use a request template
       				// all the others get the handle template
       				
       				// assignee groups on the tasks need to have a 'handle' role
       				// assignee groups on the request need a request role
       				
       				
       				
       				def candidateGroups=task.@'candidate-groups'       				
       				println "The candidate groups are: ${candidateGroups}"
       				
       				def candidateUsers=task.@'candidate-users'       				
       				println "The candidate users are: ${candidateUsers}"
       				
       				def assignee=task.@assignee       				
       				println "The assignee is: ${assignee}"
       				
       				
       			}
                
                
       			
       			
       			
       			
       			
                }finally{
                    is?.close()
                }
	            flash.message = "Process definition deployment ${deploymentId} installed successfully from file ${deployedFilename}"
	        	redirect(action:'list')
	        }	
	         else {
	        	flash.message = "Error installing processdefinition - please select a proper processdefinition file"
	        	render(view:'create')
	        }
	    }
	
    def show = {	    
		// get the Process Definition
		ProcessDefinitionQuery pdQuery=repositoryService.createProcessDefinitionQuery()
		if(params.id) params.processDefinitionId=params.id
		pdQuery.processDefinitionId(params.processDefinitionId)			
		def processDefinition = pdQuery.uniqueResult() 			

		def processInstanceTotal = executionService.createProcessInstanceQuery().processDefinitionId(params.processDefinitionId).count()
		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
		params.offset = params.offset ? params.offset?.toInteger():0
		params.processDefinitionId=processDefinition.id
		// get the list of Process Instances
		ProcessInstanceQuery query=executionService.createProcessInstanceQuery()
		query.processDefinitionId(params.processDefinitionId).orderDesc(ProcessInstanceQuery.PROPERTY_KEY).page(params.offset,params.max)		
		render(view:'show',model:["processInstanceList":query.list(),"processDefinition":processDefinition,processInstanceTotal:processInstanceTotal,params:params])
	}
	
	def newinstance = {
			
			def pi = executionService.startProcessInstanceById(params.processDefinitionId)
			
		    if (pi?.id) {
		      flash.message = "Process instance - ${pi.id} created successfully"
		    } else {
		      flash.message = "Process instance not created! (${params.processName})"
		    }
	        //redirect(action:'instances',params:[processId:params.processId])            
	        redirect(action:'show',params:params)
	    }
	
	    
	


}
