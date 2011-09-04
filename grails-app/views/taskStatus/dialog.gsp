<wf:form title="Task status" object="${taskStatusInstance}">
	<wf:table>		                            
	        <wf:textField object="${taskStatusInstance}" propertyName="id" mode="show" />
	        <wf:textField object="${taskStatusInstance}" propertyName="name" mode="edit" />
	        <wf:textField object="${taskStatusInstance}" propertyName="title" mode="edit" />	        
	        <wf:textArea object="${taskStatusInstance}" propertyName="description" mode="edit"/>
	        <wf:textArea object="${taskStatusInstance}" propertyName="cssClass" mode="edit"/>			
		</wf:table>	
</wf:form>
