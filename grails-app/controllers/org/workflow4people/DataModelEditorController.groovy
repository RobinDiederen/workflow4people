package org.workflow4people
import grails.converters.*
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class DataModelEditorController {

	def grailsApplication
	def templateService
	def dialogService
	def dmeService
	def dmeEventService
	
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
			def id=params.id
            if (params.id.contains("_")){
				id=params.id.split("_")[1]
			}
            def fieldInstance = Field.get( id )

            if(!fieldInstance) {
                flash.message = "Field not found with id ${params.id}"
                redirect(action:list)
            }
            else { 
            	// find top level
            	def f= fieldInstance
            	while (f.parent!=null && f.parent !=f) {
            		f=f.parent
            	}
            	def fieldsInSameTree=f.getDescendants().sort{it.toString()}
            	
            	return [ fieldInstance : fieldInstance,fieldsInSameTree:fieldsInSameTree] 
	         }
        }
	
	def submitField = {
			println "Submit Field params: ${params}"
			def id=params.id
			if (id.contains("_")) {
				id=params.id.split("_")[1]
			}
			                            
			def fieldInstance = Field.get(id )
			fieldInstance.properties = params
			//fieldInstance.dependencyType=null
			println "dependencyType:"+fieldInstance.dependencyType
			println g.renderErrors(bean:fieldInstance)
			fieldInstance.save(failOnError:true)
			
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
	
	
	def editForm= {			
		def model= dialogService.edit(Form,params)
		model['formTemplateNames']=templateService.formTemplateNames
		if (!model['formInstance'].id) {
			model['formInstance'].formAction=Action.findByName('handle')
		}
		render(view:'/form/dialog',model:model)
	}
	
	
	
	
	def submitForm = {		     
	    println "Submit Form params: ${params}"        
	    def result =  dialogService.submit(Form,params)
	    def wfid
	    if (params.workflow?.id) {
	    	wfid=params.workflow?.id
	    } else {
	    	def formInstance = Form.get(params.id)	    	
	    	wfid=formInstance.workflow.id
	    } 
	    result['result']['refreshNodes']=["workflow_${wfid}"]
        render result as JSON
	}
	
			
	def editWorkflowDefinition = {
			def model= dialogService.edit(WorkflowDefinition,params) 
			render(view:'/workflowDefinition/dialog',model:model)
	}
	
	def submitWorkflowDefinition = {
			println "Submit WorkflowDefinition params: ${params}"

			def res = dialogService.submit(WorkflowDefinition,params)

			// for new workflows, add the request and show form automatically
			if (res.result.success && (params.id == "null")) {

				def instance = WorkflowDefinition.get(res.result.id)

				def showForm=new Form()
				showForm.workflow=instance
				showForm.name="show"
				showForm.title="Show"
				showForm.description="This form shows a ${instance.title}"
				showForm.explanationMessage="This form shows a ${instance.title}"	
				showForm.confirmationMessage="Show has no confirmation"
				showForm.template="show"
				showForm.formAction=Action.findByName("show")
				showForm.save(failOnError:true)

				def requestForm=new Form()
				requestForm.workflow=instance
				requestForm.name="request"
				requestForm.title="Request"
				requestForm.description="This form initiates a ${instance.title} workflow"
				requestForm.explanationMessage="This initiates a ${instance.title} workflow"
				requestForm.confirmationMessage="Thank you for filling in the ${instance.title} request form"
				requestForm.template="request"
				requestForm.formAction=Action.findByName("request")
				requestForm.save(failOnError:true)

			}

			//Add extra values to result (ex. refreshNodes)
			def theRefreshNodes=["workflowTree"]
			res.result += [returnValue:true, refreshNodes:theRefreshNodes]
			render res as JSON			
	}


		
	def editFormItem = {
			def model= dialogService.edit(FormItem,params) 
			render(view:'/formItem/dialog',model:model)
	}			
	
	def submitFormItem = {
		     
        println "Submit FormItem params: ${params}"        
        def result =  dialogService.submit(FormItem,params)
        
        def formid
	    if (params.form?.id) {
	    	wfid=params.form?.id
	    } else {
	    	def formItemInstance = FormItem.get(params.id)	    	
	    	formid=formItemInstance.form.id
	    } 
	    result['result']['refreshNodes']=["form_${formid}"]
        render result as JSON
        
	}

	
	def editFieldType = { 			
			def model= dialogService.edit(FieldType,params) 
			render(view:'/fieldType/dialog',model:model)
	}
	
	
    
	def submitFieldType = {
		println "Submit FieldType params: ${params}"
     	def result =  dialogService.submit(FieldType,params)

        result['result']['refreshNodes']=["dataModelTree"]
        render result as JSON
	}
	
    def submitFieldList = {

	    println "Submit FieldList params: ${params}"
	    def result =  dialogService.submit(FieldList,params)

	    result['result']['refreshNodes']=["fieldListTree"]
        render result as JSON	
	}
	
	def editFieldList = {
			def model= dialogService.edit(FieldList,params) 
			render(view:'/fieldList/dialog',model:model)			
    } 
	
	/*
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
    */
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
		def result=dmeEventService.defaultResult
		
		log.debug "before: func:${func}, node1:${node1.id}, node2:${node2.id} moveType:${moveType}, isCopy:${isCopy}" 
		switch(func) {
			case "move_node":
				if ((node1.type=="field") && (node2.type=="field")) {
					result=dmeEventService.dragFieldToField(node1,node2,moveType,isCopy)
				}
				if (node1.type.equals("fieldtype") && node2.type.equals("field")) {
					result=dmeEventService.dragFieldTypeToField(node1,node2,moveType,isCopy)
				}				
				if (node1.type.equals("fieldtype") && node2.type.equals("fieldtype") && (moveType.equals("inside"))) {
				   result=dmeEventService.dragFieldTypeToFieldType(node1,node2,moveType,isCopy) 
				}
				
				if (node1.type.equals("field") && node2.type.equals("fieldtype") && (moveType.equals("inside"))) {
					result=dmeEventService.dragFieldToFieldType(node1,node2,moveType,isCopy)
				 }
				
				
				if (node1.type=="field" && node2.type=="form" && moveType=="inside") {
					result=dmeEventService.dragFieldToForm(node1,node2,moveType,isCopy)				
				}
				
				if (node1.type=="fieldtype" && node2.type=="form" && moveType=="inside") {
					result=dmeEventService.dragFieldTypeToForm(node1,node2,moveType,isCopy)
				}
				
				
				if (node1.type=="field" && node2.type=="formitem" && moveType=="inside") {
					result=dmeEventService.dragFieldToFormItem(node1,node2,moveType,isCopy)
				}
				
				if (node1.type=="fieldtype" && node2.type=="formitem" && moveType=="inside") {
					result=dmeEventService.dragFieldTypeToFormItem(node1,node2,moveType,isCopy)
				}				
				
				if (node1.type=="field" && node2.type=="formitem" && moveType=="before") {
					result=dmeEventService.dragFieldBeforeFormItem(node1,node2,moveType,isCopy)
				}
				
				if (node1.type=="fieldtype" && node2.type=="formitem" && moveType=="before") {
					result=dmeEventService.dragFieldTypeBeforeFormItem(node1,node2,moveType,isCopy)
				}
				
				if (node1.type=="field" && node2.type=="formitem" && moveType=="after") {
					result=dmeEventService.dragFieldAfterFormItem(node1,node2,moveType,isCopy)
				}
				
				if (node1.type=="fieldtype" && node2.type=="formitem" && moveType=="after") {
					result=dmeEventService.dragFieldTypeAfterFormItem(node1,node2,moveType,isCopy)
				}
				
				
				if (node1.type=="formitem" && node2.type=="formitem" ) {
					result=dmeEventService.dragFormItemToFormItem(node1,node2,moveType,isCopy)
				}										
			break;
			
			case "rename_node":
				switch (node1.type) {
					case "field":
						result=dmeEventService.renameField(node1,newName)
					break
					case "fieldtype":
						result=dmeEventService.renameFieldType(node1,newName)
					break
					case "form":
						result=dmeEventService.renameForm(node1,newName)
					break
					case "workflow":
						result=dmeEventService.renameWorkflow(node1,newName)
					break
					
				}
				
			break;
			
			case "delete_node":
				switch(node1.type) {
					case "workflow":
						result= dmeEventService.deleteWorkflowDefinition(node1);
					break
					case "formitem":
						result= dmeEventService.deleteFormItem(node1);
					break
					case "form":
						result= dmeEventService.deleteForm(node1);
					break
					case "fieldtype":
						result= dmeEventService.deleteFieldType(node1);
					break
					case "field":
						result= dmeEventService.deleteField(node1);
				break
				}
			 

			
		}
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
			def fieldType=false
			if (!params.id || params.id=="") {				
				//elements=FieldType.findAllByListParentIsNotNull([order:'asc',sort:'name'])
				elements=FieldType.findAll([order:'asc',sort:'name'])
				fieldType=true
			} else {
				if (params.id.startsWith("field_")) {
					def id=new Integer(params.id.split("_")[1])
					def p=Field.get(id)
					elements=Field.findAllByParent(p,[sort:'fieldPosition'])
				} else {
					def id=new Integer(params.id.split("_")[1])
					def p=FieldType.get(id).listParent
					if(p) {
						elements=Field.findAllByParent(p,[sort:'fieldPosition'])
					}
					//elements=[p]
				}
			}
			
			def prefix=fieldType ? "fieldtype" : "field" 
			
			def elementlist = { elements.collect { f ->
					boolean hasChildren=false
					def cssClass=""
					if (f.class.name=="org.workflow4people.FieldType") {
						hasChildren=f.listParent!=null
						cssClass="fieldtype"

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
