<wf:form title="Form item" >
	<wf:table>		                            
		<wf:textField object="${formItemInstance}" propertyName="id" mode="show" />
		<wf:domainObject object="${formItemInstance}" propertyName="form" mode="show" />
		                                                        
		<wf:textField object="${formItemInstance}" propertyName="position" mode="edit" />
	    <wf:domainObject object="${formItemInstance}" propertyName="field" mode="edit" />
	    <wf:textField object="${formItemInstance}" propertyName="snippet" mode="edit" />
		<wf:checkBox object="${formItemInstance}" propertyName="readonly" mode="edit" />		               		        	    		
	</wf:table>		
</wf:form>
