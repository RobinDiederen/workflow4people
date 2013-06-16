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
 * Controller for Field domain class
 * 
 * @author Joost Horward
 */
class FieldController {
	
	def dialogService
	def listService
	
	def templateService
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save:'POST', update:'POST']
	
	def list = {
		render (view:'/dialog/list', model:[dc:Field,controllerName:'field',request:request,jsonlist:'jsonlist'])
	}
		
	def jsonlist = {
		render listService.jsonlist(Field,params,request,null,null) as JSON
	}

    def show = {
        def fieldInstance = Field.get( params.id )

        if(!fieldInstance) {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldInstance : fieldInstance ] }
    }
    
    def ajaxshow = {
        def fieldInstance = Field.get( params.id )

        if(!fieldInstance) {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldInstance : fieldInstance ] }
    }
    
    def json = {
        def fieldInstance = Field.get( params.id )

        if(!fieldInstance) {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
        else { render(builder:'json') {
    		position(fieldInstance.position)
    		wizardStep(fieldInstance.wizardStep)
    		name(fieldInstance.name)
    		fieldTypeID(fieldInstance.fieldType.id)
    		fieldListId(fieldInstance.fieldList.id)
    		fieldTypeName(fieldInstance.fieldType.name)
    		description(fieldInstance.description)
    		    		        	
        	securitylevelRead(fieldInstance.securitylevelRead)
        	securitylevelReadWrite(fieldInstance.securitylevelReadWrite)
        	    	
        	
        	defaultValue(fieldInstance.defaultValue)
        	label(fieldInstance.label)
        	help(fieldInstance.help)
    	    alert(fieldInstance.alert)
        	}
        }
    }
	def delete = { render dialogService.delete(Field,params) as JSON }
	

    def edit = {
        def fieldInstance = Field.get( params.id )

        if(!fieldInstance) {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ fieldInstance : fieldInstance ]
        }
    }
	
	def dialog = {
		def model= dialogService.edit(Field,params)
		if (model.fieldInstance.fieldType?.baseType?.name) {
			model['templateSnippetConfig']=templateService.getSnippetConfig(model.fieldInstance.fieldType?.baseType?.name)
		}
		return model
	}
	
	def submitdialog = {
		def prms=params
		render dialogService.submit(Field,params,null) {
			domainClassInstance.snippetParameters=prms.snippetParameters
			domainClassInstance.save()
			res['result']['refreshNodes']=["dataModelTree"]
		} as JSON }
	
	
   
	def xdialog = { return dialogService.edit(Field,params) }
	
	
	
	def xsubmitdialog = { render dialogService.submit(Field,params) as JSON }
	
	
	def treeJSON = {
		def elements=[]
		def fieldType=false
		if (!params.id || params.id=="") {
			elements=FieldType.findAll([order:'asc',sort:'name'])
			fieldType=true
		} else if (params.id.startsWith("root_")) {
			def id=new Integer(params.id.split("_")[1])
			elements=[FieldType.get(id)]
			fieldType=true
		} else {
			if (params.id.startsWith("fieldtype_")) {
				def id=new Integer(params.id.split("_")[1])
				def p=FieldType.get(id).listParent
				if(p) {
					elements=Field.findAllByParent(p,[sort:'position'])
				}							
			} else {
				def id
				if (params.id.startsWith("fieldtype_")) {
					id=new Integer(params.id.split("_")[1])
				} else {
					id=params.id
				}
				def p=Field.get(id)
				elements=Field.findAllByParent(p,[sort:'position'])				
			}
		}
		
		def prefix=fieldType ? "fieldtype_" : ""
		
			def elementlist = { elements.collect { f ->
				boolean hasChildren=false
				def cssClass=""
				if (f.class.name=="org.workflow4people.FieldType") {
					hasChildren=f.listParent!=null
					cssClass="fieldtype"
	
				} else {
					hasChildren= Field.countByParent(f)>0
					cssClass="field fieldtype-${f.fieldType.name} basetype-${f.fieldType.baseType.name}"
				}
	
				def nodeRel = hasChildren ? 'folder' : 'default'
				def nodeClass="jstree-default ${cssClass}"
				//
				def nodeState =hasChildren ? 'closed' : ''
				[				
					attr: [id: "${prefix}${f.id}",title:f.name,class: nodeClass,rel:nodeRel],				
					data: f.name,
					title: f.name,
					state:nodeState,
					rel:nodeRel
			 ]
			}
		}

	render elementlist() as JSON
		
	}
	
	
	
    
}
