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
 * XML document database domain class.
 * 
 * @author Joost Horward
 */
class DocumentHistory {
	/**
	 * properties to be shown in the user interface list
	 */
    static listProperties=['id','versionLabel','name','documentDescription','dateCreated','lastUpdatedBy']
    static constraints = {    	    

		dateCreated(nullable:true)
		documentLastUpdated(nullable:true)
	    name(nullable:true)
		documentDescription(nullable:true)
		xmlDocument(size:0..50000000,nullable:true)
	    
		createdBy		nullable:true
		lastUpdatedBy	nullable:true
		versionLabel	nullable:true		
	}
	
	static mapping = {
		xmlDocument type: 'text'
	}
	
    
	static belongsTo=[ document: Document ]
	
	/**
	 * The description of this document
	 * Provides easy accessibility of the documentDescription in the XML document header. Is extracted/stored by DocumentService
	 */
    String documentDescription
	/**
	 * The date/time this Document was created (automatically populated by Grails)
	 */
    Date dateCreated
	/**
	 * The date/time this Document was last updated 
	 */
    Date documentLastUpdated
	
	String name
	
	String createdBy
	String lastUpdatedBy
	
	
	
	
	/**
	 * The XML document itself.
	 */
    String xmlDocument
    
	
	
	String versionLabel
	/**
     * Provides the description of this document
     * @return The description of this document
     */
	String toString() {
		return documentDescription;
	}	
}
