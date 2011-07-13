<wf:form title="Document type" width="675px">
	<wf:table>		                            
		<wf:textField object="${documentTypeInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${documentTypeInstance}" propertyName="name" mode="edit" />
		<wf:textArea object="${documentTypeInstance}" propertyName="description" mode="edit" />
		<wf:textField object="${documentTypeInstance}" propertyName="descriptionTemplate" mode="edit" class="wide" />
		<wf:date object="${documentTypeInstance}" propertyName="dateCreated" mode="show" />
		<wf:date object="${documentTypeInstance}" propertyName="lastUpdated" mode="show" />
		<wf:domainObject object="${documentTypeInstance}" propertyName="fieldList" mode="edit" />
		<wf:domainObject object="${documentTypeInstance}" propertyName="viewForm" mode="edit" />
		<wf:select multiple="true" class="multiselect" optionKey="id" object="${documentTypeInstance}" from="${org.workflow4people.DocumentIndexField.list(sort:'name')}" propertyName="documentIndexField" mode="edit" vertical="true" style="width:540px; height:200px;"/>		               		        	    				                        		                        		        	    		
	</wf:table>		
</wf:form>
