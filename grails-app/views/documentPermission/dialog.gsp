<dialog:form title="Document permission" object="${documentPermissionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${documentPermissionInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${documentPermissionInstance}" propertyName="authority" mode="edit" sort="authority"/>
		<dialog:domainObject object="${documentPermissionInstance}" propertyName="role" mode="edit" />
		<dialog:textArea object="${documentPermissionInstance}" propertyName="remark" mode="edit" />	    		
	</dialog:table>		
</dialog:form>
