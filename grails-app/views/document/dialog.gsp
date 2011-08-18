<wf:form title="Document" width="850px" object="${documentInstance}">
	<wf:tabs names="Details,XML,Index" object="${documentInstance}">		
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
	        <wf:textField object="${documentInstance}" propertyName="cmisPath" mode="edit" class="extrawide"/>
	        
		</wf:tab>
		<wf:tab name="XML" object="${documentInstance}">
			<wf:xml object="${documentInstance}" propertyName="xmlDocument" mode="show" class="xmldoc"/>	        
		</wf:tab>
		<wf:tab name="Index" object="${documentInstance}">
			<wf:detailTable property="document" object="${documentInstance}" domainClass="${org.workflow4people.DocumentIndex}" />	    		
		</wf:tab>
		
	</wf:tabs>
</wf:form>
