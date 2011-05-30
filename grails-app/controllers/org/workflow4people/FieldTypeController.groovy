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
import grails.converters.JSON;

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
/**
 * Controller for Field Type domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FieldTypeController {
    
	def listService
	
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [ save:'POST', update:'POST']

//    def list = {
//        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
//        [ fieldTypeInstanceList: FieldType.list( params ), fieldTypeInstanceTotal: FieldType.count() ]
//    }
	
	def list = {
		render (view:'/datatable/list', model:[dc:FieldType,controllerName:'fieldType',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(FieldType,params,request) as JSON
	}

    def show = {
        def fieldTypeInstance = FieldType.get( params.id )

        if(!fieldTypeInstance) {
            flash.message = "FieldType not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldTypeInstance : fieldTypeInstance ] }
    }

    def delete = {
        def fieldTypeInstance = FieldType.get( params.id )
        if(fieldTypeInstance) {
            try {
                fieldTypeInstance.delete(flush:true)
                flash.message = "FieldType ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "FieldType ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "FieldType not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def fieldTypeInstance = FieldType.get( params.id )

        if(!fieldTypeInstance) {
            flash.message = "FieldType not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ fieldTypeInstance : fieldTypeInstance ]
        }
    }
    
    def copy = {
        def fieldTypeInstance = FieldType.get( params.id )

        if(!fieldTypeInstance) {
            flash.message = "FieldType not found with id ${params.id}"
            redirect(action:list)
        }
        else {
        	def newFieldTypeInstance = new FieldType();
        	
        	// Cloning is not supported, so here we go field by field
        	newFieldTypeInstance.xmlSnippet=fieldTypeInstance.xmlSnippet
        	newFieldTypeInstance.schemaSnippet=fieldTypeInstance.schemaSnippet
        	
        	newFieldTypeInstance.name=fieldTypeInstance.name
        	newFieldTypeInstance.description=fieldTypeInstance.description
        	newFieldTypeInstance.defaultValue=fieldTypeInstance.defaultValue
        	newFieldTypeInstance.label=fieldTypeInstance.label
        	
        	newFieldTypeInstance.help=fieldTypeInstance.help
        	newFieldTypeInstance.alert=fieldTypeInstance.alert
    
        	newFieldTypeInstance.schemaSnippet=fieldTypeInstance.schemaSnippet            
        	newFieldTypeInstance.xmlSnippet=fieldTypeInstance.xmlSnippet
    
        	newFieldTypeInstance.formSnippet=fieldTypeInstance.formSnippet
        	newFieldTypeInstance.readonlyFormSnippet=fieldTypeInstance.readonlyFormSnippet
        	newFieldTypeInstance.modelSnippet=fieldTypeInstance.modelSnippet
        	newFieldTypeInstance.runtimeEditableList=fieldTypeInstance.runtimeEditableList
        
        	
        	render(view:'create',model:[fieldTypeInstance:newFieldTypeInstance])
        }
    }

    

    def update = {
        def fieldTypeInstance = FieldType.get( params.id )
        if(fieldTypeInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(fieldTypeInstance.version > version) {
                    
                    fieldTypeInstance.errors.rejectValue("version", "fieldType.optimistic.locking.failure", "Another user has updated this FieldType while you were editing.")
                    render(view:'edit',model:[fieldTypeInstance:fieldTypeInstance])
                    return
                }
            }
            fieldTypeInstance.properties = params
            if(!fieldTypeInstance.hasErrors() && fieldTypeInstance.save()) {
                flash.message = "FieldType ${params.id} updated"
                redirect(action:show,id:fieldTypeInstance.id)
            }
            else {
                render(view:'edit',model:[fieldTypeInstance:fieldTypeInstance])
            }
        }
        else {
            flash.message = "FieldType not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def fieldTypeInstance = new FieldType()
        fieldTypeInstance.properties = params
        return ['fieldTypeInstance':fieldTypeInstance]
    }

    def save = {
        def fieldTypeInstance = new FieldType(params)
        if(!fieldTypeInstance.hasErrors() && fieldTypeInstance.save()) {
            flash.message = "FieldType ${fieldTypeInstance.id} created"
            redirect(action:show,id:fieldTypeInstance.id)
        }
        else {
            render(view:'create',model:[fieldTypeInstance:fieldTypeInstance])
        }
    }
    
    // Generates the XML for the itemlist
    def itemlistxml = {
        def fieldTypeInstance = FieldType.get( params.id )
        def workflowDefinitionInstance = WorkflowDefinition.get( params.workflowId )

        if(!fieldTypeInstance) {
            flash.message = "FieldType not found with id ${params.id}"
            redirect(action:list)
        }
        else { 
        	render (view: "/wf4p/${workflowDefinitionInstance.processTemplate}/workflow/itemlistxml", model:[ fieldTypeInstance : fieldTypeInstance ])         
        }
    }    

}
