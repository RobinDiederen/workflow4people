<dialog:form title="Feature permission" object="${featurePermissionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${featurePermissionInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${featurePermissionInstance}" propertyName="feature" mode="show" />		       
		<dialog:domainObject object="${featurePermissionInstance}" propertyName="authority" mode="edit" sort="authority"/>
		<dialog:domainObject object="${featurePermissionInstance}" propertyName="role" mode="edit" />
		<dialog:textArea object="${featurePermissionInstance}" propertyName="remark" mode="edit" />	    		
	</dialog:table>		
</dialog:form>
