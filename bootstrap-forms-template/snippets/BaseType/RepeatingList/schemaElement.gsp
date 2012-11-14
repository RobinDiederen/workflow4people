<g:if test="${field.fieldList}">
<element name="${name}" type="${field?.fieldList?.namespace?.prefix}:${field?.fieldList?.name}" ${occurrence} />
</g:if>
<g:else>
	<g:if test="${hasChildren}" >
	
		<element name="${name}" ${occurrence}>
		<complexType>
		<sequence>
		<g:each in="${children}" var="${field}">
			<w:snippet var="${field}" name="schemaElement" />
		</g:each>
		</sequence>
		
		</complexType>
		</element>
	</g:if>	
	<g:else>
		<element name="${name}" type="${field?.fieldType?.namespace?.prefix}:${field?.fieldType?.name}" ${occurrence} />
	</g:else>
</g:else>