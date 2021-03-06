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
 * Controller for FieldTypeItem domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FieldTypeItemController {
    
	def listService
	def dialogService
	
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ fieldTypeItemInstanceList: FieldTypeItem.list( params ), fieldTypeItemInstanceTotal: FieldTypeItem.count() ]
    }
	
	def jsonlist = {
		render listService.jsonlist(FieldTypeItem,params,request) as JSON
	}
	
	def position() {
		render listService.position(FieldTypeItem,params) as JSON
	}


	def dialog = { return dialogService.edit(FieldTypeItem,params) }
	
	def submitdialog = { render dialogService.submit(FieldTypeItem,params) as JSON }
	
	def delete = { render dialogService.delete(FieldTypeItem,params) as JSON }
	
    def show = {
        def fieldTypeItemInstance = FieldTypeItem.get( params.id )

        if(!fieldTypeItemInstance) {
            flash.message = "FieldTypeItem not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldTypeItemInstance : fieldTypeItemInstance ] }
    }

}
