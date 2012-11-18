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
 * AuthorityController
 * See domain class form more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class AuthorityController {

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
	
	
	def listService
	def dialogService

    def index = {
        redirect(action: "list", params: params)
    }

    //def list = {
    //    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    //    [authorityInstanceList: Authority.list(params), authorityInstanceTotal: Authority.count()]
    //}
	
	def list = {
		render (view:'/dialog/list', model:[dc:Authority,controllerName:'authority',request:request,bFilter: true])
	}
	
	def jsonlist = {
		render listService.jsonlist(Authority,params,request,"authority") as JSON
	}
    
    def dialog = { return dialogService.edit(Authority,params) }
	
	def submitdialog = { render dialogService.submit(Authority,params) as JSON }
	
	def delete = { render dialogService.delete(Authority,params) as JSON }
}
