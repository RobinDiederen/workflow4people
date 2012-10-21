<dialog:form title="Document index" object="${documentIndexInstance}">
	<dialog:table>		                            
		<dialog:textField object="${documentIndexInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${documentIndexInstance}" propertyName="document" mode="show" />

		<dialog:textField object="${documentIndexInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${documentIndexInstance}" propertyName="value" mode="edit" />
	</dialog:table>		
</dialog:form>
