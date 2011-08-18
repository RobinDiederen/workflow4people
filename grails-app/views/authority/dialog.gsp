<wf:form title="Group" object="${authorityInstance}">
	<wf:table>		                            
		<wf:textField object="${authorityInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${authorityInstance}" propertyName="authority" mode="edit" />
		<wf:textArea object="${authorityInstance}" propertyName="description" mode="edit" />
		<wf:textField object="${authorityInstance}" propertyName="authorityType" mode="edit" />		
	</wf:table>		
</wf:form>
