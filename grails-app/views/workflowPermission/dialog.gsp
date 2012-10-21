<dialog:form title="Workflow permission" object="${workflowPermissionInstance}">
	<dialog:table>		                            
		<dialog:textField object="${workflowPermissionInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${workflowPermissionInstance}" propertyName="workflow" mode="show" />
		<dialog:domainObject object="${workflowPermissionInstance}" propertyName="authority" mode="edit" sort="authority"/>
		<dialog:domainObject object="${workflowPermissionInstance}" propertyName="role" mode="edit" />
		<dialog:textArea object="${workflowPermissionInstance}" propertyName="remark" mode="edit" />
				
	</dialog:table>		
</dialog:form>
