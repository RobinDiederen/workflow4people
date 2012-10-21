<dialog:form title="Document index field" width="795px" object="${documentIndexFieldInstance}">
	<dialog:table>		                            
		<dialog:textField object="${documentIndexFieldInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${documentIndexFieldInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${documentIndexFieldInstance}" propertyName="title" mode="edit" />
		<dialog:textArea object="${documentIndexFieldInstance}" propertyName="description" mode="edit" />
		<dialog:textField object="${documentIndexFieldInstance}" propertyName="xpath" class="extrawide" mode="edit" />
		<dialog:checkBox object="${documentIndexFieldInstance}" propertyName="publish" mode="edit" />                        		        	    		
	</dialog:table>		
</dialog:form>
