<dialog:form title="Task status" object="${taskStatusInstance}">
	<dialog:table>		                            
	        <dialog:textField object="${taskStatusInstance}" propertyName="id" mode="show" />
	        <dialog:textField object="${taskStatusInstance}" propertyName="name" mode="edit" />
	        <dialog:textField object="${taskStatusInstance}" propertyName="title" mode="edit" />	        
	        <dialog:textArea object="${taskStatusInstance}" propertyName="description" mode="edit"/>
	        <dialog:textArea object="${taskStatusInstance}" propertyName="cssClass" mode="edit"/>			
		</dialog:table>	
</dialog:form>
