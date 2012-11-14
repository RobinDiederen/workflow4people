<tr class="${formItem.field.dependencySource ? 'dependency-source ' : ''}${formItem.field.dependsOn ? 'dependency-target ' : ''}" 

	depends-on="update-document.${formItem.field.dependsOn?.gpath}" 	
			dependency-type="${formItem.field.dependencyType}"
			dependency-parameter="${formItem.field.dependencyParameter}">


	<td>${formItem.field.binding.label}</td>
	<td>
    <g:if test="${mail == true}">
		  <w:snippet var="${formItem.field}" name="mail" />
		</g:if>
    <g:elseif test="${formItem.readonly}">
		  <w:snippet var="${formItem.field}" name="readonlyForm" />
    </g:elseif>
		<g:else>
			<w:snippet var="${formItem.field}" name="form" />
		</g:else>
	</td>
</tr>
