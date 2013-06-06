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
import org.open_t.dialog.*

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
	static listConfig=new ListConfig(name:'documentType',controller: 'documentType',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'name',sortable:true,filter:true
		column name:'description',sortable:true,filter:true
		column name:'dateCreated',sortable:true,filter:true
		column name:'lastUpdated',sortable:true,filter:true		
	}
    static constraints = {
    	name(unique:true)
    	dateCreated(nullable:true)
    	lastUpdated(nullable:true)
		fieldType()    	
    	cmisPathTemplate(nullable:true,size:0..1000)
//		cmisDocumentNameTemplate(nullable:true,size:0..1000)
//		cmisDocumentTemplatePath(nullable:true,size:0..1000)
		cmisDocumentScript(nullable:true,size:0..1000000)
		
		defaultChildDocumentType(nullable:true)
		
		pathTemplate (nullable:true)
		documentCategory (nullable:true)
		
		nameTemplate (nullable:true)
		descriptionTemplate (nullable:true)
		
    }
    
    static hasMany = [documentIndexField:DocumentIndexField]
    Date dateCreated
    Date lastUpdated
    String name
    String description
	/**
	 * Templates that determine how the name and description for documents of this type is generated
	 * The document instance is used as the binding for this description
	 * @see org.workflow4people.services.DocumentService
	 */
	String nameTemplate
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
	
	
	String pathTemplate
	
	DocumentType defaultChildDocumentType
	DocumentCategory documentCategory
	
	Boolean folder=false
	
//	String cmisDocumentNameTemplate
//	String cmisDocumentTemplatePath
	String cmisDocumentScript
    
    String toString() {
		  return name;
	}
}
