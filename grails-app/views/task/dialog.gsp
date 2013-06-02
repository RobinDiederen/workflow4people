<dialog:form title="Task" object="${taskInstance}" height="500px">
	<dialog:tabs names="ID,Details,Description,Status,Dates" object="${taskInstance}">
		<dialog:tab name="ID" object="${taskInstance}">
			<dialog:textField object="${taskInstance}" propertyName="id" mode="show" />
	        <dialog:textField object="${taskInstance}" propertyName="externalId" mode="edit" />
	        <dialog:textField object="${taskInstance}" propertyName="externalWorkflowId" mode="edit" />
	        <dialog:domainObject object="${taskInstance}" propertyName="workflow" mode="show" />	        
		</dialog:tab>		
		<dialog:tab name="Details" object="${taskInstance}">
			<dialog:select object="${taskInstance}" propertyName="outcome" mode="edit" from="${taskInstance.getTransitionsArray()}" />				                     
			<dialog:domainObject object="${taskInstance}" propertyName="form" mode="edit" />
			<dialog:textField object="${taskInstance}" propertyName="transitions" mode="edit" />
	        <dialog:textField object="${taskInstance}" propertyName="priority" mode="edit" />
	        <dialog:textField object="${taskInstance}" propertyName="cssClass" mode="edit" />
			<dialog:checkBox object="${taskInstance}" propertyName="noMessage" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Description" object="${taskInstance}">
			<dialog:textArea noLabel="true" noHelp="true" style="width:450px;height:270px" object="${taskInstance}" propertyName="description" mode="edit"/>			
		</dialog:tab>
		
		<dialog:tab name="Status" object="${taskInstance}">
			<dialog:domainObject object="${taskInstance}" propertyName="taskStatus" mode="edit"/>
			<dialog:textField object="${taskInstance}" propertyName="statusUser" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Dates" object="${taskInstance}">
			<dialog:date object="${taskInstance}" propertyName="dateCreated" mode="show" />
			<dialog:date object="${taskInstance}" propertyName="lastUpdated" mode="show" />
			<dialog:date object="${taskInstance}" propertyName="dueDate" mode="show" />			
			<dialog:date object="${taskInstance}" propertyName="completionDate" mode="show" />				
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
