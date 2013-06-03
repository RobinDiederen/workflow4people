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
		def model = [:]
		def urlSignavio = ApplicationConfiguration.findByConfigKey('wfp.dme.urlSignavio')
		model['urlSignavio'] = urlSignavio ? urlSignavio.configValue : '/signaviocore/p/editor'

    	render(view:'editor', model:model,params:params)    		
    }
	
	def workflow = {
		def workflowDefinition=WorkflowDefinition.get(params.id)
		def fieldType=workflowDefinition.documentType.fieldType
		def model = [:]
		def urlSignavio = ApplicationConfiguration.findByConfigKey('wfp.dme.urlSignavio')
		model['urlSignavio'] = urlSignavio ? urlSignavio.configValue : '/signaviocore/p/editor'
		model['workflowRoot'] = "root_${workflowDefinition.id}"
		model['modelRoot'] = "root_${fieldType.id}"
		render(view:'editor', model:model)		
	}
    
	def fieldType = {
		def fieldType=FieldType.get(params.id)
		
		def model = [:]
		def urlSignavio = ApplicationConfiguration.findByConfigKey('wfp.dme.urlSignavio')
		model['urlSignavio'] = urlSignavio ? urlSignavio.configValue : '/signaviocore/p/editor'
		
		model['modelRoot'] = "root_${fieldType.id}"
		render(view:'model', model:model)
	}
	
	def documentType = {
		def documentType=DocumentType.get(params.id)
		dialogService.check(documentType!=null,"dataModelEditor.documentType.notfound",[params.id])
		dialogService.check(documentType?.fieldType!=null,"dataModelEditor.documentType.nofieldtype",[documentType.name])
		
		def model = [:]
		def urlSignavio = ApplicationConfiguration.findByConfigKey('wfp.dme.urlSignavio')
		model['urlSignavio'] = urlSignavio ? urlSignavio.configValue : '/signaviocore/p/editor'
		
		model['modelRoot'] = "root_${documentType.fieldType?.id}"
		render(view:'model', model:model)
	}
	
	
	// ##############################################################
	
	def editField = {
		log.debug "Edit Field params: ${params}"
		def model = dialogService.edit(Field,params)
		
		//Find fields in the same tree (for "dependsOn" field)
		def fieldInstance
		if (params.parentType && params.parentType == "fieldtype") {
		        log.debug "Create Field under FieldType (parentId: ${params.parentId})"
		        fieldInstance=new Field()
		        fieldInstance.parent=FieldType.get(params.parentId)?.listParent

		} else {
		        if (params.id && params.id == 'null' && params.parentId && params.parentId != 'null') {
		                log.debug "Create new Field under other Field (parentId: ${params.parentId})"
		                fieldInstance = Field.get(params.parentId)
		        } else {
		                log.debug "Edit Field (parentId: ${params.id})"
		                fieldInstance = model?.fieldInstance
		        }
		}
		if (fieldInstance.id) {
		        def f = fieldInstance
		        while (f.parent!=null && f.parent !=f) {
		                f = f.parent
		        }
		        def fieldsInSameTree=f.getDescendants().sort{it.toString()}
		
		        model['fieldsInSameTree'] = fieldsInSameTree
		}
		model.fieldInstance=fieldInstance
		
		if (model.fieldInstance.fieldType?.baseType?.name) {
			println "OK adding templateSnippetConfig"
			model['templateSnippetConfig']=templateService.getSnippetConfig(model.fieldInstance.fieldType?.baseType?.name)
		}
		
		render(view:'/field/dialog',model:model)

    }

	
	
	def submitField = {
		log.debug "Submit Field params: ${params}"
		def fieldInstance
	    if (params.id && params.id != 'null') {
   			fieldInstance = Field.get(params.id)
   		} else {
	    	fieldInstance = Field.newInstance()
	    }
		fieldInstance.properties = params
		
		def res = dialogService.submit(Field,params,fieldInstance)

		//Add extra values to result (ex. refreshNodes)
		def theRefreshNodes=fieldInstance.parent?.id ?  ["field_${fieldInstance.parent.id}"] : ["dataModelTree"]
		res.result += [returnValue:true, refreshNodes:theRefreshNodes]
		render res as JSON		
	}
	
	/*
	* Creates new field under a FieldType. Creates the listParent field if it did not exist already
	*/
   def submitFieldUnderFieldType = {
	   log.debug "Submit Field params: ${params}"
	   // Create new listParent field if it didn't exist
	   def fieldType=FieldType.get(params.parentId)
	   if (!fieldType.listParent) {
			   def theListParent=new Field()
			   theListParent.name=fieldType.name
			   theListParent.parent=null
			   theListParent.fieldType=fieldType
			   theListParent.save(failOnError:true,flush:true)
			   fieldType.listParent=theListParent
			   fieldType.save(failOnError:true,flush:true)
	   }
	   def field=new Field()
	   field.properties = params
	   field.parent=fieldType.listParent
	   
	   //Add extra values to result (ex. refreshNodes)
	   def result = dialogService.submit(Field,params,field)
	   result["result"]+=[returnValue:true, refreshNodes:["fieldtype_${fieldType.id}"]]
	   render result as JSON
   }
	
   // ##############################################################
   
	def editForm= {
		log.debug "Edit Form params: ${params}"
		def model= dialogService.edit(Form,params)
		model['formTemplateNames']=templateService.formTemplateNames
		if (!model['formInstance'].id) {
			model['formInstance'].formAction=Action.findByName('handle')
		}
		render(view:'/form/dialog',model:model)
	}
	
	def submitForm = {		     
	    log.debug "Submit Form params: ${params}"
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
	
	// ##############################################################
			
	def editWorkflowDefinition = {
		log.debug "Edit WorkflowDefinition params: ${params}"
		def model= dialogService.edit(WorkflowDefinition,params) 
		render(view:'/workflowDefinition/dialog',model:model)
	}
	
	def submitWorkflowDefinition = {
			log.debug "Submit WorkflowDefinition params: ${params}"
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

	// ##############################################################
		
	def editFormItem = {
		log.debug "Edit FormItem params: ${params}"
		def model= dialogService.edit(FormItem,params) 
		render(view:'/formItem/dialog',model:model)
	}			
	
	def submitFormItem = {
        log.debug "Submit FormItem params: ${params}"        
        def result =  dialogService.submit(FormItem,params)
        
        def formSectionId
		if (params.formSection?.id) {
	    	formSectionId=params.formSection?.id
	    } else {
	    	def formItemInstance = FormItem.get(params.id)	    	
	    	formSectionId=formItemInstance.formSection.id
	    } 
	    result['result']['refreshNodes']=["formsection_${formSectionId}"]
        render result as JSON
        
	}

	// ##############################################################
	
	// TODO Deprecated, moved to FieldTypeController
	/* 
	def editFieldType = {
		log.debug "Edit FieldType params: ${params}"
		def model= dialogService.edit(FieldType,params)
		if (model.fieldTypeInstance?.baseType?.name) {
			model['templateSnippetConfig']=templateService.getSnippetConfig(model.fieldTypeInstance.baseType?.name)
		}
		 
		render(view:'/fieldType/dialog',model:model)
	}
	
	def submitFieldType = {
		log.debug "Submit FieldType params: ${params}"
     	def result =  dialogService.submit(FieldType,params)

        result['result']['refreshNodes']=["dataModelTree"]
        render result as JSON
	}
	*/
	// ##############################################################
	
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
				
				// Creating fields in sections from Field
				if (node1.type=="field" && node2.type=="formsection" && moveType=="inside") {
					result=dmeEventService.dragFieldToFormSection(node1,node2,moveType,isCopy)
				}
				// Creating fields in sections from FieldType
				if (node1.type=="fieldtype" && node2.type=="formsection" && moveType=="inside") {
					result=dmeEventService.dragFieldTypeToFormSection(node1,node2,moveType,isCopy)
				}
				
				// Section -> Section
				if (node1.type=="formsection" && node2.type=="formsection" ) {
					result=dmeEventService.dragFormSectionToFormSection(node1,node2,moveType,isCopy)
				}
				
				// Page -> Page
				if (node1.type=="formpage" && node2.type=="formpage") {
					result=dmeEventService.dragFormPageToFormPage(node1,node2,moveType,isCopy)
				}
				
				// PageForm -> Page
				if (node1.type=="formpage" && node2.type=="form") {
					result=dmeEventService.dragFormPageToForm(node1,node2,moveType,isCopy)
				}
				
														
			break;
			
			case "rename_node":
				switch (node1.type) {
					case "field":
						result=dmeEventService.rename(Field,node1,newName) { rslt.refreshNodes=[instance.visibleParentId]}						
					break					
					case "fieldtype":						
						result=dmeEventService.rename(FieldType,node1,newName) { rslt.refreshNodes=["dataModelTree"]}
					break
					case "form":
						result=dmeEventService.rename(Form,node1,newName) { rslt.refreshNodes=["workflow_${instance.workflow.id}"]}
					break
					case "workflow":
						result=dmeEventService.rename(WorkflowDefinition,node1,newName) { rslt.refreshNodes=["workflowTree"]}
					break
					
					case "formsection":
						result= dmeEventService.rename(FormSection,node1,newName) { rslt.refreshNodes=["formpage_${instance.formPage.id}"] }
					break
					
					case "formpage":
						result= dmeEventService.rename(FormPage,node1,newName) { rslt.refreshNodes=["form_${instance.form.id}"] }
					break
					
				}
				
			break;
			
			case "delete_node":
				switch(node1.type) {
					case "workflow":
						result= dmeEventService.deleteWorkflowDefinition(node1);
					break
					
					case "form":
						result= dmeEventService.deleteForm(node1);
					break
					
					case "formpage":
						result= dmeEventService.deleteFormPage(node1);
					break
					
					case "formsection":
						result= dmeEventService.deleteFormSection(node1);
					break
					
					case "formitem":
						result= dmeEventService.deleteFormItem(node1);
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
			log.debug "DELETE: ${params}"
			
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
			} else if (params.id.startsWith("root_")) {
				def id=new Integer(params.id.split("_")[1])
				elements=[FieldType.get(id)]
				fieldType=true
			} else {
				if (params.id.startsWith("field_")) {
					def id=new Integer(params.id.split("_")[1])
					def p=Field.get(id)
					elements=Field.findAllByParent(p,[sort:'position'])
				} else {
					def id=new Integer(params.id.split("_")[1])
					def p=FieldType.get(id).listParent
					if(p) {
						elements=Field.findAllByParent(p,[sort:'position'])
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
			                                           
		//	log.debug "ELEMENTLIST: ${elementlist()}"                                             
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
				
				case "root":					
					elements=[WorkflowDefinition.get(id)]
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
					
							def hasChildren=FormPage.countByForm(form)>0
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
					elements=FormPage.findAllByForm(form,[order:'asc',sort:'position'])	            			
					def elementlist = { elements.collect { formPage -> 
					
							def hasChildren=FormSection.countByFormPage(formPage)>0
							def nodeRel = hasChildren ? 'folder' : 'default'
							def nodeState =hasChildren ? 'closed' : ''
							def nodeClass="jstree-default formpage formpage-${formPage.name}"
							
								
								
							[
		                    attr: [id: "formpage_${formPage.id}",title:formPage.name,class: nodeClass,rel:nodeRel],
		                 	data: formPage.name,
							title: formPage.name,
							state:nodeState,					
							rel:nodeRel
						 ]
						}
					}
					render elementlist() as JSON
					break
					
				case "formpage":
					def formPage=FormPage.get(id)
					elements=FormSection.findAllByFormPage(formPage,[order:'asc',sort:'position'])
					def elementlist = { elements.collect { formSection ->
					
							def hasChildren=FormItem.countByFormSection(formSection)>0
							def nodeRel = hasChildren ? 'folder' : 'default'
							def nodeState =hasChildren ? 'closed' : ''
							def nodeClass="jstree-default formsection formsection-${formSection.name}"
								
							[
							attr: [id: "formsection_${formSection.id}",title:formSection.name,class: nodeClass,rel:nodeRel],
							 data: formSection.name,
							title: formSection.name,
							state:nodeState,
							rel:nodeRel
						 ]
						}
					}
					render elementlist() as JSON
					break
					
				
				
				case "formsection":
						def form=FormSection.get(id)
						elements=FormItem.findAllByFormSection(form,[order:'asc',sort:'position'])
						def elementlist = { elements.collect { formItem ->
												
							def nodeRel = 'default'
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
