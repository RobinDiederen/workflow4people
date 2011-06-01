<w:form title="Edit field">
	<w:tabs names="Details,Advanced">		
		<w:tab name="Details">		                            
	                <w:textField object="${fieldInstance}" propertyName="id" mode="show" />                            
	                <w:textField object="${fieldInstance}" propertyName="fieldPosition" mode="show" />                            
	                <w:textField object="${fieldInstance}" propertyName="name" mode="edit" />                            
	                <w:domainObject object="${fieldInstance}" propertyName="fieldType" mode="edit" />
	                <w:domainObject object="${fieldInstance}" propertyName="fieldList" mode="edit" />                        
	            	<w:textArea object="${fieldInstance}" propertyName="description" mode="edit" />                        	
	                <w:textField object="${fieldInstance}" propertyName="defaultValue" mode="edit" />
	            	<w:textField object="${fieldInstance}" propertyName="label" mode="edit" />
	            	<w:textArea object="${fieldInstance}" propertyName="help" mode="edit" />
	                <w:textArea object="${fieldInstance}" propertyName="alert" mode="edit" />
	            	<w:textArea object="${fieldInstance}" propertyName="contentText" mode="edit" />		
		</w:tab>
		<w:tab name="Advanced">
					<w:textField object="${fieldInstance}" propertyName="minOccurs" mode="edit" />                            
					<w:textField object="${fieldInstance}" propertyName="maxOccurs" mode="edit" />
                    <w:checkBox object="${fieldInstance}" propertyName="nillable" mode="edit" />                                                					
					<w:domainObject object="${fieldInstance}" propertyName="dependsOn" from="${fieldsInSameTree}" mode="edit" />										
					<w:select object="${fieldInstance}" propertyName="dependencyType" mode="edit" />
					<w:textField object="${fieldInstance}" propertyName="dependencyParameter" mode="edit" />
					<w:checkBox object="${fieldInstance}" propertyName="readonly" mode="edit" />
                    <w:textField object="${fieldInstance}" propertyName="fieldLength" mode="edit" />
                    <w:textField object="${fieldInstance}" propertyName="xpath" mode="show" />
                    <w:domainObject object="${fieldInstance}" propertyName="parent" mode="show" />
		</w:tab>
	</w:tabs>
</w:form>