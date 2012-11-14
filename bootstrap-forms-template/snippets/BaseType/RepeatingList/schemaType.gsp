<complexType name="${name}" >
	<sequence>
		<g:each in="${fields}" var="theField">
			${theField.schemaElementSnippet}
		</g:each>
	</sequence>
</complexType>