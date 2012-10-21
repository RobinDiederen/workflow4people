<dialog:form title="Document type" width="820px" object="${documentTypeInstance}">
	<dialog:table>		                            
		<dialog:textField object="${documentTypeInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${documentTypeInstance}" propertyName="name" mode="edit" />
		<dialog:textArea object="${documentTypeInstance}" propertyName="description" mode="edit" />
		<dialog:textField object="${documentTypeInstance}" propertyName="descriptionTemplate" mode="edit" class="wide" />
		<dialog:date object="${documentTypeInstance}" propertyName="dateCreated" mode="show" />
		<dialog:date object="${documentTypeInstance}" propertyName="lastUpdated" mode="show" />
		<dialog:domainObject object="${documentTypeInstance}" propertyName="fieldType" mode="edit" />
		<dialog:select multiple="true" class="altselect" optionKey="id" object="${documentTypeInstance}" from="${org.workflow4people.DocumentIndexField.list(sort:'name')}" propertyName="documentIndexField" mode="edit"/>
		<dialog:checkBox object="${documentTypeInstance}" propertyName="useCmis" mode="edit" />
		<dialog:textField object="${documentTypeInstance}" propertyName="cmisPathTemplate" mode="edit" class="extrawide" />
	</dialog:table>		
</dialog:form>
