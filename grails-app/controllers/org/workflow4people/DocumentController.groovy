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
import grails.converters.*

import grails.plugins.springsecurity.Secured


/**
 * Controller for Document
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class DocumentController {
	def listService
	def dialogService
	def solrService

    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
	
	def list() {
		render (view:"/dialog/list", model:[dc:Document, controllerName:"document", request:request, bFilter:true])
	}

	def jsonlist() {
		render solrService.jsonsearch(Document, params, request, "*:*",['id','documentDescription','documentType','user','lastUpdated']) as JSON
	}
/*
    def list = {    	
    	render (view:'/dialog/list', model:[dc:Document,controllerName:'document',request:request])
    }
    
    def jsonlist = {
    	render listService.jsonlist(Document,params,request) as JSON	
    }
*/
	def dialog = { return dialogService.edit(Document,params) }
	
	def submitdialog = { render dialogService.submit(Document,params) as JSON }
	
	def delete = { render dialogService.delete(Document,params) as JSON }
	
  }
