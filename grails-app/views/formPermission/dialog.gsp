<dialog:form title="Form permission" object="${formPermissionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${formPermissionInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${formPermissionInstance}" propertyName="form" mode="show" />		       
		<dialog:domainObject object="${formPermissionInstance}" propertyName="authority" mode="edit" sort="authority"/>
		<dialog:domainObject object="${formPermissionInstance}" propertyName="role" mode="edit" />
		<dialog:textArea object="${formPermissionInstance}" propertyName="remark" mode="edit" />	    		
	</dialog:table>		
</dialog:form>
