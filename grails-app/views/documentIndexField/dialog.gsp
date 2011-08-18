<wf:form title="Document index field" width="795px" object="${documentIndexFieldInstance}">
	<wf:table>		                            
		<wf:textField object="${documentIndexFieldInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${documentIndexFieldInstance}" propertyName="name" mode="edit" />
		<wf:textField object="${documentIndexFieldInstance}" propertyName="title" mode="edit" />
		<wf:textArea object="${documentIndexFieldInstance}" propertyName="description" mode="edit" />
		<wf:textField object="${documentIndexFieldInstance}" propertyName="xpath" class="extrawide" mode="edit" />
		<wf:checkBox object="${documentIndexFieldInstance}" propertyName="publish" mode="edit" />                        		        	    		
	</wf:table>		
</wf:form>
