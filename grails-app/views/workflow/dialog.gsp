<wf:form title="Workflow">
	<wf:tabs names="Details,Tasks,Log" object="${workflowInstance}">		
		<wf:tab name="Details" object="${workflowInstance}">		                            
	        <wf:textField object="${workflowInstance}" propertyName="id" mode="show" />
			
			<wf:textField object="${workflowInstance}" propertyName="externalId" mode="edit" />
	        <wf:domainObject object="${workflowInstance}" propertyName="workflowEngine" mode="edit" />
	                     
			<wf:domainObject object="${workflowInstance}" propertyName="workflowDefinition" mode="edit" />
			<wf:domainObject object="${workflowInstance}" propertyName="document" mode="edit" sort="id"/>
			
	        <wf:textField object="${workflowInstance}" propertyName="priority" mode="edit" />
	        <wf:textField object="${workflowInstance}" propertyName="status" mode="edit" />
	        
	        
			<wf:date object="${workflowInstance}" propertyName="dateCreated" mode="show" />
			<wf:date object="${workflowInstance}" propertyName="lastUpdated" mode="show" />
			<wf:date object="${workflowInstance}" propertyName="dueDate" mode="show" />
			
			<wf:date object="${workflowInstance}" propertyName="completionDate" mode="show" />
			
		</wf:tab>
		<wf:tab name="Log" object="${workflowInstance}">
			<wf:detailTable property="workflow" object="${workflowInstance}" domainClass="${org.workflow4people.WorkflowLog}" />			
		</wf:tab>
		<wf:tab name="Tasks" object="${workflowInstance}">
			<wf:detailTable property="workflow" object="${workflowInstance}" domainClass="${org.workflow4people.Task}" />
		</wf:tab>		
	</wf:tabs>
	
</wf:form>
