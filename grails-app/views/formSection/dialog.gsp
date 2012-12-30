<dialog:form title="Form section" width="625px" object="${formSectionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${formSectionInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${formSectionInstance}" propertyName="formPage" mode="show" />		                                                        
		<dialog:textField object="${formSectionInstance}" propertyName="position" mode="edit" />
	    <dialog:textField object="${formSectionInstance}" propertyName="name" mode="edit" />
	    <dialog:textField object="${formSectionInstance}" propertyName="title" mode="edit" />
	    <dialog:textField object="${formSectionInstance}" propertyName="message" mode="edit" />
	    <dialog:detailTable property="formSection" object="${formSectionInstance}" domainClass="${org.workflow4people.FormItem}" />
	</dialog:table>		
</dialog:form>
