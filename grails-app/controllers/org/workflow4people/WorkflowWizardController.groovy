package org.workflow4people

//import org.codehaus.groovy.grails.plugins.springsecurity.RedirectUtils
//import org.grails.plugins.springsecurity.service.AuthenticateService
import org.springframework.security.*;

import grails.plugins.springsecurity.Secured
import java.text.*;
import java.util.*;


class WorkflowWizardController {

    def index = {
    		redirect(action:'wizard')
    		
    }
    
    def wizardFlow = {
    		 		
		getProcessXML {
			
			on("next"){
				
		        def file = request.getFile('processdefinition')
		        
		        if(file && !file.empty){
		        	def is = file.inputStream
		        	def deploymentId=0
		        	def deployedFilename=""

	                try{
	                	
	            	deployedFilename=file.getOriginalFilename()
	                
	            	file.transferTo(new File("/tmp/${deployedFilename}"))
	                
	                // addResourceFromInputStream is sensitive to the extension of the name given like below
	                
	                // * commented out not to mess up the test db too much
	                //def f=new File ("/tmp/${deployedFilename}")
	                //def deployment=repositoryService.createDeployment().addResourceFromFile(f);
	                //def deployment = repositoryService.createDeployment().addResourceFromInputStream(deployedFilename,is);
	                
	                //deployment.setName(deployedFilename)
	                //deploymentId=deployment.deploy()               
	       			//log.debug("And the filename is: ${file.getOriginalFilename()}")
	//
	       			def f2=new File ("/tmp/${deployedFilename}")
	       			def processXML = new XmlSlurper().parse(f2)
	       			
	       			//flow.processXML=processXML
	       			String processName=processXML.@name.text()
	       			flow.processName=processName
	       			def processDescription=processXML.@description.text()
	       			log.debug "The process name is: ${processName}"
	       			
	       			flow.workflowDefinition=WorkflowDefinition.findByName(processName)
	       			
	       			if (flow.workflowDefinition) {
	       				log.debug "Found workflow definition for process ${processName}"
	       			} else {
	       				log.debug "Workflow definition for process ${processName} not found!"
	       			}
	       			flow.tasks=[]
	       			processXML.task.each  { task ->
	       				String taskName=task.@name.text()
	       				log.debug "Found task: ${taskName}"
	       				def form=Form.findByName(taskName)
	       				
	       				def tsk=[:]
	       				tsk.name=taskName
	       				tsk.formFound=form ? true : false
	       				flow.tasks+=tsk
	       				
	       				if (form) {
	       					log.debug "Found form for task ${taskName}"
	       				} else {
	       					log.debug "Form for task ${taskName} not found!"
	       				}
	       				
	       				// find the first task, and make it use a request template
	       				// all the others get the handle template
	       				
	       				// assignee groups on the tasks need to have a 'handle' role
	       				// assignee groups on the request need a request role
	       				
	       				def candidateGroups=task.@'candidate-groups'       				
	       				log.debug "The candidate groups are: ${candidateGroups}"
	       				
	       				def candidateUsers=task.@'candidate-users'       				
	       				log.debug "The candidate users are: ${candidateUsers}"
	       				
	       				def assignee=task.@assignee       				
	       				log.debug "The assignee is: ${assignee}"
	       				
	       				
	       			}	                	
	       			
	                }finally{
	                    is?.close()
	                }
	                
		            //flash.message = "Process definition deployment ${deploymentId} installed successfully from file ${deployedFilename}"
		        	//redirect(action:'list')
		        }	
		         else {
		        	flash.message = "Error analyzing process definition"
		        	//render(view:'getProcessXML')
		        	redirect(action:'getProcessXML')
		        }
		        log.debug "AAAA"
			//[workflowDefinition:flow.workflowDefinition,processName:flow.processName]	
				
			}.to("analysis")
		}
		
    	
		analysis {
			on("next").to("fieldList")
		}
		
		fieldList {
			on("next").to("documentType")
		}
		
		documentType {			
			on("next").to("processDefinition")
		}
		
		processDefinition {			
			on("next").to("forms")
		}
		
		forms {
			on("next").to("groups")
		}
		
		groups {
			on("next").to("finish")
		}
		
		users {
			on("next").to("finish")
		}
				
		finish {
			
		}
		
    		
    }
    
    
}
