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
import org.open_t.dialog.*

/**
 * XML document database index definition domain class.
 * Each time the DocumentService stores an XML document, the DocumentIndexFields are used to calculate the DocumentIndex objects
 * 
 * @see org.workflow4people.Document
 * @see org.workflow4people.DocumentIndex
 * @see org.workflow4people.services.DocumentService
 * @author Joost Horward
 */
class DocumentIndexField {
	/**
	 * properties to be shown in the user interface list
	 */
	
	static listConfig=new ListConfig(name:'documentIndexField',controller: 'documentIndexField',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'name',sortable:true,filter:true
		column name:'title',sortable:true,filter:true
		column name:'gpath',sortable:true,filter:true
		column name:'publish',sortable:true,filter:true
	}
    static constraints = {    	
    	description(nullable:true)    	
    }
	/**
	 * The name of this index field
	 */
    String name
	
	/**
	 * The title of this index field
	 */
    String title
	
	/**
	 * The title of this index field
	 */
    String description
	
	/**
	 * The XPath expression used to calculate the value for this field
	 */
    String xpath
	
	/**
	 * The Groovy script expression used to calculae the value for this field
	 * The expression is run on the IndexExpressionDelegate
	 * @see org.workflow4people.IndexExpressionDelegate
	 */
	String script
	
	/**
	 * Determines if searching on this field should be made available to users
	 */
    boolean publish
	
    /** 
     * String represenation of this index field 
     * @return the string represenation of this index field
     */
    String toString() {
    	return title ;
	}
}
