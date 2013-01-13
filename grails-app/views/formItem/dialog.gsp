<dialog:form title="Form item" width="625px" object="${formItemInstance}">
	<dialog:table>		                            
		<dialog:textField object="${formItemInstance}" propertyName="id" mode="show" />		
		<dialog:textField object="${formItemInstance}" propertyName="position" mode="show" />
	    <dialog:treeselect object="${formItemInstance}" propertyName="field" root="fieldtype_${formItemInstance.formSection?.formPage?.form?.workflow?.documentType?.fieldType?.id}" /> 	    
	    <dialog:textField object="${formItemInstance}" propertyName="snippet" mode="edit" />
		<dialog:checkBox object="${formItemInstance}" propertyName="readonly" mode="edit" />		               		        	    		
	</dialog:table>		
</dialog:form>
