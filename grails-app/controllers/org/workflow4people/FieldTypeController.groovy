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

import grails.plugins.springsecurity.Secured
/**
 * Controller for Field Type domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FieldTypeController {
    
	def listService
	def dialogService
	def templateService
	
    def index = { redirect(action:list,params:params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

	
	def list = {
		render (view:'/dialog/list', model:[dc:FieldType,controllerName:'fieldType',request:request])
	}
	
	def jsonlist = {
		def actions= {  doc,env -> """<div class="btn-group">
										<span class="btn btn-small" onclick="dialog.formDialog(${doc.id},'fieldType', { refresh : '${env.detailTableId}'}, null)">edit</span>
										<a class="btn btn-small" href="${createLink(controller:'dataModelEditor',action:'fieldType',id:doc.id)}">model &raquo;</a>
										<span class="btn btn-small" onclick="dialog.deleteDialog(${doc.id},'fieldType',{ refresh : '${env.detailTableId}'})">&times;</span>
									</div>""" 
}
		
		render listService.jsonlist(FieldType,params,request,null,actions) as JSON
	}
	
	def dialog = {  
		def model= dialogService.edit(FieldType,params)
		
		def templateSnippetConfig=templateService.getSnippetConfig(model.fieldTypeInstance?.name)?:templateService.getSnippetConfig(model.fieldTypeInstance?.baseType?.name)		
		if (model.fieldTypeInstance?.baseType?.name) {			
			model['templateSnippetConfig']=templateSnippetConfig
		}		
		return model		
	}
	
	def submitdialog = { 
		def prms=params
		render dialogService.submit(FieldType,params,null) {			
			domainClassInstance.snippetParameters=prms.snippetParameters
			domainClassInstance.save()			
			res['result']['refreshNodes']=["dataModelTree"]
		} as JSON }
	
	def delete = { render dialogService.delete(FieldType,params) as JSON }
	
    
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
