package org.workflow4people.services
import org.workflow4people.*

class DmeEventService {
	def dmeService
	
    boolean transactional = false
	
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
	
	/*
	 * Drag field onto, next to another
	 */	
	def dragFieldToField(def node1,node2,moveType,isCopy) {
		
		def oldParentId
		def result=this.defaultResult
		log.debug "dragFieldToField: Dragging ${node1.id} ${moveType} ${node2.id}"	
		result.message="Dragging ${node1.id} on ${node2.id}"
		
		def field1
		if (isCopy) {
			// make copy
			log.debug "COPY"
			def originalField=Field.get(new Long(node1.id))
			field1=dmeService.treeCopy(originalField)				
		} else {
			field1=Field.get(new Long(node1.id))
			oldParentId=field1.visibleParentId
		}
		def parent1=field1.parent
		def field2=Field.get(new Long(node2.id))
		def parent2=field2.parent
			
		dmeService.moveField(field1,field2,moveType)
		
		if (isCopy) {			
			result.refreshNodes=[field2.visibleParentId]			
		} else {							
			result.refreshNodes=[field1.visibleParentId,oldParentId]			
		}

		result.success=true
		return result
	}
    
	def dragFieldTypeToField(def node1,node2,moveType,isCopy) {
	
		def result=this.defaultResult
			
	// Create new field from FieldType (a FieldType is dropped before or after a field)
	// New name is fieldtype name with lowercased first char
		log.debug	"Creating new field ${moveType} ${node2.id} based on ${node1.id}"
		def fieldType=FieldType.get(new Long(node1.id))
		def relField=Field.get(new Long(node2.id))
		def parentField=relField.parent
		log.debug "The parent field has id ${parentField.id}"
		def field = new Field()
		field.fieldType=fieldType
		// If the FieldType has an associated list, copy the list across
		if (fieldType.listParent) {
			field=dmeService.treeCopy(fieldType.listParent)
		}
		// create camelCased name for field based on FieldType
		String name=fieldType.name
		name=name.substring(0,1).toLowerCase()+name.substring(1)
		field.name=name
		// re-calculate fieldPositions based on movetype and relField
		dmeService.moveField(field,relField,moveType)
		
		field.save(failOnError:true)
		log.debug "NEW FIELD ID ${field.id} PARENT ${field.parent} POSITION ${field.fieldPosition}"

		result.refreshNodes=[field.visibleParentId]
		
		result.message="Created field ${field.name} (${field.id})"

		result.success=true
		
		return result
	}
	
	def dragFieldTypeToFieldType(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		def fieldType1=FieldType.get(node1.id)
		def fieldType2=FieldType.get(node2.id)
		if (!fieldType2.listParent) {
			// Create new listParent field if it didn't exist
			def theListParent=new Field()
			theListParent.name=fieldType2.name
			theListParent.parent=null
			theListParent.fieldType=fieldType2
			theListParent.save(failOnError:true,flush:true)			
			fieldType2.listParent=theListParent
			fieldType2.save(failOnError:true,flush:true)
		}
		def field = new Field()
		def lastFieldPosition=0
		Field.findAllByParent(fieldType2.listParent,[max:1,sort:'fieldPosition',order:'desc']).each( { fld -> lastFieldPosition=fld.fieldPosition+1});
		field.fieldPosition=lastFieldPosition+1		
		field.fieldType=fieldType1
		field.name=dmeService.camelCase(fieldType1.name)
		
		field.parent=fieldType2.listParent
		field.save(failOnError:true)
		
		result.success=true
		result.message="Created field #${field.id}: ${field.name}"
		result.refreshNodes=[field.visibleParentId]
		
		return result				
	}
	
	def dragFieldToFieldType(def node1,node2,moveType,isCopy) {
		def fieldType2=FieldType.get(node2.id)
		if (!fieldType2.listParent) {
			// Create new listParent field if it didn't exist
			def theListParent=new Field()
			theListParent.name=fieldType2.name
			theListParent.parent=null
			theListParent.fieldType=fieldType2
			theListParent.save(failOnError:true,flush:true)
			fieldType2.listParent=theListParent
			fieldType2.save(failOnError:true,flush:true)
		}
		
		node2.id=fieldType2.listParent.id
		node2.type="field"		
		return dragFieldToField(node1,node2,moveType,isCopy)			
	}
		
	
	
	
	// Dropping a field on a form creates a formItem		
	def dragFieldToForm(def node1,node2,moveType,isCopy) {					
		def result=this.defaultResult
		
		def field=Field.get(node1.id)
		def form=Form.get(node2.id)
		if (!dmeService.allowFieldOnForm(field,form)) {
			result.message="Field is not allowed on this form because it is not in the XML document tree"
			return result
		}
		
		
		def maxPosition=FormItem.findAllByForm(form,[sort:'position',order:'desc',max:1])[0]?.position
		def formItem=new FormItem()
		formItem.field=field
		formItem.form=form
		formItem.position=maxPosition ? maxPosition+1 : 1
		formItem.save(failOnError:true)

		result.message="formItem ${formItem.id} created"
		result.refreshNodes=["form_${node2.id}"]
		
		result.success=true
		return result
	}
	
