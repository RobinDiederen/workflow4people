<dialog:form title="Field type" object="${fieldTypeInstance}">
	<dialog:tabs names="Details,Text,List,Advanced" object="${fieldTypeInstance}">		
		<dialog:tab name="Details" object="${fieldTypeInstance}">		                            
	        <dialog:textField object="${fieldTypeInstance}" propertyName="id" mode="show" />                                                      
	        <dialog:textField object="${fieldTypeInstance}" propertyName="name" mode="edit" />
	        
	        <dialog:domainObject object="${fieldTypeInstance}" propertyName="namespace" mode="edit" sort="prefix"/>
	        <dialog:domainObject object="${fieldTypeInstance}" propertyName="baseType" mode="edit" />
	        <dialog:textField object="${fieldTypeInstance}" propertyName="baseSchemaType" mode="edit" />
	        
	        <dialog:textArea object="${fieldTypeInstance}" propertyName="description" mode="edit" />
	        
	        <dialog:textField object="${fieldTypeInstance}" propertyName="defaultValue" mode="edit" />
	        <dialog:textField object="${fieldTypeInstance}" propertyName="label" mode="edit" />
	    		    		
		</dialog:tab>
		<dialog:tab name="Text" object="${fieldTypeInstance}">
			<dialog:textArea object="${fieldTypeInstance}" propertyName="help" mode="edit" />
	        <dialog:textArea object="${fieldTypeInstance}" propertyName="alert" mode="edit" />	    	
		</dialog:tab>
		<dialog:tab name="List" object="${fieldTypeInstance}">
			<dialog:checkBox object="${fieldTypeInstance}" propertyName="runtimeEditableList" mode="edit" />
		<dialog:detailTable property="fieldType" object="${fieldTypeInstance}" domainClass="${org.workflow4people.FieldTypeItem}" />
			    	
		</dialog:tab>
		
		<dialog:tab name="Advanced" object="${fieldTypeInstance}">
			<dialog:checkBox object="${fieldTypeInstance}" propertyName="generateSchemaType" mode="edit" />
			<dialog:checkBox object="${fieldTypeInstance}" propertyName="restrictions" mode="edit" />
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="length" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="minLength" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="maxLength" mode="edit" />
			
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="pattern" mode="edit" />
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="minInclusive" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="maxInclusive" mode="edit" />
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="minExclusive" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="maxExclusive" mode="edit" />
			
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
