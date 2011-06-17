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


import java.io.StringWriter;

import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.workflow4people.services.*;
import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateEngine
import groovy.text.*;
import org.springframework.web.context.request.RequestContextHolder
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.apache.commons.lang.StringUtils
import grails.converters.*
/**
 * Controller for WorkflowDefinition domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class WorkflowDefinitionController {
	def listService
	def dialogService
	def wf4pConfigService
	def formGeneratorService
	GroovyPagesTemplateEngine groovyPagesTemplateEngine
	def applicationContext
	TemplateService templateService
	
    
    def index = { redirect(action:list,params:params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

	def list = {
	
    	render (view:'/datatable/list', model:[dc:WorkflowDefinition,controllerName:'workflowDefinition',request:request])
	}
	    
	def jsonlist = {
		render listService.jsonlist(WorkflowDefinition,params,request) as JSON	
    }
	
	def dialog = { return dialogService.edit(WorkflowDefinition,params) }
	
	def submitdialog = { render dialogService.submit(WorkflowDefinition,params) as JSON }
	
	def delete = { render dialogService.delete(WorkflowDefinition,params) as JSON }
	
    def show = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )

        if(!workflowDefinitionInstance) {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ workflowDefinitionInstance : workflowDefinitionInstance,navTemplate:"/workflowDefinition/nav",buttonsTemplate:"/workflowDefinition/buttons" ] }
    }
    
    def xsd = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )

        if(!workflowDefinitionInstance) {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
        else { 
        	render (view: "/wf4p/${workflowDefinitionInstance.processTemplate}/workflow/xsd", model:[ workflowDefinitionInstance : workflowDefinitionInstance ])
        }

    }
	
    def xsdelement = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )
       	render (view: "/wf4p/${workflowDefinitionInstance.processTemplate}/workflow/xsdelement", model:[ workflowDefinitionInstance : workflowDefinitionInstance ])
    }
    
    def xml = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )

        if(!workflowDefinitionInstance) {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
        else { 
        	render (view: "/wf4p/${workflowDefinitionInstance.processTemplate}/workflow/xml", model:[ workflowDefinitionInstance : workflowDefinitionInstance ])         
        }
    }    

    def pageflow = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )

        if(!workflowDefinitionInstance) {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
        else { 
        	render (view: "/wf4p/${workflowDefinitionInstance.processTemplate}/workflow/pageflow", model:[ workflowDefinitionInstance : workflowDefinitionInstance ])             
         }
    }    

    
    def xdelete = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )
        if(workflowDefinitionInstance) {
            try {
                workflowDefinitionInstance.delete(flush:true)
                flash.message = "WorkflowDefinition ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "WorkflowDefinition ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )

        if(!workflowDefinitionInstance) {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ workflowDefinitionInstance : workflowDefinitionInstance ]
        }
    }

    def update = {
        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )
        if(workflowDefinitionInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(workflowDefinitionInstance.version > version) {
                    
                    workflowDefinitionInstance.errors.rejectValue("version", "workflowDefinition.optimistic.locking.failure", "Another user has updated this WorkflowDefinition while you were editing.")
                    render(view:'edit',model:[workflowDefinitionInstance:workflowDefinitionInstance])
                    return
                }
            }
            workflowDefinitionInstance.properties = params
            if(!workflowDefinitionInstance.hasErrors() && workflowDefinitionInstance.save()) {
                flash.message = "WorkflowDefinition ${params.id} updated"
                redirect(action:show,id:workflowDefinitionInstance.id)
            }
            else {
                render(view:'edit',model:[workflowDefinitionInstance:workflowDefinitionInstance])
            }
        }
        else {
            flash.message = "WorkflowDefinition not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def workflowDefinitionInstance = new WorkflowDefinition()
        workflowDefinitionInstance.properties = params
        return ['workflowDefinitionInstance':workflowDefinitionInstance]
    }

    def save = {
        def workflowDefinitionInstance = new WorkflowDefinition(params)
        if(!workflowDefinitionInstance.hasErrors() && workflowDefinitionInstance.save()) {
            flash.message = "WorkflowDefinition ${workflowDefinitionInstance.id} created"
            redirect(action:show,id:workflowDefinitionInstance.id)
        }
        else {
            render(view:'create',model:[workflowDefinitionInstance:workflowDefinitionInstance])
        }
    }
    
	/*
	 * Clones a domain object and recursively clones children, clearing ids and
	 * attaching children to their new parents. Ownership relationships (indicated
	 * by GORM belongsTo keyword) cause "copy as new" (a recursive deep clone),
	 * but associations without ownership are shallow copied by reference.
	 */
	def deepClone(domainInstanceToClone){

	    //Our target instance for the instance we want to clone
	    def newDomainInstance = domainInstanceToClone.getClass().newInstance()  
	   
	    //Returns a DefaultGrailsDomainClass (as interface GrailsDomainClass) for inspecting properties
	    def domainClass = ApplicationHolder.application.getDomainClass(newDomainInstance.getClass().name)
	   
	    domainClass?.persistentProperties.each{prop ->           
	        if(prop.association){
	            if(prop.owningSide){
	                //we have to deep clone owned associations
	                if(prop.oneToOne){
	                    def newAssociationInstance = deepClone(domainInstanceToClone."${prop.name}")
	                    newDomainInstance."${prop.name}" = newAssociationInstance
	                }
	                else{
	                    domainInstanceToClone."${prop.name}".each{ associationInstance ->
	                        def newAssociationInstance = deepClone(associationInstance)
	                        newDomainInstance."addTo${StringUtils.capitalize(prop.name)}"(newAssociationInstance)
	                    }
	                }
	            }
	            else{                   
	                if(!prop.bidirectional){
	                    //If the association isn't owned or the owner, then we can just do a  shallow copy of the reference.
	                    newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
	                }
	            }
	        }
	        else{               
	            //If the property isn't an association then simply copy the value
	            newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
	        }
	    }

	    return newDomainInstance
	}
	
	def copy = {
	        def workflowDefinitionInstance = WorkflowDefinition.get( params.id )

	        if(!workflowDefinitionInstance) {
	            flash.message = "WorkflowDefinition not found with id ${params.id}"
	            redirect(action:list)
	        }
	        else {
	        	def clone=deepClone(workflowDefinitionInstance)
	        	clone.save()
	            //return [ workflowDefinitionInstance : clone ]
                render(view:'edit',model:[workflowDefinitionInstance:clone])
	        }
	    }
	
	
    def generate = {
			
		//formGeneratorService.generate(params.id)
		templateService.generate(params.id)
		/*
    	def workflowDefinitionInstance = WorkflowDefinition.get( params.id )
	
  	  	def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue;
  	  	if (templatePath.charAt(templatePath.length()-1)!='/') {
		  templatePath+='/'
  	  	}
  	  	
    	def outputPath=ApplicationConfiguration.findByConfigKey('template.outputPath').configValue;  	  	
  	  	def templateText=new File(templatePath+"template.conf").text
  	  	def templateConfigDelegate = new TemplateConfigDelegate(templateService,workflowDefinitionInstance,templatePath,outputPath)
  	  	def template=new GroovyShell().evaluate(templateText)

  	  	log.debug "Generating forms package ..."
  	  	template.delegate=templateConfigDelegate
  	  	template()		
    	log.debug ("Done.")
        */
  	    //redirect(action: "generated")
  	    render(view:"formGeneratorStatus")
    }
    
    def generated = {}

	def generateProcess = {
	  	    render(view:"formGeneratorStatus")
    }
	def generateProcessStart = {
		templateService.generateProcess(params.id)
		def res=[]
		render res as JSON
	
	}

	

	def progress = { 
		def p=templateService.progress
		if(p) {
			int percentage=0
	
			if (p.total>0 ) {
				percentage=(p.current/p.total)*100
			}
			
		def response= 

				[total:p.total,
				count:p.current,
				message:p.message,
				pct: percentage,
				log: p.log,
				completed: p.completed
				]
				
		render response as JSON		
			
			
			
			
			
			
		} else {
			
			def response= 
				[
				total:0,
				count:0,
				message:"No form generation in progress",
				pct: 0,
				log: "",
				completed: false	
				
				]
			
			render response as JSON
		}
			
	}
    
    
}
