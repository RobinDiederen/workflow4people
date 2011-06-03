<wf:form title="Edit field">
	<wf:table names="Details,Text,Advanced" object="${fieldInstance}">		                            
		<wf:textField object="${baseTypeInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${baseTypeInstance}" propertyName="name" mode="edit" />                                                    
		<wf:textArea object="${baseTypeInstance}" propertyName="description" mode="edit" />                        		        	    		
	</wf:table>		
</wf:form>
