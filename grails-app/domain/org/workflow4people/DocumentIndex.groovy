/*
 * Workflow4people
 * Copyright 2009-2013, Open-T B.V., and individual contributors as indicated
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

/**
 * Stores index information associated with XML Documents stored in Document 
 * 
 * @see org.workflow4people.Document
 * @see org.workflow4people.services.SolrService
 * @author Joost Horward
 */
class DocumentIndex {
	/**
	 * properties to be shown in the user interface list
	 */
    static listProperties=['id','name','value']
	static belongsTo=[document:Document]
    static constraints = {    	
    	value(nullable:true)
    }
	/**
	 *  The index entry name. Values can occur multiple times. In that case they should be named mindex_	
	 */
	String name
	String value
	/**
	 * String representation if this index entry
	 * @return the string representation if this index entry
	 */
    String toString() {
		  return "Index ${name}: ${value}";
	}
}