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
import org.compass.core.engine.SearchEngineQueryParseException
/**
 * Search controller
 * 
 * @author Joost Horward
 */

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER','ROLE_WF4P_PROCESS_ADMIN'])

class SearchController {
    def searchableService

    /**
     * Index page with search form and results
     */
    def index = {
		redirect(action: "search")
    }
	
	ArrayList listProperties=['id','documentDescription','documentType', 'documentStatus', 'dateCreated']
	
	def search = {
		render (view: 'search', model:[dc: ['listProperties': listProperties]])
	}
	
	def jsonlist = {
				
		log.debug "Searching for ${params.q}"
		
		def columns=listProperties
		def aaData=[]
		def iTotalRecords = 0
		
		try {
			def paramz=[analyzer:"wfp"]

			iTotalRecords = searchableService.countHits(params.q, paramz)
			
			paramz.offset = params.iDisplayStart.toInteger()
			paramz.max    = params.iDisplayLength.toInteger()
			
			//Sort order
			if (params.iSortCol_0 != '0' || params.sSortDir_0 != 'asc') {
				paramz.sort = columns[new Integer(params.iSortCol_0)]
				paramz.order = params.sSortDir_0
			}
					
			log.debug "paramz: ${paramz}"
				
			def searchResult = searchableService.search(params.q, paramz);
			
			searchResult.results.each { doc ->
				def inLine=[]
				columns.each {
					inLine +=doc."${it}".toString()
				}
				//Add show action
				inLine+="""<span class="list-action-button ui-state-default" onclick="formDialog(${doc.id},'document',null, null)">edit</span>"""

				def aaLine=[inLine]
				aaData+=(aaLine)
			}
			
		} catch (SearchEngineQueryParseException ex) {
			//
		}
		
		def json = [sEcho:params.sEcho,iTotalRecords:iTotalRecords,iTotalDisplayRecords:iTotalRecords,aaData:aaData]
		
		render json as JSON
		
	}
    
}
