<wf:form title="Task" object="${taskInstance}">
	<wf:table>		                            

	        <wf:textField object="${taskInstance}" propertyName="id" mode="show" />
	        <wf:textField object="${taskInstance}" propertyName="externalId" mode="edit" />
	        <wf:textField object="${taskInstance}" propertyName="externalWorkflowId" mode="edit" />
	        <wf:domainObject object="${taskInstance}" propertyName="workflow" mode="show" />
	        
	        <wf:textArea object="${taskInstance}" propertyName="description" mode="edit"/>

			<wf:select object="${taskInstance}" propertyName="outcome" mode="edit" from="${taskInstance.getTransitionsArray()}" />				                     
			<wf:domainObject object="${taskInstance}" propertyName="form" mode="edit" />
			
			
	        <wf:textField object="${taskInstance}" propertyName="priority" mode="edit" />
	        <wf:textField object="${taskInstance}" propertyName="cssClass" mode="edit" />
	        
			<wf:date object="${taskInstance}" propertyName="dateCreated" mode="show" />
			<wf:date object="${taskInstance}" propertyName="lastUpdated" mode="show" />
			<wf:date object="${taskInstance}" propertyName="dueDate" mode="show" />			
			<wf:date object="${taskInstance}" propertyName="completionDate" mode="show" />
			
			<wf:checkBox object="${taskInstance}" propertyName="noMessage" mode="edit" />

		</wf:table>
	
</wf:form>
