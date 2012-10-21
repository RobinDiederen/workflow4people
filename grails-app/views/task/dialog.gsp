<dialog:form title="Task" object="${taskInstance}">
	<dialog:table>		                            

	        <dialog:textField object="${taskInstance}" propertyName="id" mode="show" />
	        <dialog:textField object="${taskInstance}" propertyName="externalId" mode="edit" />
	        <dialog:textField object="${taskInstance}" propertyName="externalWorkflowId" mode="edit" />
	        <dialog:domainObject object="${taskInstance}" propertyName="workflow" mode="show" />
	        
	        <dialog:textArea object="${taskInstance}" propertyName="description" mode="edit"/>

			<dialog:select object="${taskInstance}" propertyName="outcome" mode="edit" from="${taskInstance.getTransitionsArray()}" />				                     
			<dialog:domainObject object="${taskInstance}" propertyName="form" mode="edit" />
			
			<dialog:domainObject object="${taskInstance}" propertyName="taskStatus" mode="edit"/>
			<dialog:textField object="${taskInstance}" propertyName="statusUser" mode="edit" />
			
	        <dialog:textField object="${taskInstance}" propertyName="priority" mode="edit" />
	        <dialog:textField object="${taskInstance}" propertyName="cssClass" mode="edit" />
	        
			<dialog:date object="${taskInstance}" propertyName="dateCreated" mode="show" />
			<dialog:date object="${taskInstance}" propertyName="lastUpdated" mode="show" />
			<dialog:date object="${taskInstance}" propertyName="dueDate" mode="show" />			
			<dialog:date object="${taskInstance}" propertyName="completionDate" mode="show" />
			
			<dialog:checkBox object="${taskInstance}" propertyName="noMessage" mode="edit" />

		</dialog:table>
	
</dialog:form>
