<%-- TODO need to do a nicer one that will show the label instead of the key --%>
<span class="uneditable-input">	
	<form:output type="text" class="fieldtype-${fieldTypeName} field-${name}" gpath="document.${gpathExpr}"  value="*{document.${gpath}}"/>
</span>