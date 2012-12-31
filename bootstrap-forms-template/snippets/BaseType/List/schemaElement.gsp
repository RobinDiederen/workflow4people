<!-- List schemaElement -->
<g:if test="${field.hasChildren}" >

	<element name="${name}" ${occurrence}>
	<complexType>
	<sequence>
	<g:each in="${field?.children}" var="theField">
		<w:snippet var="${theField}" name="schemaElement" />
	</g:each>
	</sequence>
	
	</complexType>
	</element>
</g:if>
<g:else>
	<element name="${name}" type="${field?.fieldType?.namespace?.prefix}:${field?.fieldType?.name}" ${occurrence} />
</g:else>
