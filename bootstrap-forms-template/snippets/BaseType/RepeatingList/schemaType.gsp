<complexType name="${name}" >
	<sequence>
		<g:each in="${field?.children}" var="theField">
			${theField.schemaElementSnippet}
		</g:each>
	</sequence>
</complexType>