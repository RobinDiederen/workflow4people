<dialog:form title="Workflow" object="${workflowDefinitionInstance}" height="520px">
	<dialog:tabs names="Details,Description,Forms,Permissions,Dates" object="${workflowDefinitionInstance}">		
		<dialog:tab name="Details" object="${workflowDefinitionInstance}">		                            
	        <dialog:textField object="${workflowDefinitionInstance}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${workflowDefinitionInstance}" propertyName="name" mode="edit" />
			
			<dialog:textField object="${workflowDefinitionInstance}" propertyName="title" mode="edit" />
			<dialog:textField object="${workflowDefinitionInstance}" propertyName="version" mode="edit" />
			
			
	        
	        <dialog:domainObject object="${workflowDefinitionInstance}" propertyName="documentType" mode="edit" />
    	    <dialog:domainObject object="${workflowDefinitionInstance}" propertyName="workflowEngine" mode="edit" />
    	    
    	    <dialog:checkBox object="${workflowDefinitionInstance}" propertyName="publish" mode="edit" />
			<dialog:checkBox object="${workflowDefinitionInstance}" propertyName="run" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Description" object="${workflowDefinitionInstance}">
			<dialog:textArea style="width:500px;height:200px;" noLabel="true" noHelp="true" object="${workflowDefinitionInstance}" propertyName="description" mode="edit" />			
		</dialog:tab>
		<dialog:tab name="Forms" object="${workflowDefinitionInstance}">
			<dialog:detailTable property="workflow" object="${workflowDefinitionInstance}" domainClass="${org.workflow4people.Form}" />			
		</dialog:tab>
		<dialog:tab name="Permissions" object="${workflowDefinitionInstance}">
			<dialog:detailTable property="workflow" object="${workflowDefinitionInstance}" domainClass="${org.workflow4people.WorkflowPermission}" />
		</dialog:tab>
		<dialog:tab name="Dates" object="${workflowDefinitionInstance}">		                            
	        <dialog:date object="${workflowDefinitionInstance}" propertyName="dateCreated" mode="show" />
			<dialog:date object="${workflowDefinitionInstance}" propertyName="lastUpdated" mode="show" />
			<dialog:date object="${workflowDefinitionInstance}" propertyName="processDefinitionDate" mode="show" />			
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>