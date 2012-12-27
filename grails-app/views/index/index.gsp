<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Manage document index</title>
    </head>
    <body>
        <div class="body">
            <g:form>                
                <div class="dialog">
          		<h3>Full reindex</h3>
          		<p>This action will read the XML documents, re-parse the associated XPath expressions for all document. <br />This is a slow operation.</p>
          		<br />
          		<p><g:link class="btn" action="reindexComplete">Perform full reindex</g:link></p>
          		<br />
          		<br />
          		<h3>Reindex one document type</h3>
          		<p>This action will read the XML documents, re-parse the associated XPath expressions for one document type.<br />This is a slow operation.</p>
          		<br />
				<g:each in="${org.workflow4people.DocumentType.findAll([params:[sort:'name']])}" var="dt" >
					<g:link class="btn" action="reindexOneType" params="${[documentTypeName:dt.name]}">Re-index all documents of type: &quot;${dt.name}&quot;</g:link><br /><br />
				</g:each>          		          			
                </div>                
            </g:form>
        </div>
    </body>
</html>
