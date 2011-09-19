<wf:form title="Edit field" object="${fieldInstance}">
	<wf:tabs names="Details,Text,Advanced" object="${fieldInstance}">		
		<wf:tab name="Details" object="${fieldInstance}">		                            
	        <wf:textField object="${fieldInstance}" propertyName="id" mode="show" />                            
	        <wf:textField object="${fieldInstance}" propertyName="fieldPosition" mode="show" />                            
	        <wf:textField object="${fieldInstance}" propertyName="name" mode="edit" />                            
	        <wf:domainObject object="${fieldInstance}" propertyName="fieldType" mode="edit" />                        
	    	<wf:textArea object="${fieldInstance}" propertyName="description" mode="edit" />                        	
	        <wf:textField object="${fieldInstance}" propertyName="defaultValue" mode="edit" />
	    	<wf:textField object="${fieldInstance}" propertyName="label" mode="edit" />
		</wf:tab>
		<wf:tab name="Text" object="${fieldInstance}">
			<wf:textArea object="${fieldInstance}" propertyName="help" mode="edit" />
	        <wf:textArea object="${fieldInstance}" propertyName="alert" mode="edit" />
	    	<wf:textArea object="${fieldInstance}" propertyName="contentText" mode="edit" />
		</wf:tab>
		<wf:tab name="Advanced" object="${fieldInstance}">
			<wf:textField object="${fieldInstance}" propertyName="minOccurs" mode="edit" />                            
			<wf:textField object="${fieldInstance}" propertyName="maxOccurs" mode="edit" />
			<wf:checkBox object="${fieldInstance}" propertyName="nillable" mode="edit" />                                                					
			<wf:domainObject object="${fieldInstance}" propertyName="dependsOn" from="${fieldsInSameTree}" mode="edit" />										
			<wf:select object="${fieldInstance}" propertyName="dependencyType" mode="edit" />
			<wf:textField object="${fieldInstance}" propertyName="dependencyParameter" mode="edit" />
			<wf:checkBox object="${fieldInstance}" propertyName="readonly" mode="edit" />
			<wf:textField object="${fieldInstance}" propertyName="fieldLength" mode="edit" />
			<wf:textField object="${fieldInstance}" propertyName="xpath" mode="show" />
			<wf:domainObject object="${fieldInstance}" propertyName="parent" mode="show" />
		</wf:tab>
	</wf:tabs>
</wf:form>
