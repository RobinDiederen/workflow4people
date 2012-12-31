<dialog:form title="Form section" width="625px" object="${formSectionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${formSectionInstance}" propertyName="id" mode="show" />
		<dialog:textField object="${formSectionInstance}" propertyName="position" mode="show" />
	    <dialog:textField object="${formSectionInstance}" propertyName="name" mode="edit" />
	    <dialog:textField object="${formSectionInstance}" propertyName="title" mode="edit" />
	    <dialog:textField object="${formSectionInstance}" propertyName="message" mode="edit" />
	</dialog:table>		
</dialog:form>
