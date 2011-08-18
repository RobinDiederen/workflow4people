<wf:form title="Workflow permission" object="${workflowPermissionInstance}">
	<wf:table>		                            
		<wf:textField object="${workflowPermissionInstance}" propertyName="id" mode="show" />
		<wf:domainObject object="${workflowPermissionInstance}" propertyName="workflow" mode="show" />
		<wf:domainObject object="${workflowPermissionInstance}" propertyName="authority" mode="edit" sort="authority"/>
		<wf:domainObject object="${workflowPermissionInstance}" propertyName="role" mode="edit" />
		<wf:textArea object="${workflowPermissionInstance}" propertyName="remark" mode="edit" />
				
	</wf:table>		
</wf:form>
