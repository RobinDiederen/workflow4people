<dialog:form title="Form item" width="625px" object="${formItemInstance}">
	<dialog:table>		                            
		<dialog:textField object="${formItemInstance}" propertyName="id" mode="show" />
		<dialog:domainObject object="${formItemInstance}" propertyName="formSection" mode="show" />
		                                                        
		<dialog:textField object="${formItemInstance}" propertyName="position" mode="edit" />
	    <dialog:domainObject object="${formItemInstance}" propertyName="field" mode="edit" />
	    <dialog:textField object="${formItemInstance}" propertyName="snippet" mode="edit" />
		<dialog:checkBox object="${formItemInstance}" propertyName="readonly" mode="edit" />		               		        	    		
	</dialog:table>		
</dialog:form>
