<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
		<jqui:resources theme="smoothness" />
        <title>Dank u wel!</title>       
    </head>
    
    <body>
    <form:form action="submit" title="*{g.message(code: 'thankyou')}" explanation="${formInstance.confirmationMessage}" name="request-thankyou" process="${formInstance.workflow.name}" type="show" />
    </body>
</html>
