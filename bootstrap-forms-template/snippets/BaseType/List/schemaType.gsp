<!-- List schemaType -->
<complexType name="${name}" >
	<sequence>
		<g:each in="${fieldType.listParent.children}" var="theField">
			${theField.schemaElementSnippet}			
		</g:each>
	</sequence>
</complexType>