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
import grails.converters.*

import grails.plugins.springsecurity.Secured


/**
 * Controller for Document
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class DocumentController {
	def listService
	def dialogService
	def solrService
	def treeEventService

    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
	
	def list() {
		render (view:"/dialog/list", model:[dc:Document, controllerName:"document", request:request, bFilter:true])
	}

	def jsonlist() {
		render solrService.jsonsearch(Document, params, request, "*:*",['id','documentDescription','documentType','dateCreated','lastUpdated']) as JSON
	}

	def dialog = { 		
		if (!params.id) {
			def documentType=null
			def parent=null
			def defaultChildDocumentType=null
			if(params.parentId) {
				parent=Document.get(params.parentId)
				if (parent) {
					documentType=parent.documentType
					defaultChildDocumentType=documentType.defaultChildDocumentType
				}
			}		
			def documentInstance=new Document([parent:parent,documentType:defaultChildDocumentType])		
			return [documentInstance:documentInstance]
		} else {
			return dialogService.edit(Document,params) 
		}
    }
	def submitdialog = { 		
		def res =dialogService.submit(Document,params,null) { 
			if (domainClassInstance.parent) {
				res.result.refreshNodes=["content_${domainClassInstance.parent.id}"]
			} else {
				res.result.refreshNodes=["contentTree"]
			}
		}		
		render res as JSON
    }
		
	
	def delete = {
		def result = [:]
		try {
			def documentInstance = Document.get(params.id)
			// TODO need to delete children too here.
			documentInstance.deleted=true
			documentInstance.save(failOnError:true)
			result = [
				success:true,
				message:"Document ${params.id} deleted",
				id: params.id				
			]
		} catch (Exception e) {
			result = [
				success:false,
				message:e.message,
				id: params.id				
			]
		}
		def res=[result:result]
		render res as JSON 
	}
	
	
	// Document tree
	
	def tree = {
		[:]
	}
	
	def contentJSON = {
		def elements=[]
		def fieldType=false
		if (!params.id || params.id=="") {
			elements=Document.findAllByParentAndDeleted(null,false,[order:'asc',sort:'position'])
			fieldType=true
		} else {
			if (params.id.startsWith("content_")) {
				def id=new Integer(params.id.split("_")[1])
				def p=Document.get(id)
				elements=Document.findAllByParentAndDeleted(p,false,[sort:'position',order:'asc'])
			}
		}
				
		def elementlist = { elements.collect { f ->
				boolean hasChildren=false
				def cssClass=""
				hasChildren= Document.countByParentAndDeleted(f,false)>0
					cssClass="document documenttype-${f.documentType?.name} fieldtype-${f.documentType?.fieldType?.name} basetype-${f.documentType?.fieldType?.baseType?.name}"
				

				def nodeRel = hasChildren ? 'folder' : 'default'
				def nodeClass="jstree-default ${cssClass}"
				//
				def nodeState =hasChildren ? 'closed' : ''
				[
				
				attr: [id: "content_${f.id}",title:f.name?:f.documentDescription,class: nodeClass,rel:nodeRel],
				
				
				data: "${f.name?:f.documentDescription}",
				title: f.name?:f.documentDescription,
				state:nodeState,
				rel:nodeRel
			 ]
		}
			}
			render elementlist() as JSON
		
		}

	def before = {
		def node1=[:]
		def node2=[:]
		
		if (params.id1) {
			node1.id=params.id1.split("_")[1]
			node1.type=params.id1.split("_")[0]
		}
		
		if (params.id2) {
			node2.id=params.id2.split("_")[1]
			node2.type=params.id2.split("_")[0]
		}
		def moveType=params.moveType
		def func=params.func
		def newName=params.newName
		boolean isCopy=params.isCopy=="true"
		def result=treeEventService.defaultResult
		
		log.debug "before: func:${func}, node1:${node1.id}, node2:${node2.id} moveType:${moveType}, isCopy:${isCopy}"
		switch(func) {
			case "move_node":
				if ((node1.type=="content") && (node2.type=="content")) {
					result=treeEventService.dragDocumentToDocument(node1,node2,moveType,isCopy)
				}
				
			break;
			
			case "rename_node":
				switch (node1.type) {
					case "content":
						result=treeEventService.renameDocument(node1,newName)
					break
				}
				
			break;
			
			case "delete_node":
				switch(node1.type) {
					case "content":
						result= treeEventService.deleteDocument(node1);
				break
				}
					 }
		def res=[result:result]
		render res as JSON
	}
	
	
  }
