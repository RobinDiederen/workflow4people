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

/**
 * Controller for DocumentIndexField
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class DocumentIndexFieldController {
	def listService
	def dialogService

    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
	
	def list = {
    	
    	render (view:'/dialog/list', model:[dc:DocumentIndexField,controllerName:'documentIndexField',request:request])
    }
    
    def jsonlist = {
    	render listService.jsonlist(DocumentIndexField,params,request) as JSON	
    }
	
	def dialog = { return dialogService.edit(DocumentIndexField,params) }
	
	def submitdialog = { render dialogService.submit(DocumentIndexField,params) as JSON }
	
	def delete = { render dialogService.delete(DocumentIndexField,params) as JSON }

}
