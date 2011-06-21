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
/**
 * Controller for FieldTypeItem domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FieldTypeItemController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ fieldTypeItemInstanceList: FieldTypeItem.list( params ), fieldTypeItemInstanceTotal: FieldTypeItem.count() ]
    }

    def show = {
        def fieldTypeItemInstance = FieldTypeItem.get( params.id )

        if(!fieldTypeItemInstance) {
            flash.message = "FieldTypeItem not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldTypeItemInstance : fieldTypeItemInstance ] }
    }

    def delete = {
        def fieldTypeItemInstance = FieldTypeItem.get( params.id )
        if(fieldTypeItemInstance) {
            try {
            	def fieldType=fieldTypeItemInstance.fieldType
                fieldTypeItemInstance.delete(flush:true)
                flash.message = "FieldTypeItem ${params.id} deleted"
                fieldType.renumberItems()
   	            redirect(controller:'fieldType',action:'show',id:fieldType.id)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "FieldTypeItem ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "FieldTypeItem not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def fieldTypeItemInstance = FieldTypeItem.get( params.id )

        if(!fieldTypeItemInstance) {
            flash.message = "FieldTypeItem not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ fieldTypeItemInstance : fieldTypeItemInstance ]
        }
    }

    def update = {
        def fieldTypeItemInstance = FieldTypeItem.get( params.id )
        if(fieldTypeItemInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(fieldTypeItemInstance.version > version) {
                    
                    fieldTypeItemInstance.errors.rejectValue("version", "fieldTypeItem.optimistic.locking.failure", "Another user has updated this FieldTypeItem while you were editing.")
                    render(view:'edit',model:[fieldTypeItemInstance:fieldTypeItemInstance])
                    return
                }
            }
            fieldTypeItemInstance.properties = params
            if(!fieldTypeItemInstance.hasErrors() && fieldTypeItemInstance.save()) {
                flash.message = "FieldTypeItem ${params.id} updated"
                redirect(action:show,id:fieldTypeItemInstance.id)
            }
            else {
                render(view:'edit',model:[fieldTypeItemInstance:fieldTypeItemInstance])
            }
        }
        else {
            flash.message = "FieldTypeItem not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def fieldTypeItemInstance = new FieldTypeItem()
        fieldTypeItemInstance.properties = params
        return ['fieldTypeItemInstance':fieldTypeItemInstance]
    }
    
    def insert = {
        def fieldTypeItemInstance = new FieldTypeItem()
        fieldTypeItemInstance.properties = params
        return ['fieldTypeItemInstance':fieldTypeItemInstance]
    }
    
    def insertsave = {
        def fieldTypeItemInstance = new FieldTypeItem(params)
        fieldTypeItemInstance.fieldType.fieldTypeItem.each {
        	def itFieldTypeItemInstance = FieldTypeItem.get(it.id)
        	if (itFieldTypeItemInstance.itemPosition>fieldTypeItemInstance.itemPosition) {
        		itFieldTypeItemInstance.itemPosition=itFieldTypeItemInstance.itemPosition+1
        		itFieldTypeItemInstance.save()
        	}
        }
        fieldTypeItemInstance.itemPosition=fieldTypeItemInstance.itemPosition+1
        if(!fieldTypeItemInstance.hasErrors() && fieldTypeItemInstance.save()) {
            flash.message = "FieldTypeItem ${fieldTypeItemInstance.id} created"            
            redirect(controller:'fieldType',action:'show',id:fieldTypeItemInstance.fieldType.id)
        }
        else {
            render(view:'create',model:[fieldTypeItemInstance:fieldTypeItemInstance])
        }
    }
        

    def save = {
        def fieldTypeItemInstance = new FieldTypeItem(params)
        if(!fieldTypeItemInstance.hasErrors() && fieldTypeItemInstance.save()) {
            flash.message = "FieldTypeItem ${fieldTypeItemInstance.id} created"
                redirect(controller:'fieldType',action:'show',id:fieldTypeItemInstance.fieldType.id)
        }
        else {
            render(view:'create',model:[fieldTypeItemInstance:fieldTypeItemInstance])
        }
    }
}
