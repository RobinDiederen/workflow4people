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
import grails.converters.JSON;
/**
 * Controller for Form domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FormController {
	def listService
	def dialogService
	def templateService
	
    def index = { redirect(action:list,params:params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

    def list = {
		render (view:'/datatable/list', model:[dc:Form,controllerName:'form',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(Form,params,request) as JSON
	}
	
	def dialog = { 
		def model= dialogService.edit(Form,params)
		model['formTemplateNames']=templateService.formTemplateNames
		if (!model['formInstance'].id) {
			model['formInstance'].formAction=Action.findByName('handle')
		}
		return model
	}
		
	def submitdialog = { render dialogService.submit(Form,params) as JSON }
	
	def delete = { render dialogService.delete(Form,params) as JSON }
    
    
    def show = {
        def formInstance = Form.get( params.id )

        if(!formInstance) {
            flash.message = "Form not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ formInstance : formInstance ] }
    }
    
    /**
     * Renders the XForm representation of this form
     */
    /*
    def xform = {
        def formInstance = Form.get( params.id )
        
        formInstance.workflow.fieldList.storeXPath(formInstance.workflow.fieldList.namespace.prefix,'/'+formInstance.workflow.fieldList.namespace.prefix+':'+formInstance.workflow.fieldList.name)
        if(!formInstance) {
            flash.message = "Form not found with id ${params.id}"
            redirect(action:list)
        }
        else { 
        	
        	render (view: "/wf4p/${formInstance.workflow.processTemplate}/form/${formInstance.template}", model:[ formInstance : formInstance ])
        }
    }
    
    def thankyou = {
        def formInstance = Form.get( params.id )
        
        formInstance.workflow.fieldList.storeXPath(formInstance.workflow.fieldList.namespace.prefix,'/'+formInstance.workflow.fieldList.namespace.prefix+':'+formInstance.workflow.fieldList.name)
        if(!formInstance) {
            flash.message = "Form not found with id ${params.id}"
            redirect(action:list)
        }
        else {         	
        	render (view: "/wf4p/${formInstance.workflow.processTemplate}/form/thankyou", model:[ formInstance : formInstance ])
        }
    }
    
    

    
    

    def xdelete = {
        def formInstance = Form.get( params.id )
        if(formInstance) {
            try {
            	def workflowId=formInstance.workflow.id

                formInstance.delete(flush:true)
                flash.message = "Form ${params.id} deleted"
                redirect(controller:'workflowDefinition',action:'show',id:workflowId)
                
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Form ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Form not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def formInstance = Form.get( params.id )

        if(!formInstance) {
            flash.message = "Form not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ formInstance : formInstance ]
        }
    }

    def update = {
        def formInstance = Form.get( params.id )
        if(formInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(formInstance.version > version) {
                    
                    formInstance.errors.rejectValue("version", "form.optimistic.locking.failure", "Another user has updated this Form while you were editing.")
                    render(view:'edit',model:[formInstance:formInstance])
                    return
                }
            }
            formInstance.properties = params
            if(!formInstance.hasErrors() && formInstance.save()) {
                flash.message = "Form ${params.id} updated"
                //redirect(action:show,id:formInstance.id)
                redirect(controller:'workflowDefinition',action:'show',id:formInstance.workflow.id)
            }
            else {
                render(view:'edit',model:[formInstance:formInstance])
            }
        }
        else {
            flash.message = "Form not found with id ${params.id}"
            //redirect(action:list)
            redirect(controller:'workflowDefinition',action:'show',id:formInstance.workflow.id)
        }
    }

    def create = {
        def formInstance = new Form()
        formInstance.properties = params
        return ['formInstance':formInstance]
    }

    def save = {
        def formInstance = new Form(params)
        if(!formInstance.hasErrors() && formInstance.save()) {
            flash.message = "Form ${formInstance.id} created"
            //redirect(action:show,id:formInstance.id)
            redirect(controller:'workflowDefinition',action:'show',id:formInstance.workflow.id)
        }
        else {
            render(view:'create',model:[formInstance:formInstance])
        }
    }
    */
}
