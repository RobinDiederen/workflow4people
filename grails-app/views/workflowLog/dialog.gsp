<dialog:form object="${workflowLogInstance}">
	<dialog:table>		                            
	        <dialog:textField object="${workflowLogInstance}" propertyName="id" mode="show" />
	        <dialog:dateTime object="${workflowLogInstance}" propertyName="dateCreated" mode="show" />
	        <dialog:domainObject object="${workflowLogInstance}" propertyName="person" mode="show" />	        
	        <dialog:textArea object="${workflowLogInstance}" propertyName="message" mode="show" />	        			
		</dialog:table>	
</dialog:form>
