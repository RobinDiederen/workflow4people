<g:if test="${mail == true}">
  <w:snippet var="${formItem.field}" name="mail" />
</g:if>
<g:elseif test="${formItem.readonly}">
  <w:snippet var="${formItem.field}" name="readonlyForm" />
</g:elseif>
<g:else>
	<w:snippet var="${formItem.field}" name="form" />
</g:else>