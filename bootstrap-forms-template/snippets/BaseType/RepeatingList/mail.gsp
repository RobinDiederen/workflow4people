<table>
	<tr><g:each in="${fields}" var="theField">
			<th>${theField.label}</th>
		</g:each>
	</tr>

<f:each in="*{document.${listGpath}}" var="${name}Instance" status="${name}Index">
	<tr>
		<g:each in="${fields}" var="theField">
		<td>
			<w:snippet var="${theField}" name="mail" />
		</td>
		</g:each>
		
	</tr>
</f:each>

</table>
