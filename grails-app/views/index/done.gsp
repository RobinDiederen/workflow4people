<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Re-indexed</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            
            <g:form>                
                <div class="dialog">
          ${count} documents have been re-indexed.
                </div>
                
            </g:form>
        </div>
    </body>
</html>
