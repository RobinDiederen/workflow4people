<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Manage document index</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            
            <g:form>                
                <div class="dialog">
                <h3>Lucene reindex only</h3>
          		<p>This action will reindex Lucene only. Database fields are re-evaluated but XML documents are not re-evaluated. <br />This is a quick operation.</p>
          		<br />
          		<p><g:link class="awesome small blue button" action="reindexLuceneOnly">Perform lucene reindex only</g:link></p>
          		<br />
          		<br />
          		<h3>Full reindex</h3>
          		<p>This action will reindex all database fields, read the XML documents, re-parse the associated XPath expressions for all document. <br />This is a slow operation.</p>
          		<br />
          		<p><g:link class="awesome small blue button" action="reindexComplete">Perform full reindex</g:link></p>
          		<br />
          		<br />
          		<h3>Reindex one document type</h3>
          		<p>This action will reindex all database fields, read the XML documents, re-parse the associated XPath expressions for one document type.<br />This is a slow operation.</p>
          		<br />
				<g:each in="${org.workflow4people.DocumentType.findAll([params:[sort:'name']])}" var="dt" >
					<g:link class="awesome small blue button" action="reindexOneType" params="${[documentTypeName:dt.name]}">Re-index all documents of type: &quot;${dt.name}&quot;</g:link><br /><br />
				</g:each>          		
          		
          		
          		
          		
          			
                </div>
                
            </g:form>
        </div>
    </body>
</html>
