<wf:form title="Field List" >
	<wf:table>		                            
		<wf:textField object="${fieldListInstance}" propertyName="id" mode="show" />
		
		<wf:domainObject object="${fieldListInstance}" propertyName="parent" mode="edit" />                        
		<wf:textField object="${fieldListInstance}" propertyName="name" mode="edit" />
		<wf:domainObject object="${fieldListInstance}" propertyName="namespace" mode="edit" sort="prefix"/>
		
        <wf:domainObject object="${fieldListInstance}" propertyName="baseType" mode="edit" />
        
        <wf:textField object="${fieldListInstance}" propertyName="label" mode="edit" class="wide"/>
        <wf:textArea object="${fieldListInstance}" propertyName="description" mode="edit" class="wide"/>
                                		        	    	
	</wf:table>		
</wf:form>
