<dialog:form title="Action" object="${actionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${actionInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${actionInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${actionInstance}" propertyName="title" mode="edit" />
		<dialog:textArea object="${actionInstance}" propertyName="description" mode="edit" />		
	</dialog:table>		
</dialog:form>
