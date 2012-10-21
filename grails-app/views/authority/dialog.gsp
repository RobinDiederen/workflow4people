<dialog:form title="Group" object="${authorityInstance}">
	<dialog:table>		                            
		<dialog:textField object="${authorityInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${authorityInstance}" propertyName="authority" mode="edit" />
		<dialog:textArea object="${authorityInstance}" propertyName="description" mode="edit" />
		<dialog:textField object="${authorityInstance}" propertyName="authorityType" mode="edit" />		
	</dialog:table>		
</dialog:form>
