<wf:form title="Field type">
	<wf:tabs names="Details,Text,List,Advanced" object="${fieldTypeInstance}">		
		<wf:tab name="Details" object="${fieldTypeInstance}">		                            
	        <wf:textField object="${fieldTypeInstance}" propertyName="id" mode="show" />                                                      
	        <wf:textField object="${fieldTypeInstance}" propertyName="name" mode="edit" />
	        
	        <wf:domainObject object="${fieldTypeInstance}" propertyName="namespace" mode="edit" sort="prefix"/>
	        <wf:domainObject object="${fieldTypeInstance}" propertyName="baseType" mode="edit" />
	        <wf:textField object="${fieldTypeInstance}" propertyName="baseSchemaType" mode="edit" />
	        
	        <wf:textArea object="${fieldTypeInstance}" propertyName="description" mode="edit" />
	        
	        <wf:textField object="${fieldTypeInstance}" propertyName="defaultValue" mode="edit" />
	        <wf:textField object="${fieldTypeInstance}" propertyName="label" mode="edit" />
	    		    		
		</wf:tab>
		<wf:tab name="Text" object="${fieldTypeInstance}">
			<wf:textArea object="${fieldTypeInstance}" propertyName="help" mode="edit" />
	        <wf:textArea object="${fieldTypeInstance}" propertyName="alert" mode="edit" />	    	
		</wf:tab>
		<wf:tab name="List" object="${fieldTypeInstance}">
			<wf:checkBox object="${fieldTypeInstance}" propertyName="runtimeEditableList" mode="edit" />
			<wf:detailTable property="fieldType" object="${fieldTypeInstance}" domainClass="${org.workflow4people.FieldTypeItem}" />	    	
		</wf:tab>
		
		<wf:tab name="Advanced" object="${fieldTypeInstance}">
			<wf:checkBox object="${fieldTypeInstance}" propertyName="generateSchemaType" mode="edit" />
			<wf:checkBox object="${fieldTypeInstance}" propertyName="restrictions" mode="edit" />
			
			<wf:textField object="${fieldTypeInstance}" propertyName="length" mode="edit" />
			<wf:textField object="${fieldTypeInstance}" propertyName="minLength" mode="edit" />
			<wf:textField object="${fieldTypeInstance}" propertyName="maxLength" mode="edit" />
			
			
			<wf:textField object="${fieldTypeInstance}" propertyName="pattern" mode="edit" />
			
			<wf:textField object="${fieldTypeInstance}" propertyName="minInclusive" mode="edit" />
			<wf:textField object="${fieldTypeInstance}" propertyName="maxInclusive" mode="edit" />
			
			<wf:textField object="${fieldTypeInstance}" propertyName="minExclusive" mode="edit" />
			<wf:textField object="${fieldTypeInstance}" propertyName="maxExclusive" mode="edit" />
			
		</wf:tab>
	</wf:tabs>
</wf:form>
