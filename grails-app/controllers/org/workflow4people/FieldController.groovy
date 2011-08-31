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
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ fieldInstanceList: Field.list( params ), fieldInstanceTotal: Field.count() ]
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
    		fieldPosition(fieldInstance.fieldPosition)
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
    

    def delete = {
        def fieldInstance = Field.get( params.id )
        if(fieldInstance) {
            try {
            	def fieldList=fieldInstance.fieldList;
                fieldInstance.delete(flush:true)
                fieldList.renumberPositions()
                flash.message = "Field ${params.id} deleted"                
                redirect(controller:'fieldList',action:'tree',id:fieldList.id)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Field ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
    }

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
    /*
    def dialog = {
		
        def fieldInstance = Field.get( params.id )

        if(!fieldInstance) {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ fieldInstance : fieldInstance ]
        }
    }
	*/
	def dialog = { return dialogService.edit(Field,params) }
	
	def submitdialog = { render dialogService.submit(Field,params) as JSON }
    
	/*
	 * Creates new field under a FieldType. Creates the listParent field if it did not exist already
	 */
	def submitUnderFieldType = { 
		def fieldType=FieldType.get(params.parentId)
		if (!fieldType.listParent) {			
				// Create new listParent field if it didn't exist
				def theListParent=new Field()
				theListParent.name=fieldType.name
				theListParent.parent=null
				theListParent.fieldType=fieldType
				theListParent.save(failOnError:true,flush:true)
				fieldType.listParent=theListParent
				fieldType.save(failOnError:true,flush:true)			
		}
		def field=new Field()
		field.properties = params
		field.parent=fieldType.listParent
		
		def result = dialogService.submit(Field,params,field)
		result["result"]+=[refreshNodes:["fieldtype_${fieldType.id}"]]
		render result as JSON 
	}
    
    
    /*
     * This will insert a field under the currently selected field
     */
    
    
    def insert = {
        def currentFieldInstance = Field.get( params.id )
        def fieldInstance = new Field()
        if(!currentFieldInstance) {        	
            fieldInstance.properties = params
            return ['fieldInstance':fieldInstance]
        }
        else {
        	// If the currrent field is a list, add the field to the list
        	// If the current field is a field, add the field to the same parent
        	
        	if (currentFieldInstance.childFieldList) {
        		fieldInstance.fieldList=currentFieldInstance.childFieldList
        		fieldInstance.fieldPosition=0;
        	} else {
        		fieldInstance.fieldList=currentFieldInstance.fieldList
        		fieldInstance.fieldPosition=currentFieldInstance.fieldPosition
        	}        	
            return [ fieldInstance : fieldInstance ]
        }
    }
    
    /*
     * Save an inserted field
     */
    
    
    
    def insertsave = {
        def fieldInstance = new Field(params)
        // move everything from current position down the list
        fieldInstance.fieldList.field.each { 
        	if (it.fieldPosition>fieldInstance.fieldPosition) {
        		def itFieldInstance = Field.get(it.id)
        		itFieldInstance.fieldPosition=itFieldInstance.fieldPosition+1
        		log.debug ("Saving...")
        		log.debug(itFieldInstance.save())
        		log.debug (itFieldInstance.name)
        		log.debug (itFieldInstance.fieldPosition)
        	}
        }
		fieldInstance.fieldPosition=fieldInstance.fieldPosition+1
        if(!fieldInstance.hasErrors() && fieldInstance.save()) {
            flash.message = "Field ${fieldInstance.id} inserted"
            redirect(controller:'fieldList',action:'tree',id:fieldInstance.fieldList.id)
        }
        else {
            render(view:'create',model:[fieldInstance:fieldInstance])
        }
    }
    
    
    
    

    def update = {
        def fieldInstance = Field.get( params.id )
        if(fieldInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(fieldInstance.version > version) {
                    
                    fieldInstance.errors.rejectValue("version", "field.optimistic.locking.failure", "Another user has updated this Field while you were editing.")
                    render(view:'edit',model:[fieldInstance:fieldInstance])
                    return
                }
            }
            fieldInstance.properties = params
            if(!fieldInstance.hasErrors() && fieldInstance.save()) {
                flash.message = "Field ${params.id} updated"
                    redirect(controller:'fieldList',action:'tree',id:fieldInstance.fieldList.id)
            }
            else {
                render(view:'edit',model:[fieldInstance:fieldInstance])
            }
        }
        else {
            flash.message = "Field not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def fieldInstance = new Field()
        fieldInstance.properties = params
        return ['fieldInstance':fieldInstance]
    }

    def save = {
        def fieldInstance = new Field(params)
        if(!fieldInstance.hasErrors() && fieldInstance.save()) {
            flash.message = "Field ${fieldInstance.id} created"
            redirect(action:show,id:fieldInstance.id)
        }
        else {
            render(view:'create',model:[fieldInstance:fieldInstance])
        }
    }
}
