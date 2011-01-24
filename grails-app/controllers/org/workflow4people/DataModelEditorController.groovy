package org.workflow4people
import grails.converters.*
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class DataModelEditorController {

	def grailsApplication
	def templateService
	
    def index = { 
    		render(view:'editor')
    		
    }
    
    def showField = {
			def id=params.id.split("_")[1]

            def fieldInstance = Field.get( id )

            if(!fieldInstance) {
                flash.message = "Field not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldInstance : fieldInstance ] }
        }
    
    
    
    def editField = {
			def id=params.id.split("_")[1]

            def fieldInstance = Field.get( id )

            if(!fieldInstance) {
                flash.message = "Field not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldInstance : fieldInstance ] }
        }
	
	def submitField = {
			println "Submit Field params: ${params}"
			def id=params.id.split("_")[1]
			def fieldInstance = Field.get(id )
			fieldInstance.properties = params
    	//	render(view:'showField',model:[ fieldInstance : fieldInstance ])
			def theRefreshNodes=fieldInstance.parent?.id ?  ["field_${fieldInstance.parent.id}"] : ["dataModelTree"]
			
			                     
 			def result = [
 			              	returnValue:true,
 			              	message:"field #${fieldInstance.id} : ${fieldInstance.name} updated" ,
 			              	id:params.id,
 			              	name: fieldInstance.name,	
 			              	refreshNodes:theRefreshNodes
 			              ]              
             def res=[result:result]
             render res as JSON
			
			
	}
	
	def editForm = {
			def formInstance
			if (params.id) {
				def id=params.id.split("_")[1]
				formInstance = Form.get( id )
			} else {
				formInstance=new Form()
				formInstance.formAction=Action.findByName('handle')
			}

            if(!formInstance) {
                flash.message = "Form not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ formInstance : formInstance, formTemplateNames:templateService.formTemplateNames ] }
        }
	
	def submitForm = {
			println "Submit Form params: ${params}"
			def id
			def formInstance
			if(params.id) {
				id=params.id.split("_")[1]
				formInstance = Form.get(id )
			} else {
				formInstance=new Form()
			}
			formInstance.properties = params
			formInstance.save(failOnError:true)
			def theRefreshNodes=["workflow_${formInstance.workflow.id}"]
			      
 			def result = [
 			              	returnValue:true,
 			              	message:"form #${formInstance.id} : ${formInstance.name} updated" ,
 			              	id:params.id,
 			              	name: formInstance.name,	
 			              	refreshNodes:theRefreshNodes
 			              ]              
             def res=[result:result]
             render res as JSON			
	}
	
	def editWorkflowDefinition = {
			def id
			def workflowDefinitionInstance
			if (params.id) {
				id=params.id.split("_")[1]
				workflowDefinitionInstance = WorkflowDefinition.get( id )
			} else {
				workflowDefinitionInstance=new WorkflowDefinition()
			}

            if(!workflowDefinitionInstance) {
                flash.message = "WorkflowDefinition not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ workflowDefinitionInstance : workflowDefinitionInstance ] }
        }
	
	def submitWorkflowDefinition = {
			println "Submit WorkflowDefinition params: ${params}"
			def id
			def workflowDefinitionInstance			
			if (params.id) {
				id=params.id.split("_")[1]
				workflowDefinitionInstance = WorkflowDefinition.get(id )
			} else {
				workflowDefinitionInstance = new WorkflowDefinition()
			}
				
			workflowDefinitionInstance.properties = params
			def theRefreshNodes=["workflowTree"]
			workflowDefinitionInstance.save()
			
			// for new workflows, add the request and show form automatically
			if (!params.id) {
				def showForm=new Form()
				showForm.workflow=workflowDefinitionInstance
				showForm.name="show"
				showForm.title="Show"
				showForm.description="This form shows a ${workflowDefinitionInstance.title}"
				showForm.explanationMessage="This form shows a ${workflowDefinitionInstance.title}"	
				showForm.confirmationMessage="Show has no confirmation"
				showForm.template="show"
				showForm.formAction=Action.findByName("show")
				showForm.save(failOnError:true)
				
				def requestForm=new Form()
				requestForm.workflow=workflowDefinitionInstance
				requestForm.name="request"
				requestForm.title="Request"
				requestForm.description="This form initiates a ${workflowDefinitionInstance.title} workflow"
				requestForm.explanationMessage="This initiates a ${workflowDefinitionInstance.title} workflow"	
							
				
				requestForm.confirmationMessage="Thank you for filling in the ${workflowDefinitionInstance.title} request form"
				requestForm.template="request"
				requestForm.formAction=Action.findByName("request")
				requestForm.save(failOnError:true)
				
			}
			
 			def result = [
 			              	returnValue:true,
 			              	message:"workflow #${workflowDefinitionInstance.id} : ${workflowDefinitionInstance.name} updated" ,
 			              	id:params.id,
 			              	name: workflowDefinitionInstance.name,	
 			              	refreshNodes:theRefreshNodes
 			              ]              
             def res=[result:result]
             render res as JSON			
	}


	def editFormItem = {
			def id=params.id.split("_")[1]

            def formItemInstance = FormItem.get( id )

            if(!formItemInstance) {
                flash.message = "FormItem not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ formItemInstance : formItemInstance ] }
        }
	
	def submitFormItem = {
			println "Submit FormItem params: ${params}"
			def id=params.id.split("_")[1]
			def formItemInstance = FormItem.get(id )
			formItemInstance.properties = params
			def theRefreshNodes=["form_${formItemInstance.form.id}"]
			                     
 			def result = [
 			              	returnValue:true,
 			              	message:"formItem #${formItemInstance.id} ${formItemInstance.field.name} updated" ,
 			              	id:params.id,
 			              	name: formItemInstance.field.name,
 			              	refreshNodes:theRefreshNodes
 			              ]              
             def res=[result:result]
             render res as JSON			
	}

	
	
	
	
	
	def editFieldType = {
			def id
			def fieldTypeInstance
			if (params.id) {
				id=params.id.split("_")[1]
				fieldTypeInstance = FieldType.get( id )
			} else {
				fieldTypeInstance=new FieldType()
			}
			
            if(!fieldTypeInstance) {
                flash.message = "FieldType not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldTypeInstance : fieldTypeInstance ] }
        }
	
	def submitFieldType = {
			println "Submit FieldType params: ${params}"
			
			def id
			def fieldTypeInstance			
			if (params.id) {
				id=params.id.split("_")[1]
				fieldTypeInstance = FieldType.get(id )
			} else {
				fieldTypeInstance = new FieldType()
			}
			
			
			fieldTypeInstance.properties = params
			fieldTypeInstance.save()
			
			//def theRefreshNodes=["${params.id}"]
            def theRefreshNodes=["fieldTypeTree"]                     
			def result = [
			              	returnValue:true,
			              	message:"fieldType #${fieldTypeInstance.id} : ${fieldTypeInstance.name} updated" ,
			              	id:params.id,
			              	name: fieldTypeInstance.name,	
			              	refreshNodes:theRefreshNodes
			              ]
            def res=[result:result]
            render res as JSON
	}
    
	
	
	def submitFieldList = {
			println "Submit FieldList params: ${params}"
			
			def id
			def fieldListInstance			
			if (params.id) {
				id=params.id.split("_")[1]
				fieldListInstance = FieldList.get(id )
			} else {
				fieldListInstance = new FieldList()
			}

			
			fieldListInstance.properties = params
			fieldListInstance.save()
			
			def theRefreshNodes=["fieldListTree"]
 			def result = [
			              	returnValue:true,
			              	message:"fieldList #${fieldListInstance.id} : ${fieldListInstance.name} updated" ,
			              	id:params.id,
			              	name: fieldListInstance.name,	
			              	refreshNodes:theRefreshNodes
			              ]
	         def res=[result:result]
	         render res as JSON
	
	}
          
    def showFieldList = {
			def id=params.id.split("_")[1]

            def fieldListInstance = FieldList.get( id )

            if(!fieldListInstance) {
                flash.message = "FieldList not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldListInstance : fieldListInstance ] }
        }

	def editFieldList = {
			
			def id
			def fieldListInstance
			if (params.id) {
				id=params.id.split("_")[1]
				fieldListInstance = FieldList.get( id )
			} else {
				fieldListInstance=new FieldList()
			}
			
			
            if(!fieldListInstance) {
                flash.message = "FieldList not found with id ${params.id}"
                redirect(action:list)
            }
            else { return [ fieldListInstance : fieldListInstance ] }
        }    
    
    def onmove = {
    		println "We have a move. ${params.node_id} is now ${params.type} ${params.ref_node_id}"
    		println params
    		
    		def id=params.node_id.split('_')[1]
    		def theField=org.workflow4people.Field.get(id)
    		println theField
    		
    		def refId=params.ref_node_id.split('_')[1]
     		def refField=org.workflow4people.Field.get(refId)
    		println refField
    		
    		def moveType=params.type
    		
    		theField.fieldList=refField.fieldList
    		def n=1
    		org.workflow4people.Field.findAllByFieldList(theField.fieldList,[sort:'fieldPosition',order:'asc']).each { field -> 
    			if (field == refField) {
    				if (moveType=="before") {
    					theField.fieldPosition=n
    					theField.save()
    					n++
    					field.fieldPosition=n
    					field.save()
    					n++
    					
    				} else {
    					// after
    					field.fieldPosition=n
    					field.save()
    					n++
    					theField.fieldPosition=n
    					theField.save()
    					n++
    				}
    			} else {
    				if (field !=theField) {
    					field.fieldPosition=n
    					field.save()
    					n++
    				}
				}
			}
    		
    		
    		
    		
    		render(contentType:"text/json") {
    			result(
    					returnValue:true,
    					message:'ooooh een berichtje'
    				)
    		}
    }
    
    def oncopy = {
    		println "We have a copy. ${params.node_id} is now ${params.type} ${params.ref_node_id}"
    		println params
    		
    		def nodeType=params.node_rel
    		def id=params.node_id.split('_')[1]
    		                                 
    		                                 
    		println "nodeType=${nodeType},id=${id}"
    		//def theField=org.workflow4people.Field.get(id)
    		//println theField
    		
    		def refNodeType=params.ref_node_rel
    		def refId=params.ref_node_id.split('_')[1]
    		                                        
            println "refNodeType=${refNodeType},refNodeId=${refId}"
            
     		def refField=org.workflow4people.Field.get(refId)
     		
     		def theField=new Field()
     		if (nodeType=="rootFieldList") {
     			println "Creating new field referring to FieldList"
     			theField.fieldType=org.workflow4people.FieldType.findByName('FieldList')
     			def fieldList=FieldList.get(id)
     			theField.childFieldList=fieldList
     			// convert first chat to lowercase
     			theField.name=fieldList.name[0].toLowerCase()+fieldList.name.substring(1)		
     			theField.fieldList=refField.fieldList
     			theField.label=fieldList.label
     			theField.description=""
     		} else {
     			// copy the field
     			println "Copying field"
     			def originalField=Field.get(id)
     			def domainClass=grailsApplication.getDomainClass('org.workflow4people.Field') 
     			domainClass.persistentProperties.each { prop ->
     				theField."${prop.name}" = originalField."${prop.name}"
     			}     			
     		}
     			
     		
     		
    		
    		
    		def moveType=params.type
    		
    		theField.fieldList=refField.fieldList    		
    		def n=1
    		org.workflow4people.Field.findAllByFieldList(theField.fieldList,[sort:'fieldPosition',order:'asc']).each { field -> 
    			if (field == refField) {
    				if (moveType=="before") {
    					theField.fieldPosition=n
    					theField.save(failOnError:true)
    					n++
    					field.fieldPosition=n
    					field.save(failOnError:true)
    					n++
    					
    				} else {
    					// after
    					field.fieldPosition=n
    					field.save(failOnError:true)
    					n++
    					theField.fieldPosition=n
    					theField.save(failOnError:true)
    					n++
    				}
    			} else {
    				if (field !=theField) {
    					field.fieldPosition=n
    					field.save(failOnError:true)
    					n++
    				}
				}
			}
    		
    		render(contentType:"text/json") {
    			result(
    					returnValue:true,
    					message:'ooooh een berichtje',
    					fieldId:theField.id
    				)
    		}
    }
    
    
    
    def beforedelete = {
    		println params    		
    		Boolean canMove=true
    		if (params.node_rel=="rootFieldList") {
    			canMove=false;
    		}
    		
    		
    		render(contentType:"text/json") {
    			result(
    					returnValue:canMove,
    					message:'ooooh een berichtje'
    				)
    		}
    }
    
	
	/*
	 * New functions for jsTree 1.0
	 */
	
	def treeCopy(Field field) {
		
		def copyField=new Field()					
		def domainClass=grailsApplication.getDomainClass('org.workflow4people.Field') 
			domainClass.persistentProperties.each { prop ->
				copyField."${prop.name}" = field."${prop.name}"
			}
			Field.findAllByParent(field).each { childField ->
				println "CHILDFIELD ${childField}"
				def copyChildField=treeCopy(childField)
				copyChildField.parent=copyField
				copyChildField.save()
				
			}
		return copyField
	}
	
	def treeDelete(Field field) {
		Field.findAllByParent(field).each { childField ->
			println "CHILDFIELD ${childField}"
			treeDelete(childField)				
		}
		field.delete(flush:true)		
	}
	
	
	def moveField(Field field1,Field field2,String where){
		// TODO properly renumber positions
		switch(where) {
		
			case "inside":				
				field1.parent=field2								
				def maxPosition=Field.findAllByParent(field2,[sort:'fieldPosition',order:'desc',max:1])[0]?.fieldPosition
				field1.fieldPosition=maxPosition ? maxPosition+1 : 1

				break
				
			case "before":
				field1.parent=field2.parent
				
				def position=field2.fieldPosition
				field1.fieldPosition=field2.fieldPosition
				field1.save(flush:true)
				
				def n=1
				Field.findAllByParent(field2.parent,[sort:'fieldPosition',order:'asc']).each { field ->
					field.fieldPosition=n++				
				}
				
				if (field1.fieldPosition>field2.fieldPosition) {
					swapFieldPosition(field1,field2)					
				}
				
				
										
				break
			case "after":
				
				field1.parent=field2.parent
				
				def position=field2.fieldPosition
				field1.fieldPosition=field2.fieldPosition
				field1.save(flush:true)
				
				def n=1
				Field.findAllByParent(field2.parent,[sort:'fieldPosition',order:'asc']).each { field ->
					field.fieldPosition=n++				
				}
				
				if (field1.fieldPosition<field2.fieldPosition) {
					swapFieldPosition(field1,field2)					
				}
		
		}
	}
	
	def swapPosition(item1,item2) {
		def p1= item1.position
		def p2 = item2.position							
		item1.position=p2
		item2.position=p1
	}
	
	def swapFieldPosition(item1,item2) {
		def p1= item1.fieldPosition
		def p2 = item2.fieldPosition							
		item1.fieldPosition=p2
		item2.fieldPosition=p1
	}
	
	
	def before = {
			
			def successFlag=false
			println "BEFORE: ${params}"
			def theRefreshNodes=[]
			boolean isCopy=params.isCopy=="true"
			def moveType=params.moveType
			def type1=""
			def type2=""
			def id1=""
			def id2=""
			if (params.id1) {
				id1=params.id1.split("_")[1]
  				type1=params.id1.split("_")[0]
			}
			
			if (params.id2) {
				id2=params.id2.split("_")[1]
  				type2=params.id2.split("_")[0]
			}
			println "TYPE1: ${type1} TYPE2: ${type2}"
			def theMessage="Operation not implemented"

			def allowedFlag=false
			
			if ((type1=="field") && (type2=="field")) {
				println "Dragging ${params.id1} on ${params.id2}"
				theMessage="Dragging ${params.id1} on ${params.id2}"
				def field1
				if (isCopy) {
					// make copy
					println "COPY"
					def originalField=Field.get(new Long(id1))
					field1=treeCopy(originalField)
					
				} else {
					field1=Field.get(new Long(id1))
				
					
				}
				def parent1=field1.parent
				def field2=Field.get(new Long(id2))
				def parent2=field2.parent
				
				moveField(field1,field2,moveType) 
				
				if (isCopy) {
					field1.save()
					theRefreshNodes=["field_${parent2.id}"]
				} else {
					// Renumber the positions of the original sequence
					def n=1
						Field.findAllByParent(parent1,[sort:'fieldPosition',order:'asc']).each { field ->
						field.fieldPosition=n++				
					}
					
					if (parent1==parent2) {
						theRefreshNodes=["field_${parent1.id}"]
					} else {
						theRefreshNodes=["field_${parent1.id}","field_${parent2.id}"]
					}
				}         
                //theRefreshNodes=["field_${field1.id}","field_${field2.id}"]
				allowedFlag=false
				successFlag=true
			}
			
			// Create new field from FieldType
			// New name is fieldtype name with lowercased first char
			if (type1.equals("fieldtype") && type2.equals("field") ) {
			println	"NEW FIELD BASED ON FIELDTYPE"
				def fieldType=FieldType.get(new Long(id1))
				def parentField=Field.get(new Long(id2))
				def field = new Field()
				String name=fieldType.name
				name=name.substring(0,1).toLowerCase()+name.substring(1)
				field.name=name
				/*
				field.label=fieldType.label
				field.help=fieldType.help
				field.alert=fieldType.alert
				field.defaultValue=fieldType.defaultValue
				*/
				field.fieldType=fieldType								
				moveField(field,parentField,moveType)
				field.save(failOnError:true)
				println "NEW FIELD ID ${field.id}"
				theRefreshNodes=["field_${field.parent.id}"]
				theMessage="Created field ${field.name} (${field.id})"
				allowedFlag=false
				successFlag=true
			}
			
			// Dropping a field on a from creates a formItem
			if (type1=="field" && type2=="form" && moveType=="inside") {				
				def field=Field.get(id1)
				def form=Form.get(id2)
				def maxPosition=FormItem.findAllByForm(form,[sort:'position',order:'desc',max:1])[0]?.position
				def formItem=new FormItem()
				formItem.field=field
				formItem.form=form
				formItem.position=maxPosition ? maxPosition+1 : 1
				formItem.save(failOnError:true)
				successFlag=true
				allowedFlag=false
				theMessage="formItem ${formItem.id} created"
				theRefreshNodes=["${params.id2}"]
			}
			
			// Dropping a field before or after a formItem creates a formItem 
			
			if (type1=="field" && type2=="formitem" && moveType=="before") {
				
				def field=Field.get(id1)
				def refFormItem=FormItem.get(id2)
				
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
				successFlag=true
				allowedFlag=false
				theMessage="formItem ${formItem.id} created"
				theRefreshNodes=["form_${formItem.form.id}"]
				
			}
			
			if (type1=="field" && type2=="formitem" && moveType=="after") {
				
				def field=Field.get(id1)
				def refFormItem=FormItem.get(id2)
				
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
				successFlag=true
				allowedFlag=false
				theMessage="formItem ${formItem.id} created"
				theRefreshNodes=["form_${formItem.form.id}"]				
			}
			
			// moving a formItem
			if (type1=="formitem" && type2=="formitem" ) {								
				def formItem=FormItem.get(id1)
				def refFormItem=FormItem.get(id2)
				def position=refFormItem.position
				
				// move the item into position.
				formItem.position=refFormItem.position
				formItem.save(flush:true)
				
				def n=1
				FormItem.findAllByForm(refFormItem.form,[sort:'position',order:'asc']).each { fi ->
					fi.position=n++
				}
				
				if ((moveType=="before") && (formItem.position>refFormItem.position)) {
					swapPosition(formItem,refFormItem)					
				}

				if ((moveType=="after") && (formItem.position<refFormItem.position)) {
					swapPosition(formItem,refFormItem)					
				}
			
			
				successFlag=true
				allowedFlag=false
				theMessage="formItem ${formItem.id} moved"
				theRefreshNodes=["form_${formItem.form.id}"]
				
			}
			
			
			if ((type1=="fieldlist") && (type2=="field") && (params.isCopy=="true")) {
				allowedFlag=false
				theMessage="not implemented"
				successFlag="false"
			}
			
			if ((type1=="field") && (type2=="fieldlist")) {
				allowedFlag=false
				theMessage="not implemented"
				successFlag="false"
			}
						
			if (params.func=="rename_node") {
				allowedFlag=false
				theMessage="not implemented"
				successFlag="false"
			}
			
			if ((params.func=="delete_node")  && (type1=="workflow") ){
				def workflowDefinition=WorkflowDefinition.get(new Long(id1))
				
				def n=Form.countByWorkflow(workflowDefinition)
									
				if(n>0) {
					println "NOT DOING IT"
					theMessage="There are still ${n} forms(s) referencing this workflow!"
					successFlag=false
					allowedFlag=false
				} else {
					println "Deleting workflow ${id1}"
					workflowDefinition.delete()
					theRefreshNodes=["workflowTree"]
	                successFlag=true				
	 				allowedFlag=false
				}
			}
			
			
			
			if ((params.func=="delete_node")  && (type1=="field") ){
				def field=Field.get(new Long(id1))
				
				def n=FormItem.countByField(field)
									
				if(n>0) {
					println "NOT DOING IT"
					theMessage="There are still ${n} field(s) referencing this fieldtype!"
					successFlag=false
					allowedFlag=false
				} else {
					println "Deleting field ${id1}"
					treeDelete(field)
					theRefreshNodes=["field_${field.parent.id}"]
	                successFlag=true				
	 				allowedFlag=false
				}
			}
			
			if ((params.func=="delete_node")  && (type1=="formitem") ){
				
				def formItem=FormItem.get(new Long(id1))				
				theRefreshNodes=["form_${formItem.form.id}"]
				println "Deleting formItem ${id1}"				
				formItem.delete()
				successFlag=true				
				allowedFlag=false
			}
			
			if ((params.func=="delete_node")  && (type1=="form") ){
				
				def form=Form.get(new Long(id1))				
				theRefreshNodes=["workflow_${form.workflow.id}"]
				println "Deleting form ${id1}"
				//form.removeFromWorkflowDefinition(form.workflow)
				
				form.workflow.removeFromForm(form)
				   
				
				form.delete()
				successFlag=true				
				allowedFlag=false
			}

			
			
			
			if ((params.func=="delete_node")  && (type1=="fieldtype") ){
				println "DELETE"
				allowedFlag=true
				def fieldType=FieldType.get(new Long(id1))
				def n=Field.countByFieldType(fieldType)
				if(n>0) {
					println "NOT DOING IT"
					theMessage="There are still ${n} field(s) referencing this fieldtype!"
					successFlag=false
					allowedFlag=false
				}
				
				theRefreshNodes=[]
				if (allowedFlag) {
					println "DOING IT"
					theMessage= "Deleting fieldtype ${id1}"
					fieldType.delete()				
					allowedFlag=true
					successFlag=true
				}
			}
			
			
			
			
			//TODO should be a list but ends up a string????
			if (!theRefreshNodes) {
				if (params.id1) theRefreshNodes+="${params.id1}"
				if (params.id2) theRefreshNodes+="${params.id2}"
			}
			println "REFRESHNODES:${theRefreshNodes}"
			
			
			
			/*
			
			render(contentType:"text/json") {
    			result(
    					returnValue:"okay",
    					allowed:allowedFlag,
    					message:'ooooh een berichtje',
    					refreshNodes:theRefreshNodes
    				)
    		}
    		*/
			
			def result = [
			              	returnValue:true,
			              	allowed:allowedFlag,
			              	success:successFlag,
			              	message:theMessage ,
			              	refreshNodes:theRefreshNodes
			              ]
          def res=[result:result]
          render res as JSON
			
			
			
			
			
	}
	
	def delete = {
			println "DELETE: ${params}"
			
			render(contentType:"text/json") {
    			result(    					
    					message:"${params.id} deleted"
    				)
    		}
			
			
	}
	
	
	def fieldTypeJSON = {	
			def elements=[]
			if (!params.id || params.id=="") {				
				elements=FieldType.findAll([order:'asc',sort:'name'])	            
			} 
			
			
			def elementlist = { elements.collect { fieldType -> 
			
					def nodeRel='default'
					def nodeClass="jstree-default fieldtype fieldtype-${fieldType.name}"
					
					def nodeState = ""	
						
					[
                    attr: [id: "fieldtype_${fieldType.id}",title:fieldType.name,class: nodeClass,rel:nodeRel],
                 	data: fieldType.name,
					title: fieldType.name,
					state:nodeState,					
					rel:nodeRel
				 ]
				}
			}
			                                                                                        
			render elementlist() as JSON
			
	}
	
	def fieldJSON = {	
			def elements=[]
			def fieldList=false
			if (!params.id || params.id=="") {				
				elements=FieldList.findAll([order:'asc',sort:'name'])
				fieldList=true
			} else {
				if (params.id.startsWith("field_")) {
					def id=new Integer(params.id.split("_")[1])
					def p=Field.get(id)
					elements=Field.findAllByParent(p,[sort:'fieldPosition'])
				} else {
					def id=new Integer(params.id.split("_")[1])
					def p=FieldList.get(id).parent
					//elements=Field.findAllByParent(p,[sort:'fieldPosition'])
					elements=[p]
				}
			}
			
			def prefix=fieldList ? "fieldlist" : "field" 
			
			def elementlist = { elements.collect { f ->
					boolean hasChildren=false
					def cssClass=""
					if (f.class.name=="org.workflow4people.FieldList") {
						def parentField=f.parent
						hasChildren=Field.countByParent(parentField)>0
						cssClass="fieldlist"

					} else {
						hasChildren= Field.countByParent(f)>0
						cssClass="field fieldtype-${f.fieldType.name} basetype-${f.fieldType.baseType.name}"

					}
 
					def nodeRel = hasChildren ? 'folder' : 'default'						
					def nodeClass="jstree-default ${cssClass}"					
					//	
					def nodeState =hasChildren ? 'closed' : ''
					[
                    
                    attr: [id: "${prefix}_${f.id}",title:f.name,class: nodeClass,rel:nodeRel],
                    
                    
                 	data: f.name,
					title: f.name,
					state:nodeState,					
					rel:nodeRel
				 ]
				}
			}
			                                           
		//	println "ELEMENTLIST: ${elementlist()}"                                             
			render elementlist() as JSON
			
	}
	
	def workflowJSON = {	
			def elements=[]
			def elementType=""
			def id=null
			if (params.id) {
				elementType=params.id.split("_")[0]
                id=new Long(params.id.split("_")[1])
			}
			
			switch (elementType) {
				case "": 
									
					elements=WorkflowDefinition.findAll([order:'asc',sort:'name'])	            			
					def elementlist = { elements.collect { workflow -> 					
							def hasChildren=Form.countByWorkflow(workflow)>0
							def nodeRel = hasChildren ? 'folder' : 'default'													
							def nodeState =hasChildren ? 'closed' : ''
					
							def nodeClass="jstree-default workflow workflow-${workflow.name}"
								
							[
		                    attr: [id: "workflow_${workflow.id}",title:workflow.name,class: nodeClass,rel:nodeRel],
		                 	data: workflow.name,
							title: workflow.name,
							state:nodeState,					
							rel:nodeRel
						 ]
						}
					}
					render elementlist() as JSON
					break
				case "workflow":
					def workflow=WorkflowDefinition.get(id)
					elements=Form.findAllByWorkflow(workflow,[order:'asc',sort:'name'])	            			
					def elementlist = { elements.collect { form -> 
					
							def hasChildren=FormItem.countByForm(form)>0
							def nodeRel = hasChildren ? 'folder' : 'default'													
							def nodeState =hasChildren ? 'closed' : ''
							def nodeClass="jstree-default form form-${form.name}"
							
								
							[
		                    attr: [id: "form_${form.id}",title:form.name,class: nodeClass,rel:nodeRel],
		                 	data: form.name,
							title: form.name,
							state:nodeState,					
							rel:nodeRel
						 ]
						}
					}
					render elementlist() as JSON
					break
				case "form":
					def form=Form.get(id)
					elements=FormItem.findAllByForm(form,[order:'asc',sort:'position'])	            			
					def elementlist = { elements.collect { formItem -> 
					
							def nodeRel='default'
							def nodeState = ""
							def nodeClass="jstree-default formitem formitem-${formItem.field.name}"
							
								
								
							[
		                    attr: [id: "formitem_${formItem.id}",title:formItem.field.name,class: nodeClass,rel:nodeRel],
		                 	data: formItem.field.name,
							title: formItem.field.name,
							state:nodeState,					
							rel:nodeRel
						 ]
						}
					}
					render elementlist() as JSON
					break				
				
				case "formitem":
					def res=[]
					render res as JSON
					break				
					
					
			}
			
			if (!params.id || params.id=="") {				
				elements=WorkflowDefinition.findAll([order:'asc',sort:'name'])	            			
				def elementlist = { elements.collect { workflow -> 
				
						def nodeRel='default'
						def nodeClass="jstree-default workflow workflow-${workflow.name}"
						
						def nodeState = ""	
							
						[
	                    attr: [id: "workflow_${workflow.id}",title:workflow.name,class: nodeClass,rel:nodeRel],
	                 	data: workflow.name,
						title: workflow.name,
						state:nodeState,					
						rel:nodeRel
					 ]
					}
				}			                                                                                        
				render elementlist() as JSON
			}
			
			
			
			
			
	}
	
	
	
	
    
}
