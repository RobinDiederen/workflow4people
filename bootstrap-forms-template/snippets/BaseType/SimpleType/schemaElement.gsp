<g:if test="${field.snippetParameters.minLength!=null || field.snippetParameters.maxLength!=null || field.snippetParameters.minInclusive || field.snippetParameters.maxInclusive!=null  || field.snippetParameters.minExclusive!=null || field.snippetParameters.maxInclusive!=null || field.snippetParameters.pattern!=null}" >
	<element name="${name}" ${occurrence} >	
		<simpleType>		
			<restriction base="${field.fieldType.schemaType}" >		
				<g:if test="${field.snippetParameters.minLength}"><minLength value="${field.snippetParameters.minLength}" /></g:if>	
				<g:if test="${field.snippetParameters.maxLength}"><maxLength value="${field.snippetParameters.maxLength}" /></g:if>
					
				<g:if test="${field.snippetParameters.minInclusive}"><minInclusive value="${field.snippetParameters.minInclusive}" /></g:if>
				<g:if test="${field.snippetParameters.maxInclusive}"><maxInclusive value="${field.snippetParameters.maxInclusive}" /></g:if>
			
				<g:if test="${field.snippetParameters.minExclusive}"><minExclusive value="${field.snippetParameters.minExclusive}" /></g:if>
				<g:if test="${field.snippetParameters.maxInclusive}"><maxInclusive value="${field.snippetParameters.maxInclusive}" /></g:if>
				
				<g:if test="${field.snippetParameters.pattern}"><pattern value="${field.snippetParameters.pattern}" /></g:if>
			</restriction>
		</simpleType>	
	</element>
</g:if>
<g:else>
	<element name="${name}" type="${field.fieldType.schemaType}" ${occurrence} />
</g:else>