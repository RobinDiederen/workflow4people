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
 * XML document database domain class.
 * @author Joost Horward
 */

@Searchable(alias = 'Document', analyzer='standard')

class Document {
	static searchable=true

    static constraints = {    	    
    	    documentType()
    	    documentStatus(nullable:true)
    	    documentKey(nullable:true)
    	    documentDescription(nullable:true)
    	    //taskId(nullable:true)
    	    
    	    dateCreated(nullable:true)
    	    lastUpdated(nullable:true)
    	    completionDate(nullable:true)
    	    processingDays(nullable:true)
    	    
    	    user(nullable:true)
    	    groupId(nullable:true)
    	    
    	    cmisFolderObjectId(nullable:true)
    	    cmisFolderUrl(nullable:true)
    	    
    	    xmlDocument(size:0..50000)
    }
    @SearchableId
    Long id
    
    
    static hasMany = [documentIndex:DocumentIndex,form:Form]
    //@SearchableDynamicProperty(index = Index.NOT_ANALYZED)
    @SearchableDynamicProperty
    Set<DocumentIndex> documentIndex
    
    @SearchableComponent
    DocumentType documentType    
    
    @SearchableProperty
    String documentStatus
    
    //@SearchableProperty(index = Index.NOT_ANALYZED)
    @SearchableProperty
    String documentKey
    
    @SearchableProperty
    String documentDescription
    @SearchableProperty(index = Index.NOT_ANALYZED)
    Date dateCreated
    @SearchableProperty(index = Index.NOT_ANALYZED)
    Date lastUpdated
    @SearchableProperty(index = Index.NOT_ANALYZED)
    Date completionDate
    
    //@SearchableProperty(index = Index.NOT_ANALYZED)
    @SearchableProperty
    double processingDays    
    
    @SearchableProperty
    String user

    @SearchableProperty
    String groupId
    
    String cmisFolderObjectId
    String cmisFolderUrl
    
    String xmlDocument
    
	  String toString() {
		  return documentDescription;
	  }
    
}
