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
import java.util.Date;

/** 
 * XML document database type domain class.
 * Document type provides a description template that is used to display as an identifier for documents.
 * 
 * @author Joost Horward
 */
class DocumentType {
	/**
	 * properties to be shown in the user interface list
	 */
    static listProperties=['id','name','description','dateCreated','lastUpdated']
	
    static constraints = {
    	name(unique:true)
    	dateCreated(nullable:true)
    	lastUpdated(nullable:true)
		fieldType()    	
    	cmisPathTemplate(nullable:true)
    }
    
    static hasMany = [documentIndexField:DocumentIndexField]
    Date dateCreated
    Date lastUpdated
    String name
    String description
	/**
	 * Template that determines how the description for documents of this type is generated
	 * The document instance is used as the binding for this description
	 * @see org.workflow4people.services.DocumentService
	 */
    String descriptionTemplate    
	FieldType fieldType
    /**
     * The CMIS template used to calculate the cmisPath for documents of this type
     */
    String cmisPathTemplate
	/**
	 * Determines if a CMIS folder should be created for documents of this type
	 */
    Boolean	 useCmis=false
    
    String toString() {
		  return name;
	}
}
