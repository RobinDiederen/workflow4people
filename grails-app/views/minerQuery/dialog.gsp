<wf:form title="Data miner query">
	<wf:tabs names="Details,Queries" object="${minerQueryInstance}">		
		<wf:tab name="Details" object="${minerQueryInstance}">		                            
	        <wf:textField object="${minerQueryInstance}" propertyName="id" mode="show" />                                                        
	        <wf:textField object="${minerQueryInstance}" propertyName="name" mode="edit" />                            
	        <wf:textField object="${minerQueryInstance}" propertyName="title" class="extrawide" mode="edit" />
	        <wf:textField object="${minerQueryInstance}" propertyName="description" class="extrawide" mode="edit" />
	        <wf:textField object="${minerQueryInstance}" propertyName="explanationMessage" class="extrawide" mode="edit" />	           		
		</wf:tab>
		<wf:tab name="Queries" object="${minerQueryInstance}">
			<wf:textArea object="${minerQueryInstance}" propertyName="query" mode="edit" />
	        <wf:textArea object="${minerQueryInstance}" propertyName="drilldownQuery" mode="edit" />
	    	<wf:textArea object="${minerQueryInstance}" propertyName="drilldownCountQuery" mode="edit" />
	    	<wf:checkBox object="${minerQueryInstance}" propertyName="calculateTotals" mode="edit" />
		</wf:tab>
	</wf:tabs>
</wf:form>
