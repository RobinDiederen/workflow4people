<wf:form title="Action" >
	<wf:table>		                            
		<wf:textField object="${actionInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${actionInstance}" propertyName="name" mode="edit" />
		<wf:textField object="${actionInstance}" propertyName="title" mode="edit" />
		<wf:textArea object="${actionInstance}" propertyName="description" mode="edit" />		
	</wf:table>		
</wf:form>
