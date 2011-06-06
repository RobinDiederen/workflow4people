<wf:form title="Document">
	<wf:tabs names="Details,XML" object="${documentInstance}">		
		<wf:tab name="Details" object="${documentInstance}">		     
			<wf:textField object="${documentInstance}" propertyName="id" mode="show" />                            
	        <wf:domainObject object="${documentInstance}" propertyName="documentType" mode="edit" />
			<wf:domainObject object="${documentInstance}" propertyName="documentStatus" mode="show" />
			<wf:textField object="${documentInstance}" propertyName="documentKey" mode="show" />
			
			<wf:textField object="${documentInstance}" propertyName="documentDescription" mode="show" class="extrawide"/>
			
			<wf:date object="${documentInstance}" propertyName="dateCreated" mode="show" />
			<wf:date object="${documentInstance}" propertyName="lastUpdated" mode="show" />
			<wf:date object="${documentInstance}" propertyName="completionDate" mode="show" />
			
			<wf:textField object="${documentInstance}" propertyName="processingDays" mode="edit" />
			
			
	        <wf:textField object="${documentInstance}" propertyName="user" mode="edit" />
			<wf:textField object="${documentInstance}" propertyName="groupId" mode="edit" />
			
			<wf:textField object="${documentInstance}" propertyName="cmisFolderObjectId" mode="edit" class="extrawide"/>
			<wf:textField object="${documentInstance}" propertyName="cmisFolderUrl" mode="edit" class="extrawide"/>
	           		
		</wf:tab>
		<wf:tab name="XML" object="${documentInstance}">
			<wf:textArea object="${documentInstance}" propertyName="xmlDocument" mode="show" />	        
		</wf:tab>
	</wf:tabs>
</wf:form>