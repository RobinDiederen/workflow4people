<wf:form title="Feature permission" >
	<wf:table>		                            
		<wf:textField object="${featurePermissionInstance}" propertyName="id" mode="show" />
		<wf:domainObject object="${featurePermissionInstance}" propertyName="feature" mode="show" />		       
		<wf:domainObject object="${featurePermissionInstance}" propertyName="authority" mode="edit" sort="authority"/>
		<wf:domainObject object="${featurePermissionInstance}" propertyName="role" mode="edit" />
		<wf:textArea object="${featurePermissionInstance}" propertyName="remark" mode="edit" />	    		
	</wf:table>		
</wf:form>
