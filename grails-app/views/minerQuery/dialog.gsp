<wf:form title="Data miner query" object="${minerQueryInstance}">
	<wf:tabs names="Details,Queries" object="${minerQueryInstance}">		
		<wf:tab name="Details" object="${minerQueryInstance}">		                            
	        <wf:textField object="${minerQueryInstance}" propertyName="id" mode="show" />                                                        
	        <wf:textField object="${minerQueryInstance}" propertyName="name" mode="edit" />                            
	        <wf:textField object="${minerQueryInstance}" propertyName="title" class="wide" mode="edit" />
	        <wf:textArea object="${minerQueryInstance}" propertyName="description" mode="edit" />
	        <wf:textArea object="${minerQueryInstance}" propertyName="explanationMessage" mode="edit" />	           		
		</wf:tab>
		<wf:tab name="Queries" object="${minerQueryInstance}">
			<wf:textArea object="${minerQueryInstance}" propertyName="query" mode="edit" />
	        <wf:textArea object="${minerQueryInstance}" propertyName="drilldownQuery" mode="edit" />
	    	<wf:textArea object="${minerQueryInstance}" propertyName="drilldownCountQuery" mode="edit" />
	    	<wf:checkBox object="${minerQueryInstance}" propertyName="calculateTotals" mode="edit" />
		</wf:tab>
	</wf:tabs>
</wf:form>
