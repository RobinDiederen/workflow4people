<dialog:form title="Field List" width="635px" object="${fieldListInstance}">
	<dialog:table>		                            
		<dialog:textField object="${fieldListInstance}" propertyName="id" mode="show" />
		
		<dialog:domainObject object="${fieldListInstance}" propertyName="parent" mode="edit" />                        
		<dialog:textField object="${fieldListInstance}" propertyName="name" mode="edit" />
		<dialog:domainObject object="${fieldListInstance}" propertyName="namespace" mode="edit" sort="prefix"/>
		
        <dialog:domainObject object="${fieldListInstance}" propertyName="baseType" mode="edit" />
        
        <dialog:textField object="${fieldListInstance}" propertyName="label" mode="edit" class="wide"/>
        <dialog:textArea object="${fieldListInstance}" propertyName="description" mode="edit" class="wide"/>
                                		        	    	
	</dialog:table>		
</dialog:form>
