<wf:form title="Workflow">
	<wf:tabs names="Details,Forms,Permissions" object="${workflowDefinitionInstance}">		
		<wf:tab name="Details" object="${workflowDefinitionInstance}">		                            
	        <wf:textField object="${workflowDefinitionInstance}" propertyName="id" mode="show" />                            
	        <wf:textField object="${workflowDefinitionInstance}" propertyName="name" mode="edit" />
			
			<wf:textField object="${workflowDefinitionInstance}" propertyName="title" mode="edit" />
			<wf:textField object="${workflowDefinitionInstance}" propertyName="version" mode="edit" />
			<wf:date object="${workflowDefinitionInstance}" propertyName="dateCreated" mode="show" />
			<wf:date object="${workflowDefinitionInstance}" propertyName="lastUpdated" mode="show" />
			<wf:date object="${workflowDefinitionInstance}" propertyName="processDefinitionDate" mode="show" />
			
			<wf:textArea object="${workflowDefinitionInstance}" propertyName="description" mode="edit" />
	        
	        <wf:domainObject object="${workflowDefinitionInstance}" propertyName="documentType" mode="edit" />
    	    <wf:domainObject object="${workflowDefinitionInstance}" propertyName="workflowEngine" mode="edit" />
	        	    		
		</wf:tab>
		<wf:tab name="Forms" object="${workflowDefinitionInstance}">
			<wf:detailTable property="workflow" object="${workflowDefinitionInstance}" domainClass="${org.workflow4people.Form}" />			
		</wf:tab>
		<wf:tab name="Permissions" object="${workflowDefinitionInstance}">
			<wf:detailTable property="workflow" object="${workflowDefinitionInstance}" domainClass="${org.workflow4people.WorkflowPermission}" />
		</wf:tab>
	</wf:tabs>
</wf:form>
