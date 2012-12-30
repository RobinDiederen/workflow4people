<!-- SimpleType formitem -->

<label class="control-label ${formItem.field.dependencySource ? 'dependency-source ' : ''}${formItem.field.dependsOn ? 'dependency-target ' : ''}" for="${formItem.field.name}">${formItem.field.binding.label}</label>
<div class="controls ${formItem.field.dependencySource ? 'dependency-source ' : ''}${formItem.field.dependsOn ? 'dependency-target ' : ''}">
   	<g:if test="${mail == true}">
		<w:snippet var="${formItem.field}" name="mail" />
	</g:if>
	<g:elseif test="${formItem.readonly}">
		<w:snippet var="${formItem.field}" name="readonlyForm" />
	</g:elseif>
	<g:else>
		<w:snippet var="${formItem.field}" name="form" />
	</g:else>		
</div>
	