<table class="table table-bordered table-striped">
	<tr><g:each in="${field?.children}" var="theField">
			<th align="left">${theField.label}</th>
		</g:each>
	</tr>

<f:each in="*{document.${listGpath}}" var="${name}Instance" status="${name}Index">
	<tr>
		<g:each in="${field?.children}" var="theField">
		<td>
			<w:snippet var="${theField}" name="readonlyForm" />
		</td>
		</g:each>
		
	</tr>
</f:each>

</table>