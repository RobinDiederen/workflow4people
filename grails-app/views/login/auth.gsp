<html>
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<meta name='layout' content='main' />
		<title>Login</title>
<style type='text/css' media='screen'>

#login {
	display: block; z-index: 1001; outline: 0px none; position: absolute; height: auto; width: 300px; top: 100px; left: 679px;
}

#login  input[type='text'|type='password']{ 
	width: 120px;	
}

#login .login_message {color:red;}
#login .text_ {width:120px;}
#login .chk {height:12px;}
.layout-table {border:none;}
</style>


<script type='text/javascript'>
/*
(function(){
	document.loginform.username.focus();
})();
*/
</script>

        <jq:jquery>
        $( "#login" ).show( "slide", function() {
        $("#username").focus();
        }
        );
                
        </jq:jquery>


	</head>
	<body onload="document.loginform.username.focus();">
	
		<div id='login' class="ui-dialog ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >

			<g:if test='${flash.message}'>
				<div class='login_message'>${flash.message}</div>
			</g:if>
			<div class='faheader ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix'>
			<span id="ui-dialog-title-dialog" class="ui-dialog-title" >Please login:</span></div>
			<form action='${request.contextPath}/j_spring_security_check' method='POST' id='loginForm' class='cssform'>
			<table class="layout-table">
				<tr>
					<td>Username</td>
					<td><input type='text' class='text_' name='j_username' id='j_username'  /></td>
					
				</tr>
				<tr>
					<td>Password</td>
					<td><input type='password' class='text_' name='j_password' id='j_password' /></td>
					
				</tr>
				
				<tr>
					<td>Remember me</td>
					<td><input type='checkbox' class='chk' id='remember_me' name='_spring_security_remember_me'/></td>
					
				</tr>
				
				
				<tr><td>
					<input class='button submit' type='submit' value='Login &raquo;' />					
					</td>
				</tr>
				</table>
			</form>
	
		</div>

	</body>
</html>
