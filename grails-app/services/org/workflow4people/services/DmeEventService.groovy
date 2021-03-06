package org.workflow4people.services
import org.workflow4people.*
import org.codehaus.groovy.grails.commons.*
import org.apache.commons.lang.StringUtils

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
		def result=this.defaultResult
		try {
			def oldParentId
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
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
    
	def dragFieldTypeToField(def node1,node2,moveType,isCopy) {
	
		def result=this.defaultResult
		try {	
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
			// re-calculate positions based on movetype and relField
			dmeService.moveField(field,relField,moveType)
			
			field.save(failOnError:true)
			log.debug "NEW FIELD ID ${field.id} PARENT ${field.parent} POSITION ${field.position}"
	
			result.refreshNodes=[field.visibleParentId]
			
			result.message="Created field ${field.name} (${field.id})"
	
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def dragFieldTypeToFieldType(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
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
			def lastPosition=0
			Field.findAllByParent(fieldType2.listParent,[max:1,sort:'position',order:'desc']).each( { fld -> lastPosition=fld.position+1});
			field.position=lastPosition+1		
			field.fieldType=fieldType1
			field.name=dmeService.camelCase(fieldType1.name)
			
			field.parent=fieldType2.listParent
			field.save(failOnError:true)
			
			result.success=true
			result.message="Created field #${field.id}: ${field.name}"
			result.refreshNodes=[field.visibleParentId]
		} catch (Exception e) {
			result.message=e.message
		}
		return result				
	}
	
	def dragFieldToFieldType(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
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
			result = dragFieldToField(node1,node2,moveType,isCopy)
		} catch (Exception e) {
			result.message=e.message
		}
		return result			
	}
		
	
	
	
	// Dropping a field on a form creates a formItem	TODO change to find first page/section	
	def dragFieldToForm(def node1,node2,moveType,isCopy) {					
		def result=this.defaultResult
		try {
			def field=Field.get(node1.id)
			def form=Form.get(node2.id)
			if (!dmeService.allowFieldOnForm(field,form)) {
				result.message="Field is not allowed on this form because it is not in the XML document tree"
				return result
			}
			
			def firstPage=FormPage.findAllByForm(form,[sort:'position',order:'asc',max:1])[0]
			def formSection=FormSection.findAllByFormPage(firstPage,[sort:'position',order:'asc',max:1])[0]
			
			def maxPosition=FormItem.findAllByFormSection(formSection,[sort:'position',order:'desc',max:1])[0]?.position
			def formItem=new FormItem()
			formItem.field=field
			formItem.formSection=formSection
			
			formItem.position=maxPosition ? maxPosition+1 : 1
			formItem.save(failOnError:true)
	
			result.message="formItem ${formItem.id} created"
			result.refreshNodes=["form_${node2.id}"]
			
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def dragFieldTypeToForm (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def fieldType=FieldType.get(node1.id)
			result=dragFieldToForm([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
		} catch (Exception e) {
				result.message=e.message
		}
		return result
	}
	
	// Dropping a field on a formsection creates a formItem
	def dragFieldToFormSection(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def field=Field.get(node1.id)
			def formSection=FormSection.get(node2.id)
			def form=formSection.formPage.form
			if (!dmeService.allowFieldOnForm(field,form)) {
				result.message="Field is not allowed on this form because it is not in the XML document tree"
				return result
			}
			
			def maxPosition=FormItem.findAllByFormSection(formSection,[sort:'position',order:'desc',max:1])[0]?.position
			def formItem=new FormItem()
			formItem.field=field
			formItem.formSection=formSection
			formItem.position=maxPosition ? maxPosition+1 : 1
			formItem.save(failOnError:true)
	
			result.message="formItem ${formItem.id} created"
			result.refreshNodes=["formsection_${node2.id}"]
			
			result.success=true
		} catch (Exception e) {
				result.message=e.message
		}
		return result
	}
	
	def dragFieldTypeToFormSection (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def fieldType=FieldType.get(node1.id)
			result = dragFieldToFormSection([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
		} catch (Exception e) {
				result.message=e.message
		}
		return result
	}
	
	def dragFieldToFormItem (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def field=Field.get(node1.id)
			def formItem=FormItem.get(node2.id)
			formItem.field=field
			formItem.save()
			result.success=true
			result.message="formItem #${formItem.id} changed to field #${field.id} (${field.name})"
			result.refreshNodes=["formsection_${formItem.formSection.id}"]
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def dragFieldTypeToFormItem (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def fieldType=FieldType.get(node1.id)
			result = dragFieldToFormItem([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	// Dropping a field before or after a formItem creates a formItem
	def dragFieldBeforeFormItem(def node1,node2,moveType,isCopy) {			
		def result=this.defaultResult
		try {
			def field=Field.get(node1.id)
			def refFormItem=FormItem.get(node2.id)
			
			if (!dmeService.allowFieldOnForm(field,refFormItem.formSection.formPage.form)) {
				result.message="Field is not allowed on this form because it is not in the XML document tree"
				return result
			}
			
			def formItem=new FormItem()
			
			formItem.field=field
							
			def position=refFormItem.position
			FormItem.findAllByFormSection(refFormItem.formSection,[sort:'position',order:'asc']).each { fi ->
				if(fi.position>=position) {
					fi.position+=1
				}
			
			}
			formItem.formSection=refFormItem.formSection
			formItem.position=position
			
			formItem.save(failOnError:true)
	
			result.message="formItem ${formItem.id} created"
			result.refreshNodes=["formsection_${formItem.formSection.id}"]
			
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		return result		
	}
	
	def dragFieldTypeBeforeFormItem (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def fieldType=FieldType.get(node1.id)
			result= dragFieldBeforeFormItem([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	
	
	def dragFieldAfterFormItem(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def field=Field.get(node1.id)
			def refFormItem=FormItem.get(node2.id)
			
			if (!dmeService.allowFieldOnForm(field,refFormItem.formSection.formPage.form)) {
				result.message="Field is not allowed on this form because it is not in the XML document tree"
				return result
			}
			
			def formItem=new FormItem()
			
			formItem.field=field
							
			def position=refFormItem.position
			FormItem.findAllByFormSection(refFormItem.formSection,[sort:'position',order:'asc']).each { fi ->
				if(fi.position>position) {
					fi.position+=1
				}
			
			}
			formItem.formSection=refFormItem.formSection
			formItem.position=position+1
			
			formItem.save(failOnError:true)
			result.success=true
			result.message="formItem ${formItem.id} created"
			result.refreshNodes=["formsection_${formItem.formSection.id}"]
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def dragFieldTypeAfterFormItem (def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def fieldType=FieldType.get(node1.id)
			result = dragFieldAfterFormItem([id:fieldType.listParent?.id,type:"fieldtype"],node2,moveType,isCopy)
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def dragFormItemToFormItem(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {		
			def formItem=FormItem.get(node1.id)
			def refFormItem=FormItem.get(node2.id)
			// Only move within sections
			if (formItem.formSection==refFormItem.formSection) {
				def position=refFormItem.position
				
				// move the item into position.
				formItem.position=refFormItem.position
				formItem.save(flush:true)
				
				def n=1
				FormItem.findAllByFormSection(refFormItem.formSection,[sort:'position',order:'asc']).each { fi ->
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
				result.refreshNodes=["formsection_${formItem.formSection.id}"]		
			}
		}  catch (Exception e) {
			result.message=e.message
		}
		
		return result
		
	}
	//
	def dragFormItemToFormSection(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def formItem=FormItem.get(node1.id)
			def prevFormSection=formItem.formSection
			def formSection=FormSection.get(node2.id)
	
			def position=refFormItem.position
		
			
			def form=formSection.formPage.form
			if (!dmeService.allowFieldOnForm(formItem.field,form)) {
				result.message="Field is not allowed on this form because it is not in the XML document tree"
				return result
			}
			
			def maxPosition=FormItem.findAllByFormSection(formSection,[sort:'position',order:'desc',max:1])[0]?.position
			
	
			formItem.formSection=formSection
			formItem.position=maxPosition ? maxPosition+1 : 1
			formItem.save(failOnError:true)
			
			
			def n=1
			FormItem.findAllByFormSection(prevFormSection,[sort:'position',order:'asc']).each { fi ->
				fi.position=n++
			}
			
		
			result.success=true
			result.message="formItem ${formItem.id} moved"
			result.refreshNodes=["formsection_${formItem.formSection.id}"]
		} catch (Exception e) {
			result.message=e.message
		}
		
		return result
		
	}
	
	
	// Section->Section
	def dragFormSectionToFormSection(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def formSection=FormSection.get(node1.id)
			def refFormSection=FormSection.get(node2.id)
			def position=refFormSection.position
			
			// move the item into position.
			formSection.position=refFormSection.position
			formSection.save(flush:true)
			
			def n=1
			FormSection.findAllByFormPage(refFormSection.formPage,[sort:'position',order:'asc']).each { fi ->
				fi.position=n++
			}
			
			if ((moveType=="before") && (formSection.position>refFormSection.position)) {
				dmeService.swapPosition(formSection,refFormSection)
			}
	
			if ((moveType=="after") && (formSection.position<refFormSection.position)) {
				dmeService.swapPosition(formSection,refFormSection)
			}
		
		
			result.success=true
			result.message="formSection ${formSection.id} moved"
			result.refreshNodes=["formpage_${formSection.formPage.id}"]
		} catch (Exception e) {
			result.message=e.message
		}
		
		return result
		
	}
	
	// FormPage->FormPage
	def dragFormPageToFormPage(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def formPage=FormPage.get(node1.id)
			def refFormPage=FormPage.get(node2.id)
			def position=refFormPage.position
			
			// move the item into position.
			formPage.position=refFormPage.position
			formPage.save(flush:true)
			
			def n=1
			FormPage.findAllByForm(refFormPage.form,[sort:'position',order:'asc']).each { fi ->
				fi.position=n++
			}
			
			if ((moveType=="before") && (formPage.position>refFormPage.position)) {
				dmeService.swapPosition(formPage,refFormPage)
			}
	
			if ((moveType=="after") && (formPage.position<refFormPage.position)) {
				dmeService.swapPosition(formPage,refFormPage)
			}
		
			result.success=true
			result.message="formPage ${formPage.id} moved"
			result.refreshNodes=["form_${formPage.form.id}"]
		} catch (Exception e) {
			result.message=e.message
		}		
		return result
		
	}

	// FormPage->Page
	def dragFormPageToForm(def node1,node2,moveType,isCopy) {
		def result=this.defaultResult
		try {
			def formPage=FormPage.get(node1.id)
			def form=Form.get(node2.id)
			
			def newFormPage=deepClone(formPage)
			
			def maxPosition=FormPage.findAllByForm(form,[sort:'position',order:'desc',max:1])[0]?.position?:0
			newFormPage.position=maxPosition+1			
			form.addToFormPage(newFormPage)
			form.save()
							
			result.success=true
			result.message="formPage ${formPage.id} copied"
			result.refreshNodes=["form_${form.id}"]
		} catch (Exception e) {
			result.message=e.message
		}
		return result
		
	}

	
	
	def deleteWorkflowDefinition(def node) {
		def result=this.defaultResult
		try {
			def workflowDefinition=WorkflowDefinition.get(new Long(node.id))
			
			def n=Form.countByWorkflow(workflowDefinition)
								
			if(n>0) {
				log.debug "NOT DOING IT"
				result.message="There are still ${n} forms(s) referencing this workflow!"
			} else {
				log.debug "Deleting workflow ${node.id}"
				workflowDefinition.delete(failOnError:true,flush:true)
				result.refreshNodes=["workflowTree"]
				result.success=true				 
			}
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def deleteField(def node) {
		def result=this.defaultResult
		try {
			int fieldCount
			def field=Field.get(new Long(node.id))
			def theRefreshNodes=[field.visibleParentId]
			
			def dependentFields=Field.findAllByDependsOn(field)
			dependentFields.each { fld ->  
				fld.dependsOn=null
			}
			
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
		} catch (Exception e) {
			result.message=e.message
		}
		
		return result
	}
	
	def deleteFormItem(def node) {
		def result=this.defaultResult
		try {		
			def formItem=FormItem.get(new Long(node.id))
			result.refreshNodes=["formsection_${formItem.formSection.id}"]
			log.debug "Deleting formItem ${node.id}"
			result.message="Form item ${formItem} deleted"
			formItem.delete(failOnError:true,flush:true)
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		return result

	}
	
	def deleteForm(def node) {
		def result=this.defaultResult
		try {
			def form=Form.get(new Long(node.id))
			result.refreshNodes=["workflow_${form.workflow.id}"]
			log.debug "Deleting form ${node.id}"
			result.message="Form ${form} deleted"
			form.workflow.removeFromForm(form)		
			form.delete(failOnError:true,flush:true)		
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		
		return result
	}
	
	def deleteFormPage(def node) {
		def result=this.defaultResult
		try {
			def formPage=FormPage.get(new Long(node.id))
			result.refreshNodes=["form_${formPage.form.id}"]
			log.debug "Deleting formPage ${node.id}"
			result.message="Form page ${formPage} deleted"
			formPage.form.removeFromFormPage(formPage)			  
			formPage.delete(failOnError:true,flush:true)			
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	def deleteFormSection(def node) {
		def result=this.defaultResult
		try {
		
			def formSection=FormSection.get(new Long(node.id))
			result.refreshNodes=["formpage_${formSection.formPage.id}"]
			log.debug "Deleting formSection ${node.id}"
			result.message="Form section ${formSection} deleted"
			formSection.formPage.removeFromFormSection(formSection)
			
			formSection.delete(failOnError:true,flush:true)
			result.success=true
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	

	def deleteFieldType(def node) {
		def result=this.defaultResult
		try {
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
				fieldType.delete(failOnError:true,flush:true)
				result.success=true
				result.allowed=true
			}
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	/*
	 * Generic rename for domain objects 
	 */
	def rename(dc,node,newName,Closure after={}){
		def result=this.defaultResult
		try {
			def defaultDomainClass = new DefaultGrailsDomainClass( dc )
			def domainPropertyName=defaultDomainClass.propertyName
			def domainClassName=defaultDomainClass.getName()
			
		
			def instance = dc.get(node.id)
			def oldName=instance.name
			instance.name=newName
			instance.save(failOnError:true)
			result.success=true
			result.message="Renamed ${domainClassName} #${instance.id} from ${oldName} to ${newName}"
			
			after.setResolveStrategy(Closure.DELEGATE_FIRST)
			after.setDelegate([instance:instance,rslt:result])
			after()
		} catch (Exception e) {
			result.message=e.message
		}
		return result
	}
	
	/*
	 * Clones a domain object and recursively clones children, clearing ids and
	 * attaching children to their new parents. Ownership relationships (indicated
	 * by GORM belongsTo keyword) cause "copy as new" (a recursive deep clone),
	 * but associations without ownership are shallow copied by reference.
	 */
	def deepClone(domainInstanceToClone){

		//Our target instance for the instance we want to clone
		def newDomainInstance = domainInstanceToClone.getClass().newInstance()
	   
		//Returns a DefaultGrailsDomainClass (as interface GrailsDomainClass) for inspecting properties
		def domainClass = ApplicationHolder.application.getDomainClass(newDomainInstance.getClass().name)
	   
		domainClass?.persistentProperties.each{prop ->
			if(prop.association){
				if(prop.owningSide){
					//we have to deep clone owned associations
					if(prop.oneToOne){
						def newAssociationInstance = deepClone(domainInstanceToClone."${prop.name}")
						newDomainInstance."${prop.name}" = newAssociationInstance
					}
					else{
						domainInstanceToClone."${prop.name}".each{ associationInstance ->
							def newAssociationInstance = deepClone(associationInstance)
							newDomainInstance."addTo${StringUtils.capitalize(prop.name)}"(newAssociationInstance)
						}
					}
				}
				else{
					if(!prop.bidirectional){
						//If the association isn't owned or the owner, then we can just do a  shallow copy of the reference.
						newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
					}
				}
			}
			else{
				//If the property isn't an association then simply copy the value
				newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
			}
		}

		return newDomainInstance
	}
	
}
