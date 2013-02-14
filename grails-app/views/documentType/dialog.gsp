<dialog:form title="Document type" width="1050px" height="800px" object="${documentTypeInstance}">
	<dialog:tabs names="Details,Index,Location,CMIS" object="${documentTypeInstance}">		
		<dialog:tab name="Details" object="${documentTypeInstance}">		     
			<dialog:textField object="${documentTypeInstance}" propertyName="id" mode="show" />                                                        
			<dialog:textField object="${documentTypeInstance}" propertyName="name" mode="edit" />
			<dialog:textArea object="${documentTypeInstance}" propertyName="description" mode="edit" />
			<dialog:textField object="${documentTypeInstance}" propertyName="nameTemplate" mode="edit" class="wide" />
			<dialog:textField object="${documentTypeInstance}" propertyName="descriptionTemplate" mode="edit" class="wide" />
			<dialog:domainObject object="${documentTypeInstance}" propertyName="fieldType" mode="edit" />			
			<dialog:date object="${documentTypeInstance}" propertyName="dateCreated" mode="show" />
			<dialog:date object="${documentTypeInstance}" propertyName="lastUpdated" mode="show" />		
		</dialog:tab>
		<dialog:tab name="Index" object="${documentTypeInstance}">
			<dialog:select multiple="true" class="altselect" optionKey="id" object="${documentTypeInstance}" from="${org.workflow4people.DocumentIndexField.list(sort:'name')}" propertyName="documentIndexField" mode="edit"/>
		</dialog:tab>		
		<dialog:tab name="Location" object="${documentTypeInstance}">
			<dialog:checkBox object="${documentTypeInstance}" propertyName="folder" mode="edit" />		
			<dialog:textField object="${documentTypeInstance}" propertyName="pathTemplate" mode="edit" class="extrawide" />
			<dialog:domainObject object="${documentTypeInstance}" propertyName="defaultChildDocumentType" mode="edit" />
			<dialog:domainObject object="${documentTypeInstance}" propertyName="documentCategory" mode="edit" />
		</dialog:tab>		
		<dialog:tab name="CMIS" object="${documentTypeInstance}">
			<dialog:checkBox object="${documentTypeInstance}" propertyName="useCmis" mode="edit" />
			<dialog:textField object="${documentTypeInstance}" propertyName="cmisPathTemplate" mode="edit" class="extrawide" />
			<dialog:textField object="${documentTypeInstance}" propertyName="cmisDocumentNameTemplate" mode="edit" class="extrawide"/>
			<dialog:textField object="${documentTypeInstance}" propertyName="cmisDocumentTemplatePath" mode="edit" class="extrawide"/>
			<dialog:textArea object="${documentTypeInstance}" propertyName="cmisDocumentScript" mode="edit" class="codemirror wide" codeMirrorMode="text/x-groovy" />
		</dialog:tab>		
	</dialog:tabs>		
</dialog:form>
