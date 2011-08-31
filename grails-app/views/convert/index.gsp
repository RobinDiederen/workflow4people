<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Convert data model</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            
            <g:form>                
                <div class="dialog">
                <h3>Convert data model</h3>
          		<p>This action will convert the data model for wfp 0.7</p>
          		<br />
          		<p><g:link class="button" action="convert">Convert!</g:link></p>
          		<br />
          		<br />          		          			
                </div>
                
            </g:form>
        </div>
    </body>
</html>
