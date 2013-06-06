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
import java.util.Collection;

import org.apache.solr.common.*
import org.open_t.dialog.*

/**
 * XML document database domain class.
 * 
 * @author Joost Horward
 */
class Document {
	def versionService
	/**
	 * properties to be shown in the user interface list
	 */
	static listConfig=new ListConfig(name:'document',controller: 'document',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'documentDescription',sortable:true,filter:true
		column name:'documentType',sortable:true,filter:true
		column name:'dateCreated',sortable:true,filter:true
		column name:'lastUpdated',sortable:true,filter:true

	}
	
    static constraints = {    	    
		position		nullable:true
		
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
	    
		xmlDocument(size:0..50000000,nullable:true)
	    
		cmisPath(nullable:true)
		
		parent			nullable:true

		createdBy		nullable:true
		lastUpdatedBy	nullable:true
		
		versionLabel	nullable:true,validator: { label,documentInstance ->
			// We get Object references an unsaved transient instance errors here if we do the search on a new object. This is avoided by checking for the id which is empty for new instances
			def exists=false
			if (documentInstance.id) {
				exists=DocumentHistory.countByDocumentAndVersionLabel(documentInstance,label)!=0
			}
			return exists?['validator.versionLabelExists',label]:null
		}
		
    }
	static mapping = {
		xmlDocument type: 'text'		
	}
	int position=0
	Collection children
	
    static hasMany = [documentIndex:DocumentIndex,form:Form,children:Document,documentHistory:DocumentHistory,documentPermission:DocumentPermission]
	static belongsTo=[ parent: Document ]
	
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
	
	String name
	
	String createdBy
	String lastUpdatedBy
	
	
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
	 * The version of this document
	 */
	String versionLabel="0.1"
	
	/**
	 * Determines if this document will inherit permissions from it's parent
	 */
	boolean inheritPermissions=true
	
	/*
	 * Determines if this document is deleted
	 */
	boolean deleted=false
		
	/**
	 * Populate createdBy and lastUpdated when a new item is created
	 * @return
	 */
	def beforeInsert() {
		createdBy=user
		this.lastUpdated=new Date()
		
	}
		
	/**
	 * Save version history and set lastUpdatedBy when the document is updated
	 * @return
	 */
	def beforeUpdate() {
		//
		lastUpdatedBy=user
		
		if (this.isDirty('xmlDocument') || this.isDirty('documentDescription') || this.isDirty('name') || this.isDirty('versionLabel')) {
			// If version is not changed, auto version
			def currentVersion=this.getPersistentValue('versionLabel')
			if (!this.isDirty('versionLabel')) {				
				versionLabel=versionService.nextVersion(currentVersion)
			}
			
			def history=new DocumentHistory(
				xmlDocument:getPersistentValue('xmlDocument'),
				documentDescription:getPersistentValue('documentDescription'),
				name:getPersistentValue('name'),
				versionLabel:getPersistentValue('versionLabel'),
				documentLastUpdated:getPersistentValue('lastUpdated'),
				lastUpdatedBy:getPersistentValue('lastUpdatedBy'),
				createdBy:getPersistentValue('createdBy')
				)
			this.addToDocumentHistory(history)
		}
	}
		
	/**
	 * Get the path to this content item
	 * @return
	 */
	def getPath() {
		if (!parent || parent==this) {
			return "/${name}"
		} else {
			String parentPath=parent.path
			if (parentPath && parentPath.length()<1000) {
				return "${parentPath}/${name}"
			} else {
				return ""
			}
		}
	}
	
	
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
		sid.addField("id",this.id)
		sid.addField("documentType",documentType.name)
		sid.addField("name",name)
		sid.addField("documentDescription",documentDescription)		
		sid.addField("dateCreated",dateCreated)
		sid.addField("lastUpdated",lastUpdated)
		sid.addField("createdBy",createdBy)
		sid.addField("lastUpdatedBy",lastUpdatedBy)
		
		sid.addField("completionDate",completionDate)
		sid.addField("processingDays",processingDays)
		sid.addField("user",user)
		sid.addField("groupId",groupId)
		sid.addField("cmisFolderObjectId",cmisFolderObjectId)
		sid.addField("cmisFolderUrl",cmisFolderUrl)
		sid.addField("cmisPath",cmisPath)
		sid.addField("xmlDocument",xmlDocument)
		sid.addField("folder",documentType.folder)
		sid.addField("cssClass",documentType.name)
		sid.addField("parent",parent?parent.id:0)
		sid.addField("documentPath",path)
		
		
		if (acl) {
			acl.each { key,value ->
				sid.addField("acl","${key}_${value}")
			}
		}
		
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
	
	def getAcl() {
		
		def localAcl=[:]
		if (inheritPermissions) {
			if (parent) {
				localAcl=parent.acl
			} else {
				localAcl=[EVERYONE:"read"]
			}
		}
		
		documentPermission.each { dp ->
			dp.role.roleAction.each { ra ->
				localAcl+=["${dp.authority.authority}":ra.name]
			}
		}
		return localAcl
	}
}