	def dragFieldTypeToForm (def node1,node2,moveType,isCopy) {
		def fieldType=FieldType.get(node1.id)
		return dragFieldToForm([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
	}
	
	def dragFieldToFormItem (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		def field=Field.get(node1.id)
		def formItem=FormItem.get(node2.id)
		formItem.field=field
		formItem.save()
		result.success=true
		result.message="formItem #${formItem.id} changed to field #${field.id} (${field.name})"
		result.refreshNodes=["form_${formItem.form.id}"]
		return result
	}
	
	def dragFieldTypeToFormItem (def node1,node2,moveType,isCopy) {
		def fieldType=FieldType.get(node1.id)
		return dragFieldToFormItem([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
	}
	
	// Dropping a field before or after a formItem creates a formItem
	def dragFieldBeforeFormItem(def node1,node2,moveType,isCopy) {			
		def result=this.defaultResult
		
		def field=Field.get(node1.id)
		def refFormItem=FormItem.get(node2.id)
		
		if (!dmeService.allowFieldOnForm(field,refFormItem.form)) {
			result.message="Field is not allowed on this form because it is not in the XML document tree"
			return result
		}
		
		def formItem=new FormItem()
		
		formItem.field=field
						
		def position=refFormItem.position
		FormItem.findAllByForm(refFormItem.form,[sort:'position',order:'asc']).each { fi ->
			if(fi.position>=position) {
				fi.position+=1
			}
		
		}
		formItem.form=refFormItem.form
		formItem.position=position
		
		formItem.save(failOnError:true)

		result.message="formItem ${formItem.id} created"
		result.refreshNodes=["form_${formItem.form.id}"]
		
		result.success=true
		return result
		
	}
	
	def dragFieldTypeBeforeFormItem (def node1,node2,moveType,isCopy) {
		def fieldType=FieldType.get(node1.id)
		return dragFieldBeforeFormItem([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
	}
	
	
	
	def dragFieldAfterFormItem(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		
		def field=Field.get(node1.id)
		def refFormItem=FormItem.get(node2.id)
		
		if (!dmeService.allowFieldOnForm(field,refFormItem.form)) {
			result.message="Field is not allowed on this form because it is not in the XML document tree"
			return result
		}
		
		def formItem=new FormItem()
		
		formItem.field=field
						
		def position=refFormItem.position
		FormItem.findAllByForm(refFormItem.form,[sort:'position',order:'asc']).each { fi ->
			if(fi.position>position) {
				fi.position+=1
			}
		
		}
		formItem.form=refFormItem.form
		formItem.position=position+1
		
		formItem.save(failOnError:true)
		result.success=true
		result.message="formItem ${formItem.id} created"
		result.refreshNodes=["form_${formItem.form.id}"]
		return result
	}
	
	def dragFieldTypeAfterFormItem (def node1,node2,moveType,isCopy) {
		def fieldType=FieldType.get(node1.id)
		return dragFieldAfterFormItem([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
	}
	
	def dragFormItemToFormItem(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult		
		def formItem=FormItem.get(node1.id)
		def refFormItem=FormItem.get(node2.id)
		def position=refFormItem.position
		
		// move the item into position.
		formItem.position=refFormItem.position
		formItem.save(flush:true)
		
		def n=1
		FormItem.findAllByForm(refFormItem.form,[sort:'position',order:'asc']).each { fi ->
			fi.position=n++
		}
		
		if ((moveType=="before") && (formItem.position>refFormItem.position)) {
			dmeService.swapPosition(formItem,refFormItem)
		}

		if ((moveType=="after") && (formItem.position<refFormItem.position)) {
			dmeService.swapPosition(formItem,refFormItem)
		}
	
	
		result.success=true
		result.message="formItem ${formItem.id} moved"
		result.refreshNodes=["form_${formItem.form.id}"]
		
		return result
		
	}
	
	def deleteWorkflowDefinition(def node) {
		def result=this.defaultResult
		
		def workflowDefinition=WorkflowDefinition.get(new Long(node.id))
		
		def n=Form.countByWorkflow(workflowDefinition)
							
		if(n>0) {
			log.debug "NOT DOING IT"
			result.message="There are still ${n} forms(s) referencing this workflow!"
		} else {
			log.debug "Deleting workflow ${node.id}"
			workflowDefinition.delete()
			result.refreshNodes=["workflowTree"]
			result.success=true				 
		}
		return result
	}
	
	def deleteField(def node) {
		def result=this.defaultResult
		int fieldCount
		def field=Field.get(new Long(node.id))
		def theRefreshNodes=[field.visibleParentId]
		def n=FormItem.countByField(field)
		def theFieldType=null
							
		if(n>0) {
			log.debug "NOT DOING IT"
			result.message="There are still ${n} formItem(s) referencing this fieldtype!"				
		} else {
			def deleteListParent=null
			if (field.parent?.parent==null || field.parent?.parent==field.parent) {
				theFieldType=FieldType.findByListParent(field.parent)
				if (theFieldType)
					
					fieldCount=Field.countByParent(field.parent)
					if (fieldCount==1) {
						deleteListParent=field.parent
					}
				// check if this is the last child of this listParent
				// if so, clean up the listParent, too
				// AFTER removing the field(s) 	
			}
			
			log.debug "Deleting field ${node.id}"
			dmeService.treeDelete(field)
			if (deleteListParent) {
				log.debug "Deleting list parent #${deleteListParent.id}"
				theFieldType.listParent=null
				theFieldType.save(failOnError:true)
				deleteListParent.delete()
			}
			result.refreshNodes=theRefreshNodes
			result.message="Deleted field ${node.id}"
			result.success=true				
		}
		return result
	}
	
	def deleteFormItem(def node) {
		def result=this.defaultResult
		
		def formItem=FormItem.get(new Long(node.id))
		result.refreshNodes=["form_${formItem.form.id}"]
		log.debug "Deleting formItem ${node.id}"
		formItem.delete()
		result.success=true
		return result

	}
	
	def deleteForm(def node) {
		def result=this.defaultResult
		
		def form=Form.get(new Long(node.id))
		result.refreshNodes=["workflow_${form.workflow.id}"]
		log.debug "Deleting form ${node.id}"
		//form.removeFromWorkflowDefinition(form.workflow)
		
		form.workflow.removeFromForm(form)
		   
		
		form.delete()
		
		result.success=true
		return result
	}

	def deleteFieldType(def node) {
		def result=this.defaultResult
		log.debug "DELETE"
		def allowedFlag=true
		def fieldType=FieldType.get(new Long(node.id))
		def n=Field.countByFieldType(fieldType)
		if(n>0) {
			log.debug "NOT DOING IT"
			result.message="There are still ${n} field(s) referencing this fieldtype!"
		}
		
		if (allowedFlag) {
			log.debug "DOING IT"
			result.message= "Deleting fieldtype ${node.id}"
			fieldType.delete()
			result.success=true
			result.allowed=true
		}
		return result
	}
	
	def renameField(def node,newName) {
		def result=this.defaultResult
		def field = Field.get(node.id)
		def oldName=field.name
		field.name=newName
		field.save(failOnError:true)
		result.success=true
		result.message="Renamed field #${field.id} from ${oldName} to ${newName}"
		result.refreshNodes=[field.visibleParentId]
		return result		
	}
	
	def renameFieldType(def node,newName) {
		def result=this.defaultResult
		def fieldType = FieldType.get(node.id)
		def oldName=fieldType.name
		fieldType.name=newName
		fieldType.save(failOnError:true)
		result.success=true
		result.message="Renamed fieldtype #${fieldType.id} from ${oldName} to ${newName}"
		result.refreshNodes=["dataModelTree"]
		return result
	}
	
	def renameForm(def node,newName) {
		def result=this.defaultResult
		def form = Form.get(node.id)
		def oldName=form.name
		form.name=newName
		form.save(failOnError:true)
		result.success=true
		result.message="Renamed form #${form.id} from ${oldName} to ${newName}"
		result.refreshNodes=["workflow_${form.workflow.id}"]
		return result
	}
	
	def renameWorkflow(def node,newName) {
		def result=this.defaultResult
		def workflow = WorkflowDefinition.get(node.id)
		def oldName=workflow.name
		workflow.name=newName
		workflow.save(failOnError:true)
		result.success=true
		result.message="Renamed workflow #${workflow.id} from ${oldName} to ${newName}"
		result.refreshNodes=["workflowTree"]
		return result
	}
	
	
}
