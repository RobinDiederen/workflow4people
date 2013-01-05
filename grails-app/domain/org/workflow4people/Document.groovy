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
import org.apache.solr.common.*

/**
 * XML document database domain class.
 * 
 * @author Joost Horward
 */
class Document {
	/**
	 * properties to be shown in the user interface list
	 */
    static listProperties=['id','documentDescription','documentType','dateCreated','lastUpdated']
    static constraints = {    	    

    	    documentStatus(nullable:true)
    	    documentKey(nullable:true)
    	    documentDescription(nullable:true)
    	    
    	    dateCreated(nullable:true)
    	    lastUpdated(nullable:true)
    	    completionDate(nullable:true)
    	    processingDays(nullable:true)
    	    
    	    user(nullable:true)
    	    groupId(nullable:true)
    	    
    	    cmisFolderObjectId(nullable:true)
    	    cmisFolderUrl(nullable:true)
    	    
    	    xmlDocument(size:0..50000)
    	    
    	    cmisPath(nullable:true)
    }
	  
    static hasMany = [documentIndex:DocumentIndex,form:Form]
	/**
	 * Set of index fields that have infornation derived from the Document XML by XPath or Groovy expressions defined in the DocumentType	
	 */
    Set<DocumentIndex> documentIndex    
	DocumentType documentType
	/**
	 * Provides easy accessibility of the documentStatus in the XML document header. Is extracted/stored by DocumentService
	 * TODO there is no definition of which values are allowed and/or what their meaning would be.    
	 */
	String documentStatus
	/**
	 * This field is not used and will be removed
	 */
	@Deprecated
    String documentKey
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
	 * The date/time this Document was last updated (automatically populated by Grails)
	 */
    Date lastUpdated
	
	/**
	 * The completion date associated with this document
 	 * Provides easy accessibility of the completionDate in the XML document header. Is extracted/stored by DocumentService
 	 * 
 	 * TODO It seems unnecessary to have this. Completiondates should be associatee with workflows, it seems this really should be in the Workflow
	 */
    Date completionDate
	/**
	 * The processing days associated with this document
	 * Provides easy accessibility of the processingDays in the XML document header. Is extracted/stored by DocumentService
	 *
	 * TODO It seems unnecessary to have this. Processing days should be associated with workflows, it seems this really should be in the Workflow
	 */
    double processingDays
	
	/**
	 * The user who owns this document        
	 */
    String user
	/**
	 * The group to which this document belongs
	 */
    String groupId
	/**
	 * The CMISObject ID for the folder associated with this Document
	 * TODO this appears not to be populated
	 */
    String cmisFolderObjectId
	/**
	 * This is derived information that should not be stored here.
	 */
	@Deprecated
    String cmisFolderUrl
	/**
	 * The path in the CMIS repository for this document. This is calculated by the document service based on the cmisPathTemplate property of the associated document type
	 * A folder will be created at his location where documents associated with this XML document can be stored. 
	 */
    String cmisPath
	/**
	 * The XML document itself.
	 */
    String xmlDocument
    /**
     * Provides the description of this document
     * @return The description of this document
     */
	String toString() {
		return documentDescription;
	}
	/**
	 * Provides the Solr input document for this document. This is used by the SolrService to index the document
	 * All persistent properties are provided with their exact name. Additionaly, index fields from DocumentIndex are added with the following convention:
	 * - Fields that do not start with index_ or mindex_ are prefixed with index_
	 * - Fields that start with index_ or mindex_ are passed through as-is
	 * @return
	 */
	SolrInputDocument getSolrInputDocument() {
		SolrInputDocument sid = new SolrInputDocument()
		sid.addField("id",this.id.toString())
		sid.addField("documentType",documentType.name)
		sid.addField("documentDescription",documentDescription)		
		sid.addField("dateCreated",dateCreated)
		sid.addField("lastUpdated",lastUpdated)
		sid.addField("completionDate",completionDate)
		sid.addField("processingDays",processingDays)
		sid.addField("user",user)
		sid.addField("groupId",groupId)
		sid.addField("cmisFolderObjectId",cmisFolderObjectId)
		sid.addField("cmisFolderUrl",cmisFolderUrl)
		sid.addField("cmisPath",cmisPath)
		sid.addField("xmlDocument",xmlDocument)
		DocumentIndex.findAllByDocument(this).each { di ->
			if (di.name.startsWith("index_") || di.name.startsWith("mindex_")) {
				sid.addField(di.name.toString(),di.value)
				log.trace "added ${di.name}"
			} else {
				sid.addField("index_${di.name}",di.value)
				log.trace "added index_${di.name}"
			}
		}		
		return sid
	}
}
