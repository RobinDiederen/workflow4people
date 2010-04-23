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
import org.workflow4people.*;

/**
 * Data miner service class
 * Provides the data miner service that is exposed through webservices
 * 
 *
 * @author Joost Horward
 */
class MinerService {

    boolean transactional = true

    def getMinerQueryList() {
    	return MinerQuery.findAll()
    }
    
    def getMinerParameters() {
    	def minerQueries= MinerQuery.findAll()
    	
    	def minerStartYear=ApplicationConfiguration.findByConfigKey('miner.startYear').configValue.asType(Integer)
    	def minerEndYear=ApplicationConfiguration.findByConfigKey('miner.endYear').configValue.asType(Integer)
		def minerYears = (minerStartYear..minerEndYear)
		[minerQueries:minerQueries,minerYears:minerYears]
    }
    
    
    def minerQuery(String queryName,Integer year) {
    	def mQuery=MinerQuery.findByName(queryName)
    	def queryResult=Document.executeQuery(mQuery.query,[year:year])
    	
    	def rows=[:]
    	// Pre-fill each row with 12 elements
    	queryResult.each { r ->
    	if (mQuery.calculateTotals)
    		rows[r[1]]=[0,0,0,0,0,0,0,0,0,0,0,0,0]
    		else	            
    			rows[r[1]]=[0,0,0,0,0,0,0,0,0,0,0,0]
    	}
    	// Put the value data over the cells for which an actual value exists
    	queryResult.each { r ->
			rows[r[1]][r[0]-1]=r[2]
    	}
    	def total=[]
    	if (mQuery.calculateTotals) {
    		total=[0,0,0,0,0,0,0,0,0,0,0,0,0]
	    	rows.each { rowIndex, row ->
	    		row[12]=row[0]+row[1]+row[2]+row[3]+row[4]+row[5]+row[6]+row[7]+row[8]+row[9]+row[10]+row[11]    		                                                                                          
	            (0..12).each { month ->
	            	total[month]+=row[month]	          	
			    }
	    	}
    	}
    	
    	return [rows:rows,total:total]

    }
    
    def minerDrilldown(String queryName,Integer year,Integer month,String value, params=[:]) {
    	def mQuery=MinerQuery.findByName(queryName)
    	def queryResult=Document.executeQuery(mQuery.drilldownQuery,[year:year,month:month,value:value],params)    	
    	return queryResult
    }
    
    def minerDrilldownCount(String queryName,Integer year,Integer month,String value, params=[:]) {
    	def mQuery=MinerQuery.findByName(queryName)
    	def queryResult=Document.executeQuery(mQuery.drilldownCountQuery,[year:year,month:month,value:value],params)    	
    	return queryResult[0].asType(Integer)
    }
    
    
}
