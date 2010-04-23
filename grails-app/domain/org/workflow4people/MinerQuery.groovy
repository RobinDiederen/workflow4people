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

/**
 * MinerQuery domain class. 
 * Represents a data miner query set.
 * Each query results in a data miner report that is offered to the end user.
 * @author Joost Horward
 */

package org.workflow4people

class MinerQuery {
	static constraints = {
    	name()
    	title()
    	description(size:0..50000)
    	explanationMessage(size:0..50000)
    	query(size:0..50000)
    	drilldownQuery(size:0..50000)
    	drilldownCountQuery(size:0..50000)
    	calculateTotals()
    }
	
    String name
    String title
    String description
    String explanationMessage
    String query
    String drilldownQuery
    String drilldownCountQuery
    boolean calculateTotals=true
    
    
    String toString() {
		  return name;
	}
}
