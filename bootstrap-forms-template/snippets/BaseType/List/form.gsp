<!-- list -->
<g:each in="${fields}" var="theField">
	
	<tr class="${theField.dependencySource ? 'dependency-source ' : ''}${theField.dependsOn ? 'dependency-target ' : ''}" 
	
			depends-on="update-document.${theField.dependsOn?.gpath}"	
			dependency-type="${theField.dependencyType}"
			dependency-parameter="${theField.dependencyParameter}"
	>
	
		<td style="vertical-align:top;">${theField.binding.label}</td>
		<td><g:if test="${mail == true}">
                <w:snippet var="${theField}" name="mail" />
            </g:if>
			<g:elseif test="${theField.readonly}">
				<w:snippet var="${theField}" name="readonlyForm" />	
			</g:elseif>
			<g:else>
				<w:snippet var="${theField}" name="form" />
			</g:else>
		</td>
	</tr>
</g:each>
