<dialog:form title="Form page" width="625px" object="${formPageInstance}">
	<dialog:table>		                            
		<dialog:textField object="${formPageInstance}" propertyName="id" mode="show" />
		<dialog:textField object="${formPageInstance}" propertyName="position" mode="show" />
	    <dialog:textField object="${formPageInstance}" propertyName="name" mode="edit" />
	    <dialog:textField object="${formPageInstance}" propertyName="title" mode="edit" />
	    <dialog:textField object="${formPageInstance}" propertyName="message" mode="edit" />
	    
	</dialog:table>		
</dialog:form>
