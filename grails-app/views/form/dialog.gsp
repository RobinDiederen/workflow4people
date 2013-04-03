<dialog:form title="Form" object="${formInstance}" height="620px">
	<dialog:tabs names="Details,Messages,Pages" object="${formInstance}">		
		<dialog:tab name="Details" object="${formInstance}">		                            
	        <dialog:textField object="${formInstance}" propertyName="id" mode="show" />
			<dialog:domainObject object="${formInstance}" propertyName="workflow" mode="show" />
	        <dialog:textField object="${formInstance}" propertyName="name" mode="edit" />                            
	        <dialog:textField object="${formInstance}" propertyName="title" mode="edit" />
	        <dialog:textArea object="${formInstance}" propertyName="description" mode="edit" />
	        <dialog:textField object="${formInstance}" propertyName="outcomes" mode="edit" class="wide"/>
	        
	        <dialog:select object="${formInstance}" propertyName="template" mode="edit" from="${formTemplateNames}"/>	        
	        <dialog:domainObject object="${formInstance}" propertyName="formAction" mode="edit" />
	    		    		
		</dialog:tab>
		<dialog:tab name="Messages" object="${formInstance}">
			<dialog:textArea object="${formInstance}" propertyName="explanationMessage" mode="edit" />
			<dialog:textArea object="${formInstance}" propertyName="confirmationMessage" mode="edit" />			
		</dialog:tab>
		<dialog:tab name="Pages" object="${formInstance}">
			<dialog:detailTable property="form" object="${formInstance}" domainClass="${org.workflow4people.FormPage}" />
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
