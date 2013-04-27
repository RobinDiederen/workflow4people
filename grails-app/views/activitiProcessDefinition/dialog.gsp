<dialog:form title="Activiti Process definition" object="${processDefinitionCommand}" >
	<dialog:tabs names="Details,Diagram" object="${processDefinitionCommand}">		
		<dialog:tab name="Details" object="${processDefinitionCommand}">		                            
	        <dialog:textField object="${processDefinitionCommand}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${processDefinitionCommand}" propertyName="name" mode="show" />			
			<dialog:textField object="${processDefinitionCommand}" propertyName="key" mode="show" />
			<dialog:textField object="${processDefinitionCommand}" propertyName="diagramResourceName" mode="show" />
			<dialog:textField object="${processDefinitionCommand}" propertyName="version" mode="show" />
			<dialog:textArea object="${processDefinitionCommand}" propertyName="description" mode="show" />	        
		</dialog:tab>
		<dialog:tab name="Diagram" object="${processDefinitionCommand}">			
			<img src="${createLink(action:'diagram',id:processDefinitionCommand.id)}" />			
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
