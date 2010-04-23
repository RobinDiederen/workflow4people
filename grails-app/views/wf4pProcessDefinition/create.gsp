<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>New process definition</title>
</head>
<body>
 <div class="body">
  <div class="nav">
    <span class="menuButton"><g:link class="awesome small blue button" action="list">List Processes</g:link></span>
  </div>
 
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  
  <g:form method="post" action="install" enctype="multipart/form-data">
      <input type="file" name="processdefinition"/>
      <p/><input class="save" type="submit" value="Install" />
  </g:form>
  </div>
</body>
</html>
