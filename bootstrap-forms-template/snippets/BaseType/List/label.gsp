<!-- label for list ${field.name} -->
<g:each in="${field.children}" var="theField">	
	<w:snippet var="${theField}" name="label" />			
</g:each>