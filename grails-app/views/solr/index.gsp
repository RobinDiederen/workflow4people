<%@page import="org.workflow4people.Document"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Manage Solr Index</title>
    </head>
	<body>
		<div class="body">
			<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr table-title">
				<h1>Manage Solr Index</h1>
			</div>
	
			<g:if test="${flash.message}">
	    	<div class="message">${flash.message}</div>
			</g:if>
	
			<g:form>
			    <br />
          		<br />
				<p><g:link class="ui-button ui-widget" action="reindexBooks">Re-index all documents (current numer of documents : ${Document.count()})</g:link></p>
				
			</g:form>
		</div>
	</body>
</html>
