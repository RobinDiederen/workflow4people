<wf:form title="Document index field" >
	<wf:table>		                            
		<wf:textField object="${documentIndexInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${documentIndexInstance}" propertyName="name" mode="edit" />
		<wf:textField object="${documentIndexInstance}" propertyName="title" mode="edit" />
		<wf:textArea object="${documentIndexInstance}" propertyName="description" mode="edit" />
		<wf:textField object="${documentIndexInstance}" propertyName="xpath" class="extrawide" mode="edit" />
		<wf:select object="${documentIndexInstance}" propertyName="title" mode="edit" />
		<wf:checkBox object="${documentIndexInstance}" propertyName="publish" mode="edit" />                        		        	    		
	</wf:table>		
</wf:form>
