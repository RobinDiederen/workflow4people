<dialog:form title="Field type" object="${fieldTypeInstance}" height="520px">
	<dialog:tabs names="Details,Description,Text,${(templateSnippetConfig && templateSnippetConfig.useList)?'List,':''}Advanced,Snippet" object="${fieldTypeInstance}">				
		<dialog:tab name="Details" object="${fieldTypeInstance}">		                            
	        <dialog:textField object="${fieldTypeInstance}" propertyName="id" mode="show" />                                                      
	        <dialog:textField object="${fieldTypeInstance}" propertyName="name" mode="edit" />
	        
	        <dialog:domainObject object="${fieldTypeInstance}" propertyName="namespace" mode="edit" sort="prefix"/>
	        <dialog:domainObject object="${fieldTypeInstance}" propertyName="baseType" mode="edit" />
	        <dialog:textField object="${fieldTypeInstance}" propertyName="baseSchemaType" mode="edit" />
	        
	        
	        
	        <dialog:textField object="${fieldTypeInstance}" propertyName="defaultValue" mode="edit" />
	        <dialog:textField object="${fieldTypeInstance}" propertyName="label" mode="edit" />
	    		    		
		</dialog:tab>
		<dialog:tab name="Description" object="${fieldTypeInstance}">
			<dialog:textArea noHelp="true" noLabel="true" style="width:500px;height:270px;" object="${fieldTypeInstance}" propertyName="description" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Text" object="${fieldTypeInstance}">
			<dialog:textArea style="width:400px;" object="${fieldTypeInstance}" propertyName="help" mode="edit" />
	        <dialog:textArea style="width:400px;" object="${fieldTypeInstance}" propertyName="alert" mode="edit" />	    	
		</dialog:tab>
		<g:if test="${templateSnippetConfig && templateSnippetConfig.useList}">
			<dialog:tab name="List" object="${fieldTypeInstance}">
				<dialog:checkBox object="${fieldTypeInstance}" propertyName="runtimeEditableList" mode="edit" />
			<dialog:detailTable property="fieldType" object="${fieldTypeInstance}" domainClass="${org.workflow4people.FieldTypeItem}" rowreordering="true"/>			    	
		</dialog:tab>
		</g:if>
		<dialog:tab name="Advanced" object="${fieldTypeInstance}">
			<dialog:checkBox object="${fieldTypeInstance}" propertyName="generateSchemaType" mode="edit" />
			<dialog:checkBox object="${fieldTypeInstance}" propertyName="restrictions" mode="edit" />
			
			<%-- <dialog:textField object="${fieldTypeInstance}" propertyName="length" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="minLength" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="maxLength" mode="edit" />
			
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="pattern" mode="edit" />
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="minInclusive" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="maxInclusive" mode="edit" />
			
			<dialog:textField object="${fieldTypeInstance}" propertyName="minExclusive" mode="edit" />
			<dialog:textField object="${fieldTypeInstance}" propertyName="maxExclusive" mode="edit" />
			--%>
		</dialog:tab>
		
		<dialog:tab name="Snippet" object="${fieldTypeInstance}">
			<g:if test="${templateSnippetConfig}">
				<dialog:simplerow label="${message(code:'fieldType.snippetConfig.description')}" >${templateSnippetConfig.description}</dialog:simplerow>
				<g:each in="${templateSnippetConfig.parameters}" var="parameter">
				<dialog:simplerow label="${parameter.value.label}" help="${parameter.value.help}">
					<g:textField name="snippetConfig.${parameter.key}" value="${fieldTypeInstance.snippetConfig[parameter.key]?:parameter.value.defaultValue}" />
					</dialog:simplerow>
				</g:each>
			</g:if>
			<g:else>
				<p>Snippet config is missing!</p>
			</g:else>		
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
