<dialog:form title="Edit field" object="${fieldInstance}" height="635px">
	<dialog:tabs names="Details,Text,Advanced,Snippet" object="${fieldInstance}">		
		<dialog:tab name="Details" object="${fieldInstance}">		                            
	        <dialog:textField object="${fieldInstance}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${fieldInstance}" propertyName="position" mode="show" />                            
	        <dialog:textField object="${fieldInstance}" propertyName="name" mode="edit" />                            
	        <dialog:domainObject object="${fieldInstance}" propertyName="fieldType" mode="edit" />                        
	    	<dialog:textArea object="${fieldInstance}" propertyName="description" mode="edit" />                        	
	        <dialog:textField object="${fieldInstance}" propertyName="defaultValue" mode="edit" placeholder="${fieldInstance.fieldType?.defaultValue?:''}"/>
	    	<dialog:textField object="${fieldInstance}" propertyName="label" mode="edit" placeholder="${fieldInstance.fieldType?.label?:''}" />
		</dialog:tab>
		<dialog:tab name="Text" object="${fieldInstance}">
			<dialog:textArea object="${fieldInstance}" propertyName="help" mode="edit" placeholder="${fieldInstance.fieldType?.help?:''}"/>
	        <dialog:textArea object="${fieldInstance}" propertyName="alert" mode="edit" placeholder="${fieldInstance.fieldType?.alert?:''}"/>
	    	<dialog:textArea object="${fieldInstance}" propertyName="contentText" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Advanced" object="${fieldInstance}">
			<dialog:textField object="${fieldInstance}" propertyName="minOccurs" mode="edit" />                            
			<dialog:textField object="${fieldInstance}" propertyName="maxOccurs" mode="edit" />
			<dialog:checkBox object="${fieldInstance}" propertyName="nillable" mode="edit" />                                                					
			<%--<dialog:domainObject object="${fieldInstance}" propertyName="dependsOn" from="${fieldsInSameTree}" mode="edit" />--%>
			<dialog:treeselect   object="${fieldInstance}" propertyName="dependsOn" root="fieldtype_${treeParent?.fieldType?.id}" /> 	    
													
			<dialog:select object="${fieldInstance}" propertyName="dependencyType" mode="edit" />
			<dialog:textField object="${fieldInstance}" propertyName="dependencyParameter" mode="edit" />
			<dialog:checkBox object="${fieldInstance}" propertyName="readonly" mode="edit" />
			
			<dialog:textField object="${fieldInstance}" propertyName="xpath" mode="show" />
			<dialog:domainObject object="${fieldInstance}" propertyName="parent" mode="show" />
		</dialog:tab>
		
		<dialog:tab name="Snippet" object="${fieldInstance}">
			<g:if test="${templateSnippetConfig}">
				<dialog:simplerow label="${message(code:'field.snippetConfig.description')}" >${templateSnippetConfig.description}</dialog:simplerow>
				<g:each in="${templateSnippetConfig.parameters}" var="parameter">
					<dialog:simplerow label="${parameter.value.label}" help="${parameter.value.help}">
					<g:textField name="snippetParameters.${parameter.key}" value="${fieldInstance.snippetParameters[parameter.key]}" placeholder="${fieldInstance.fieldType.snippetParameters[parameter.key]?:parameter.value.defaultValue}" />
					</dialog:simplerow>
				</g:each>
			</g:if>
			<g:else>
				<p>Snippet config is missing!</p>
			</g:else>		
		</dialog:tab>
		
	</dialog:tabs>
</dialog:form>
