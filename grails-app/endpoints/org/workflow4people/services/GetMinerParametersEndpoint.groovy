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
 * Get Miner Parameters Endpoint 
 * SOAP service that returns a list of parameters that are available as selectors/keys for the data miner
 * @author Joost Horward
 */
class GetMinerParametersEndpoint {
	
	def static namespace = "http://www.workflow4people.org/services"
	MinerService minerService

	
	def invoke = { request ->
	
	def theMinerQueryList=minerService.getMinerQueryList()
	def theMinerParameters=minerService.getMinerParameters()
	
	def response = { 
			MinerGetMinerParametersResponse(xmlns:namespace) 
			{
				minerQueryList {
				theMinerParameters.minerQueries.each { theMinerQuery ->
				
					minerQuery {
						name(theMinerQuery.name)
						title(theMinerQuery.title)
						explanationMessage(theMinerQuery.explanationMessage)
					}
				
					}
				}			
				minerYearList {
					theMinerParameters.minerYears.each { theYear ->					
						year(theYear)	
					}					
				}
			}
			
			
	}
	return response
	}
}