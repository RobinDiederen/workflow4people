/*
 
  * Workflow4people
  * Copyright 2009-2013, Open-T B.V., and individual contributors as indicated
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
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FormPageController {

    def listService
	def dialogService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
		render (view:'/dialog/list', model:[dc:FormPage,controllerName:'formPage',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(FormPage,params,request) as JSON
	}
	
	def dialog = { return dialogService.edit(FormPage,params) }
		
	def submitdialog = {
		def res = dialogService.submit(FormPage,params,null) {
			def theRefreshNodes=domainClassInstance.form?.id ?  ["form_${domainClassInstance.form?.id}"] : ["dataModelTree"]
			res.result += [refreshNodes:theRefreshNodes]
		}
		render res as JSON
	}
	
	
	def delete = { render dialogService.delete(FormPage,params) as JSON }
	
}
