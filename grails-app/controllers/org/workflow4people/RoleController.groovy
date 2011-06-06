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
 * Controller for Role domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class RoleController {

	def listService
	def dialogService
	
    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

    //def list = {
    //    params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
    //    [roleInstanceList: Role.list(params), roleInstanceTotal: Role.count()]
    //}
	
	def list = {
		render (view:'/datatable/list', model:[dc:Role,controllerName:'role',request:request])
	}
		
	def jsonlist = {
		render listService.jsonlist(Role,params,request) as JSON
	}

    def dialog = { return dialogService.edit(Role,params) }
	
	def submitdialog = { render dialogService.submit(Role,params) as JSON }
	
	def delete = { render dialogService.delete(Role,params) as JSON }
	
}
