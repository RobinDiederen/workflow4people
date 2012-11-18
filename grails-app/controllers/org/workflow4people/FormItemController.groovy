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
 * Controller for FormItem domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FormItemController {
	def listService
	def dialogService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
		render (view:'/dialog/list', model:[dc:FormItem,controllerName:'formItem',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(FormItem,params,request) as JSON
	}
	
	def dialog = { return dialogService.edit(FormItem,params) }
	
	def submitdialog = { render dialogService.submit(FormItem,params) as JSON }
	
	def delete = { render dialogService.delete(FormItem,params) as JSON }
    
    

    def create = {
        def formItemInstance = new FormItem()
        formItemInstance.properties = params
        return [formItemInstance: formItemInstance]
    }
    
    def insert = {
        def formItemInstance = new FormItem()
        formItemInstance.properties = params
        return [formItemInstance: formItemInstance]
    }
    
    
    
    // Inserts a form item after the current item
    def insertsave = {    	
        def formItemInstance = new FormItem(params)
        formItemInstance.form.formItem.each { 
        	def itFormItemInstance = FormItem.get(it.id)
        	if (itFormItemInstance.position>formItemInstance.position) {
        		itFormItemInstance.position=itFormItemInstance.position+1
        		itFormItemInstance.save()
        	}
        	
        }
		formItemInstance.position=formItemInstance.position+1
        
        if(!formItemInstance.hasErrors() && formItemInstance.save()) {
            flash.message = "Form Item ${formItemInstance.id} created"
            redirect(controller:'form',action:'show',id:formItemInstance.form.id)
        }
        else {
            render(view:'create',model:[formItemInstance:formItemInstance])
        }
    }
    

    def save = {
        def formItemInstance = new FormItem(params)
        if (!formItemInstance.hasErrors() && formItemInstance.save()) {
            flash.message = "formItem.created"
            flash.args = [formItemInstance.id]
            flash.defaultMessage = "FormItem ${formItemInstance.id} created"
            redirect(action: "show", id: formItemInstance.id)
        }
        else {
            render(view: "create", model: [formItemInstance: formItemInstance])
        }
    }

    def show = {
        def formItemInstance = FormItem.get(params.id)
        if (!formItemInstance) {
            flash.message = "formItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormItem not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [formItemInstance: formItemInstance]
        }
    }

    def edit = {
        def formItemInstance = FormItem.get(params.id)
        if (!formItemInstance) {
            flash.message = "formItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormItem not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [formItemInstance: formItemInstance]
        }
    }

    def update = {
        def formItemInstance = FormItem.get(params.id)
        if (formItemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (formItemInstance.version > version) {
                    
                    formItemInstance.errors.rejectValue("version", "formItem.optimistic.locking.failure", "Another user has updated this FormItem while you were editing")
                    render(view: "edit", model: [formItemInstance: formItemInstance])
                    return
                }
            }
            formItemInstance.properties = params
            if (!formItemInstance.hasErrors() && formItemInstance.save()) {
                flash.message = "formItem.updated"
                flash.args = [params.id]
                flash.defaultMessage = "FormItem ${params.id} updated"
                redirect(action: "show", id: formItemInstance.id)
            }
            else {
                render(view: "edit", model: [formItemInstance: formItemInstance])
            }
        }
        else {
            flash.message = "formItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormItem not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def xdelete = {
        def formItemInstance = FormItem.get(params.id)
        if (formItemInstance) {
            try {
                formItemInstance.delete()
                flash.message = "formItem.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "FormItem ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "formItem.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "FormItem ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "formItem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormItem not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
