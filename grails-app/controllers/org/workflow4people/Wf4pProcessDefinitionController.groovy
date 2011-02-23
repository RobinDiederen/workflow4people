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
import grails.converters.*

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
		params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
		params.offset = params.offset ? params.offset?.toInteger():0
		
		def wf4pProcessDefinitionName = params.processDefinitionName
		if (wf4pProcessDefinitionName) {
			//get all ordered by name DESC, version DESC
			def processDefinitionList = repositoryService.createProcessDefinitionQuery()
			.processDefinitionName(wf4pProcessDefinitionName)
			.orderDesc(ProcessDefinitionQuery.PROPERTY_VERSION)
			.page(params.offset,params.max)
			.list()
			
			def processDefinitionTotal = repositoryService.createProcessDefinitionQuery()
			.processDefinitionName(wf4pProcessDefinitionName)
			.count()
			
			if (processDefinitionTotal > 0) {
				render(view: 'list', model: [processDefinitionList: processDefinitionList, processDefinitionTotal: processDefinitionTotal])
			}
			else {
				flash.message = "Wf4pProcessDefinition not found with name ${params.processDefinitionName}"
				redirect(action:list)
			}
		
		}
		else {
			//get all ordered by name DESC, version DESC
			def processDefinitionList=repositoryService.createProcessDefinitionQuery()
			.orderAsc(ProcessDefinitionQuery.PROPERTY_NAME)
			.orderDesc(ProcessDefinitionQuery.PROPERTY_VERSION)
			/*.page(params.offset,params.max)*/
			.list()
			//only keep all latest versions of processDefinitions in the list
			String previousProcessDefinitionName = null
			for (int i = 0; i < processDefinitionList.size(); i++) {
				if (processDefinitionList[i].getName() != previousProcessDefinitionName) {
					previousProcessDefinitionName = processDefinitionList[i].getName()
				}
				else {
					processDefinitionList.remove(i)
					i--
				}
			}
			//manual crop list (offset & max)
			def croppedProcessDefinitionList = new ArrayList<ProcessDefinition>()
			for (int i = 0; i < processDefinitionList.size(); i++) {
				if (i >= params.offset && i < (params.offset + params.max)) {
					croppedProcessDefinitionList.add(processDefinitionList[i])
				}
			}
			
			def processDefinitionTotal = processDefinitionList.size()	
			
			render(view: 'list', model: [processDefinitionList: croppedProcessDefinitionList, processDefinitionTotal: processDefinitionTotal])
		}
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
	
    
    // AJAX action for update the process definition with the process file
    
    def updateProcess = {
    	println "AAAAA"    	
    	def processDefinitionPath=ApplicationConfiguration.findByConfigKey('process.template.outputPath').configValue;
    	def returnMessage="Process ${params.id} updated"
    	def success=true
    	try {
    		def wfd=WorkflowDefinition.findByName(params.id)
    		def f=new File ("${processDefinitionPath}/${params.id}.jpdl.xml")
    		if (wfd.processDefinitionDate==new Date(f.lastModified())) {
    			success=false
    			returnMessage="Process is already up to date!"
    		} else {
    		
    			def deployment=repositoryService.createDeployment().addResourceFromFile(f)
    			deployment.setName("${params.id}.jpdl.xml")
    			def deploymentId=deployment.deploy()
    			//wfd=WorkflowDefinition.findByName(params.id)
    			wfd.processDefinitionDate=new Date(f.lastModified())
    			wfd.save(failOnError:true)
    		}
    	} catch (Exception e) {
    		returnMessage = e.message
    		success=false
    	}
        
		def result = [
		              	returnValue:success,
			            message:returnMessage ,
			            id:params.id,			            	
			            refreshNodes:""
			         ]              
        def res=[result:result]
        render res as JSON		
    }
	    
	


}
