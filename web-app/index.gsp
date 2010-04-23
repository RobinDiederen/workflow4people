<html>
    <head>
        <title>workflow4people</title>
		<meta name="layout" content="homepage" />
    </head>
    <body>
    
        <div class="main-menu">
        
         <div class="tasks" onclick="location.href='${createLink(controller:'wf4pTask',action:'userlist')}'">User Tasks</div>
         <div class="tasks" onclick="location.href='${createLink(controller:'wf4pTask',action:'list')}'">All Tasks</div>
          
         <div class="flows" onclick="location.href='${createLink(controller:'wf4pProcessDefinition',action:'list')}'">Administration</div>
        
        </div>
  	
    </body>
</html>