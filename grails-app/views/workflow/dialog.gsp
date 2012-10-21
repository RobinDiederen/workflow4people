<dialog:form title="Workflow" object="${workflowInstance}">
	<dialog:tabs names="Details,Tasks,Log" object="${workflowInstance}">		
		<dialog:tab name="Details" object="${workflowInstance}">		                            
	        <dialog:textField object="${workflowInstance}" propertyName="id" mode="show" />
			
			<dialog:textField object="${workflowInstance}" propertyName="externalId" mode="edit" />
	        <dialog:domainObject object="${workflowInstance}" propertyName="workflowEngine" mode="edit" />
	                     
			<dialog:domainObject object="${workflowInstance}" propertyName="workflowDefinition" mode="edit" />
			 
			<dialog:domainObject object="${workflowInstance}" propertyName="document" mode="show" sort="id"/>
			 
	        <dialog:textField object="${workflowInstance}" propertyName="priority" mode="edit" />
	        <dialog:textField object="${workflowInstance}" propertyName="status" mode="edit" />
	        
	        
			<dialog:date object="${workflowInstance}" propertyName="dateCreated" mode="show" />
			<dialog:date object="${workflowInstance}" propertyName="lastUpdated" mode="show" />
			<dialog:date object="${workflowInstance}" propertyName="dueDate" mode="show" />
			
			<dialog:date object="${workflowInstance}" propertyName="completionDate" mode="show" />
			
		</dialog:tab>
		
		<dialog:tab name="Log" object="${workflowInstance}">
			<dialog:detailTable property="workflow" object="${workflowInstance}" domainClass="${org.workflow4people.WorkflowLog}" />			
		</dialog:tab>
		<dialog:tab name="Tasks" object="${workflowInstance}">
			<dialog:detailTable property="workflow" object="${workflowInstance}" domainClass="${org.workflow4people.Task}" />
		</dialog:tab>
				
	</dialog:tabs>
	
</dialog:form>
