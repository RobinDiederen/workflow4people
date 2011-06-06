<wf:form title="Form">
	<wf:tabs names="Details,Messages,FormItems" object="${formInstance}">		
		<wf:tab name="Details" object="${formInstance}">		                            
	        <wf:textField object="${formInstance}" propertyName="id" mode="show" />
			<wf:domainObject object="${formInstance}" propertyName="workflow" mode="edit" />
	        <wf:textField object="${formInstance}" propertyName="name" mode="edit" />                            
	        <wf:textField object="${formInstance}" propertyName="title" mode="edit" />
	        <wf:textArea object="${formInstance}" propertyName="description" mode="edit" />
	        
	        <wf:select object="${formInstance}" propertyName="template" mode="edit" from="${formTemplateNames}"/>	        
	        <wf:domainObject object="${formInstance}" propertyName="formAction" mode="edit" />
	    		    		
		</wf:tab>
		<wf:tab name="Messages" object="${formInstance}">
			<wf:textArea object="${formInstance}" propertyName="explanationMessage" mode="edit" />
			<wf:textArea object="${formInstance}" propertyName="confirmationMessage" mode="edit" />			
		</wf:tab>
		<wf:tab name="FormItems" object="${formInstance}">
			<wf:detailTable property="form" object="${formInstance}" domainClass="${org.workflow4people.FormItem}" />
		</wf:tab>
	</wf:tabs>
</wf:form>
