<dialog:form title="Workflow engine" object="${workflowEngineInstance}">
	<dialog:table>		                            
		<dialog:textField object="${workflowEngineInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${workflowEngineInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${workflowEngineInstance}" propertyName="title" mode="edit" />
		<dialog:textArea object="${workflowEngineInstance}" propertyName="description" mode="edit" />		
	</dialog:table>		
</dialog:form>
