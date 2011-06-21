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
        if (!params.q?.trim()) {
            return [:]
        }
        try {
        	println "Searching for ${params.q}"
        	
        	//params.analyzer="standard"
        	//params.analyzer="keywordAnalyzer"
        	def paramz=[analyzer:"wfp"]
            return [searchResult: searchableService.search(params.q, paramz)]
        } catch (SearchEngineQueryParseException ex) {
            return [parseException: true]
        }
    }
    
}