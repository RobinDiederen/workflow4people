<simpleType name="${fieldType.name}" >
	<g:if test="${parameters.minLength!=null || parameters.maxLength!=null || parameters.minInclusive || parameters.maxInclusive!=null  || parameters.minExclusive!=null || parameters.maxInclusive!=null || parameters.pattern!=null}" >
		<restriction base="${fieldType.baseSchemaType}" >		
			<g:if test="${parameters.minLength}"><minLength value="${parameters.minLength}" /></g:if>	
			<g:if test="${parameters.maxLength}"><maxLength value="${parameters.maxLength}" /></g:if>
				
			<g:if test="${parameters.minInclusive}"><minInclusive value="${parameters.minInclusive}" /></g:if>
			<g:if test="${parameters.maxInclusive}"><maxInclusive value="${parameters.maxInclusive}" /></g:if>
		
			<g:if test="${parameters.minExclusive}"><minExclusive value="${parameters.minExclusive}" /></g:if>
			<g:if test="${parameters.maxInclusive}"><maxInclusive value="${parameters.maxInclusive}" /></g:if>
			
			<g:if test="${parameters.pattern}"><pattern value="${parameters.pattern}" /></g:if>
		</restriction>	
	</g:if>
</simpleType>