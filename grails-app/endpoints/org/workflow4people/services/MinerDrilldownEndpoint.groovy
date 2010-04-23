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

import org.workflow4people.services.*
import org.mortbay.log.*;

/**
 * Data miner Drilldown Endpoint 
 * SOAP service that returns a list of items in a data miner cell 
 * @author Joost Horward
 */
class MinerDrilldownEndpoint {
	
	def static namespace = "http://www.workflow4people.org/services"
		MinerService minerService
		DocumentService documentService
		
		def invoke = { request ->
			log.debug("Processing MinerDrilldown service request ${request.name()}")
			
		
			def queryName=request.request.queryName.text()
			def year=request.request.year.text().asType(Integer)
			def month=request.request.month.text().asType(Integer)
			def value=request.request.value.text()
			
			int currentPage=1			
			int maxPageLength=100
			
			if (request.request.paginate.size()>0) {
				currentPage=request.request.paginate.page.text().asType(Integer)
				maxPageLength=request.request.paginate.max.text().asType(Integer)
			}
			def params=['offset':(currentPage-1)*maxPageLength,'max':maxPageLength]
			
			def mqResponse=minerService.minerDrilldown(queryName, year,month,value,params)

			println mqResponse
			// Don't put page limits on the count query, hibernate doesn't like that 
			params=[:]
			def theSize=minerService.minerDrilldownCount(queryName, year,month,value,params)
			
			Integer theTotalPages=((theSize -1)/ maxPageLength) +1			
			
			def response = { MinerDrilldownResponse(xmlns:namespace) 
					{
						documentList {
						  paginateResult {
							  page(currentPage)
							  totalPages(theTotalPages)
							  totalResults(theSize)					  
						  }
						  headers {
							  mqResponse.each { doc ->
								def header = documentService.getDocument (doc.id).header
							  	out << header
							  }
						  }				
						}
					}		
				}
				return response
		}
}