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
import java.util.ArrayList;

import grails.converters.JSON;
import grails.plugins.springsecurity.Secured
//import org.compass.core.engine.SearchEngineQueryParseException
/**
 * Search controller
 * 
 * @author Joost Horward
 */

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER','ROLE_WF4P_PROCESS_ADMIN'])

class SearchController {
    def searchableService
	def dialogService
	def solrService

    /**
     * Index page with search form and results
     */
    def index = {
		redirect(action: "list")
    }
	
	def searchdocument() {
		render (view:"/dialog/list", model:[dc:Document, controllerName:"search", request:request, bFilter:true,jsonlist:'jsonsearchdocument'])
	}

	def jsonsearchdocument() {
		render solrService.jsonsearch(Document, params, request, "*:*",['id','documentType','documentDescription','user','lastUpdated']) as JSON		
	}
	
	def searchtask() {
		render (view:"/dialog/list", model:[dc:Task, controllerName:"search", request:request, bFilter:true,jsonlist:'jsonsearchtask',name:'searchtask'])
	}

	def jsonsearchtask() {
		render solrService.jsonsearch(Task, params, request, "*:*",['id','description','dueDate','assignee']) as JSON
	}	
}
