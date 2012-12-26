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
		<div id="login" class="modal hide fade" >			
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h3><g:message code="login.title" />:</h3>
			</div>
			
				<div class="modal-body">									
					<div class="control-group">
						<label class="control-label" for="j_username"><g:message code="login.username.label" /></label>
						<div class="controls"><g:textField name="j_username" /></div>
					</div>
					<div class="control-group">
						<label class="control-label" for="j_password"><g:message code="login.password.label" /></label>
					  	<div class="controls">
					  		<g:passwordField name="j_password" />
					  	</div>
					</div>						
				</div>
				<div class="modal-footer">
					<input class="btn btn-primary" type="submit" value="${message(code:'login')} &raquo;" />
				</div>
			
		</div>
		</form>
	</body>
</html>
