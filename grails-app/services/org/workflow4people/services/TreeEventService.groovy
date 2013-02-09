/*
 * Catviz Document Manager
 *
 * Copyright 2012-2013, Open-T B.V., and individual contributors as indicated
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

package org.workflow4people.services
import org.workflow4people.*
class TreeEventService {
	def documentService
	
    boolean transactional = true
	
	def getDefaultResult() {
		def res= [
		returnValue:true,
		allowed:false,
		success:false,
		message:"Unsupported operation...",
		refreshNodes:[]
	]
		return res.clone()
	}
	
	/**
	 * Drag field onto or next to another
	 * 
	 * @param node1
	 * @param node2
	 * @param moveType May be "inside", "before" or "after"
	 * @param isCopy
	 * @return
	 */
	def dragDocumentToDocument(def node1,node2,moveType,isCopy) {
		
		def oldParentId
		def result=this.defaultResult
		log.debug "dragDocumentToDocument: Dragging ${node1.id} ${moveType} ${node2.id}"	
		result.message="Dragging ${node1.id} on ${node2.id}"
		
		def field1
		if (isCopy) {
			// make copy
			log.debug "COPY"
			def originalDocument=Document.get(new Long(node1.id))
			field1=documentService.treeCopy(originalDocument)
			//field1.save()				
		} else {
			field1=Document.get(new Long(node1.id))
			oldParentId=field1.parent?.id
		}
		def parent1=field1.parent
		def field2=Document.get(new Long(node2.id))
		def parent2=field2.parent
			
		documentService.moveDocument(field1,field2,moveType)
		
		if (isCopy) {
			if (!field2.parent) {
				result.refreshNodes=["contentTree"]
			}	else {		
				result.refreshNodes=["content_${field2.parent.id}"]
			}			
		} else {
			if ((!field1.parent) || (!oldParentId)) {
				result.refreshNodes=["contentTree"]
			} else {
				result.refreshNodes=["content_${field1.parent.id}","content_${oldParentId}"]
			}			
		}
		
		result.success=true
		return result
	}
    
	/**
	 * Delete a content item
	 * @param node
	 * @return
	 */
	def deleteDocument(def node) {
		def result=this.defaultResult
		int fieldCount
		def content=Document.get(new Long(node.id))
		def theRefreshNodes=[content.parent?"content_${content.parent.id}":"contentTree"]
		def templates=DocumentType.countByTemplate(content)
		def layouts=DocumentType.countByLayout(content)		
							
		if(templates>0 || layouts>0) {
			log.debug "not deleting content ${node.id}"
			result.message="There are still ${layouts} layout(s) and ${templates} template(s) referencing this content!"				
		} else {
			log.debug "Deleting content ${node.id}"
			
			content.delete()
			
			result.refreshNodes=theRefreshNodes
			result.message="Deleted content ${node.id}"
			result.success=true				
		}
		return result
	}
	/**
	 * Rename a content item
	 * @param node
	 * @param newName
	 * @return
	 */
	def renameDocument(def node,newName) {
		def result=this.defaultResult
		def content = Document.get(node.id)
		def oldName=content.name
		content.name=newName
		content.save(failOnError:true,flush:true)
		result.success=true
		result.message="Renamed content #${content.id} from ${oldName} to ${newName}"
		result.refreshNodes=content.parent? ["content_${content?.parent?.id}"]:["contentTree"]
		return result		
	}
	
	
}
