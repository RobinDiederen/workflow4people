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
import org.workflow4people.services.*
/**
 * Controller for Index domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])

class IndexController {
	def searchableService
	def documentService
	
    def index = { }
    def reindexComplete = {    		
    		def cnt=0
    		Document.findAll().each { document -> 
    			log.debug "Indexing ${document}"
    			documentService.indexDocument(document)
    			document.save()
    			cnt++
    		}
    		render (view:'done',model:[count:cnt])	
    }
	
	def reindexOneType = {
    		def dt=DocumentType.findByName(params.documentTypeName)
    		def cnt=0
    		Document.findAllByDocumentType(dt).each { document -> 
    			log.debug "Indexing ${document}"
    			documentService.indexDocument(document)
    			document.save()
    			cnt++
    		}
    	render (view:'done',model:[count:cnt])	
    }
	
	def reindexLuceneOnly = {
    		searchableService.reindex()
    		render (view:'done',model:[count:Document.count()])
    }
	
}
