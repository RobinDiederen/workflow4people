<!-- list -->
<g:each in="${fields}" var="theField">
	<tr>
		<td style="vertical-align:top;">${theField.binding.label}</td>
		<td><w:snippet var="${theField}" name="mail" />				
		</td>
	</tr>
</g:each>
