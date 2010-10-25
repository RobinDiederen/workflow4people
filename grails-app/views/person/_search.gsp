<span class="button" style="float: right; padding-right: 5px;">
	<g:form action="search" method="post">
		<g:textField id="q" name="q" value="${q}" size="20"/>
		<g:submitButton name="search" class="awesome small blue button" value="${message(code: 'person.search.label', default: 'Search user')}" />
	</g:form>
</span>
