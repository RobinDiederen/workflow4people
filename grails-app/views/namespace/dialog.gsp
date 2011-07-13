<wf:form title="Namespace" width="800px">
	<wf:table>		                            
		<wf:textField object="${namespaceInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${namespaceInstance}" propertyName="prefix" mode="edit" class="wide"/>
		<wf:textField object="${namespaceInstance}" propertyName="uri" mode="edit" class="extrawide"/>
		<wf:textField object="${namespaceInstance}" propertyName="filename" mode="edit" />
		<wf:checkBox object="${namespaceInstance}" propertyName="generateXSDFile" mode="edit" />
		<wf:textField object="${namespaceInstance}" propertyName="includeSchema" mode="edit" />
		<wf:select multiple="true" class="multiselect" optionKey="id" object="${namespaceInstance}" from="${org.workflow4people.Namespace.list(sort:'prefix')}" propertyName="importSchema" mode="edit" vertical="true" style="width:710px; height:200px;" />		               		        	    		
	</wf:table>		
</wf:form>
