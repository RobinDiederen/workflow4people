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

package org.workflow4people.services
import org.workflow4people.services.DocumentService;

import org.workflow4people.*;

/**
 * Web service that provides a list of document index fields
 */
class GetDocumentIndexFieldsEndpoint {
	DocumentService documentService
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
	    log.debug("Processing GetDocumentIndexFields service request")
		log.debug("Processing GetDocumentIndexFields service request")
		
		def documentIndexFields=documentService.getDocumentIndexFields()	    
		def response =  { GetDocumentIndexFieldsResponse(xmlns:namespace) 
    					{	documentIndexFields.each { field -> 		
    							documentIndexField(xmlns:namespace) {
    								"name"(field.name)
    								"title" (field.title)
    							}
    						}
    					}
    				}
      
        return response
    }
}