<dialog:form title="Edit field" object="${fieldInstance}">
	<dialog:tabs names="Details,Text,Advanced" object="${fieldInstance}">		
		<dialog:tab name="Details" object="${fieldInstance}">		                            
	        <dialog:textField object="${fieldInstance}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${fieldInstance}" propertyName="fieldPosition" mode="show" />                            
	        <dialog:textField object="${fieldInstance}" propertyName="name" mode="edit" />                            
	        <dialog:domainObject object="${fieldInstance}" propertyName="fieldType" mode="edit" />                        
	    	<dialog:textArea object="${fieldInstance}" propertyName="description" mode="edit" />                        	
	        <dialog:textField object="${fieldInstance}" propertyName="defaultValue" mode="edit" />
	    	<dialog:textField object="${fieldInstance}" propertyName="label" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Text" object="${fieldInstance}">
			<dialog:textArea object="${fieldInstance}" propertyName="help" mode="edit" />
	        <dialog:textArea object="${fieldInstance}" propertyName="alert" mode="edit" />
	    	<dialog:textArea object="${fieldInstance}" propertyName="contentText" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Advanced" object="${fieldInstance}">
			<dialog:textField object="${fieldInstance}" propertyName="minOccurs" mode="edit" />                            
			<dialog:textField object="${fieldInstance}" propertyName="maxOccurs" mode="edit" />
			<dialog:checkBox object="${fieldInstance}" propertyName="nillable" mode="edit" />                                                					
			<dialog:domainObject object="${fieldInstance}" propertyName="dependsOn" from="${fieldsInSameTree}" mode="edit" />										
			<dialog:select object="${fieldInstance}" propertyName="dependencyType" mode="edit" />
			<dialog:textField object="${fieldInstance}" propertyName="dependencyParameter" mode="edit" />
			<dialog:checkBox object="${fieldInstance}" propertyName="readonly" mode="edit" />
			<dialog:textField object="${fieldInstance}" propertyName="fieldLength" mode="edit" />
			<dialog:textField object="${fieldInstance}" propertyName="xpath" mode="show" />
			<dialog:domainObject object="${fieldInstance}" propertyName="parent" mode="show" />
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
