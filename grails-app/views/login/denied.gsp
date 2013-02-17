<html>
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<meta name="layout" content="main" />
		<title>Login</title>
        <r:script>
          $(function() {
          	$('#login').modal('show');

          	$("#login").on('shown', function () {
  				$('input:text:visible:first', this).focus();	
			});
          	 
          });
      	</r:script>
	</head>
	<body>
		<form class="form-horizontal" action="${request.contextPath}/j_spring_security_check" method="POST" id="loginForm" >				
		</form>
	</body>
</html>
