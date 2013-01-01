<!-- Default formitem Name: formItem ${formItem} - Name ${name} -->
<g:if test="${mail == true}">
	<w:snippet var="${formItem.field}" name="mail" />
</g:if>
<g:elseif test="${readonly || formItem.readonly}">
	<w:snippet var="${formItem.field}" name="readonlyLabel" />
</g:elseif>
<g:else>
	<w:snippet var="${formItem.field}" name="label" />
</g:else>