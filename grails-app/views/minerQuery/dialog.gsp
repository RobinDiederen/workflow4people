<dialog:form title="Data miner query" object="${minerQueryInstance}">
	<dialog:tabs names="Details,Queries" object="${minerQueryInstance}">		
		<dialog:tab name="Details" object="${minerQueryInstance}">		                            
	        <dialog:textField object="${minerQueryInstance}" propertyName="id" mode="show" />                                                        
	        <dialog:textField object="${minerQueryInstance}" propertyName="name" mode="edit" />                            
	        <dialog:textField object="${minerQueryInstance}" propertyName="title" class="wide" mode="edit" />
	        <dialog:textArea object="${minerQueryInstance}" propertyName="description" mode="edit" />
	        <dialog:textArea object="${minerQueryInstance}" propertyName="explanationMessage" mode="edit" />	           		
		</dialog:tab>
		<dialog:tab name="Queries" object="${minerQueryInstance}">
			<dialog:textArea object="${minerQueryInstance}" propertyName="query" mode="edit" />
	        <dialog:textArea object="${minerQueryInstance}" propertyName="drilldownQuery" mode="edit" />
	    	<dialog:textArea object="${minerQueryInstance}" propertyName="drilldownCountQuery" mode="edit" />
	    	<dialog:checkBox object="${minerQueryInstance}" propertyName="calculateTotals" mode="edit" />
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
