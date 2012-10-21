<dialog:form title="Namespace" width="835px" object="${namespaceInstance}">
	<dialog:table>		                            
		<dialog:textField object="${namespaceInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${namespaceInstance}" propertyName="prefix" mode="edit" class="wide"/>
		<dialog:textField object="${namespaceInstance}" propertyName="uri" mode="edit" class="extrawide"/>
		<dialog:textField object="${namespaceInstance}" propertyName="filename" mode="edit" />
		<dialog:checkBox object="${namespaceInstance}" propertyName="generateXSDFile" mode="edit" />
		<dialog:textField object="${namespaceInstance}" propertyName="includeSchema" mode="edit" />
		<dialog:select multiple="true" class="altselect" optionKey="id" object="${namespaceInstance}" from="${org.workflow4people.Namespace.list(sort:'prefix')}" propertyName="importSchema" mode="edit"/>			               		        	    		
	</dialog:table>		
</dialog:form>
