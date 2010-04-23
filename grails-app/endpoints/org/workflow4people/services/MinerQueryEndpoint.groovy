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
import org.workflow4people.services.MinerService;


/**
 * Miner Query Endpoint 
 * SOAP service that runs a data miner query and returns the resulting matrix
 * @author Joost Horward
 */


class MinerQueryEndpoint {
	
	def static namespace = "http://www.workflow4people.org/services"
	MinerService minerService
	
	def invoke = { request ->
		log.debug("Processing MinerQuery service request ${request.name()}")
	
		def queryName=request.request.queryName.text()
		def year=request.request.year.text().asType(Integer)
		def mqResponse=minerService.minerQuery(queryName, year)

		println mqResponse
		def response = { 
				MinerQueryResponse(xmlns:namespace) 
				{	
					mqResponse.rows.each { theRowValue,row -> 
						minerRow {
							rowValue(theRowValue)
							minerCells{
								row.each { theValue ->
									value(theValue)
								}
							}
						
						}
					}
					if(mqResponse.total) {
					totalRow {
						rowValue("Total")
						minerCells{
							mqResponse.total.each { theValue ->
								value(theValue)
							}
						}
					}
					}
					
				}		
		}
	return response
	}
        
}