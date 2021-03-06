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
		render (view:'/dialog/list', model:[dc:Form,controllerName:'form',request:request])
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
    
}
