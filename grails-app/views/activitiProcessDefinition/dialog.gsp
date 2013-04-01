<dialog:form title="Activiti Process definition" object="${processDefinition}" height="740px">
	<dialog:tabs names="Details,Upload" object="${processDefinition}">		
		<dialog:tab name="Details" object="${processDefinition}">		                            
	        <dialog:textField object="${processDefinition}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${processDefinition}" propertyName="name" mode="edit" />			
			<dialog:textField object="${processDefinition}" propertyName="key" mode="edit" />
			<dialog:textField object="${processDefinition}" propertyName="version" mode="edit" />
			<dialog:textArea object="${processDefinition}" propertyName="description" mode="edit" />	        
		</dialog:tab>
		<dialog:tab name="Upload" object="${processDefinition}">						
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>
