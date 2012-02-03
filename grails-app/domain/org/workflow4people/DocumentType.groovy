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
package org.workflow4people
import org.compass.annotations.*

/** 
 * XML document database type domain class.
 * Document type provides a description template that is used to display as an identifier for documents.
 * @author Joost Horward
 */

import java.util.Date;
@Searchable(root = false)
class DocumentType {
    static listProperties=['id','name','description','dateCreated','lastUpdated']

    static constraints = {
    	name(help:'x')
    	description(help:'x')
    	descriptionTemplate(help:'x')
    	dateCreated(nullable:true,edit:false,help:'x')
    	lastUpdated(nullable:true,edit:false,help:'x')
		fieldType()
    	documentIndexField(selectSort:'name',help:'x')
    	cmisPathTemplate(nullable:true)
    }
    
    static hasMany = [documentIndexField:DocumentIndexField]
    Date dateCreated
    Date lastUpdated
    //@SearchableProperty(index = Index.NOT_ANALYZED, name = "documentType")
    @SearchableProperty(name = "documentType")
    String name
    String description
    String descriptionTemplate    
	FieldType fieldType
    
    String cmisPathTemplate
    boolean useCmis=false
    
    String toString() {
		  return name;
	}
}
