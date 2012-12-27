<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>New process definition</title>
</head>
<body>
 <div class="body">
  <div class="navbar">
			<div class="navbar-inner">			
				<ul class="nav">	        	
    <li><g:link class="awesome small blue button" action="list">List Processes</g:link></li>
    </ul>
  </div>
  </div>
 
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  
  <g:form method="post" action="install" enctype="multipart/form-data">
      <input type="file" name="processdefinition" class="btn"/>
      <p/><input class="save btn" type="submit" value="Install" />
  </g:form>
  </div>
</body>
</html>
