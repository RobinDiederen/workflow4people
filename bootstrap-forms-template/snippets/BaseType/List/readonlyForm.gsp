<!-- list -->
<g:each in="${field?.children}" var="theField">
	<tr>
		<td style="vertical-align:top;">${theField.binding.label}</td>
		<td><w:snippet var="${theField}" name="readonlyForm" />				
		</td>
	</tr>
</g:each>
