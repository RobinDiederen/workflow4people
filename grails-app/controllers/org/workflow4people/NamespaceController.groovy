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
import grails.converters.*
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])

/**
 * Controller for Namespace domain class
 * 
 * @author Joost Horward
 */
class NamespaceController {
	def listService
	def dialogService
	
    def index = { redirect(action: "list", params: params) }

    // the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

	def list = {
    	
    	render (view:'/datatable/list', model:[dc:Namespace,controllerName:'namespace',request:request])
    }
    
    def jsonlist = {
    	render listService.jsonlist(Namespace,params,request) as JSON	
    }
	
		
	def dialog = { return dialogService.edit(Namespace,params) }
	
	def submitdialog = { render dialogService.submit(Namespace,params) as JSON }
	
	def delete = { render dialogService.delete(Namespace,params) as JSON }
	
	

    def create = {
        def namespaceInstance = new Namespace()
        namespaceInstance.properties = params
        return [namespaceInstance: namespaceInstance]
    }

    def save = {
        def namespaceInstance = new Namespace(params)
        if (!namespaceInstance.hasErrors() && namespaceInstance.save()) {
            flash.message = "namespace.created"
            flash.args = [namespaceInstance.id]
            flash.defaultMessage = "Namespace ${namespaceInstance.id} created"
            redirect(action: "show", id: namespaceInstance.id)
        }
        else {
            render(view: "create", model: [namespaceInstance: namespaceInstance])
        }
    }

    def show = {
        def namespaceInstance = Namespace.get(params.id)
        if (!namespaceInstance) {
            flash.message = "namespace.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Namespace not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [namespaceInstance: namespaceInstance]
        }
    }

    def edit = {
        def namespaceInstance = Namespace.get(params.id)
        if (!namespaceInstance) {
            flash.message = "namespace.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Namespace not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [namespaceInstance: namespaceInstance]
        }
    }

    def update = {
        def namespaceInstance = Namespace.get(params.id)
        if (namespaceInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (namespaceInstance.version > version) {
                    
                    namespaceInstance.errors.rejectValue("version", "namespace.optimistic.locking.failure", "Another user has updated this Namespace while you were editing")
                    render(view: "edit", model: [namespaceInstance: namespaceInstance])
                    return
                }
            }
            namespaceInstance.properties = params
            if (!namespaceInstance.hasErrors() && namespaceInstance.save()) {
                flash.message = "namespace.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Namespace ${params.id} updated"
                redirect(action: "show", id: namespaceInstance.id)
            }
            else {
                render(view: "edit", model: [namespaceInstance: namespaceInstance])
            }
        }
        else {
            flash.message = "namespace.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Namespace not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def xdelete = {
        def namespaceInstance = Namespace.get(params.id)
        if (namespaceInstance) {
            try {
                namespaceInstance.delete()
                flash.message = "namespace.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Namespace ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "namespace.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Namespace ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "namespace.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Namespace not found with id ${params.id}"
            redirect(action: "list")
        }
    }
    /**
     * Renders out the XML schema for this namespace
     */
    def xsd = {
        def namespaceInstance = Namespace.get( params.id )
        def workflowDefinitionInstance = WorkflowDefinition.get( params.workflow )        
       	render (view: "/wf4p/${workflowDefinitionInstance.processTemplate}/workflow/xsdlib", model:[ workflowDefinitionInstance:workflowDefinitionInstance,namespaceInstance : namespaceInstance ])        
    }
    
    
    
    
    
}
