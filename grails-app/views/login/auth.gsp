<html>
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<meta name='layout' content='main' />
		<title>Login</title>
<style type='text/css' media='screen'>
#login {
	margin:15px 0px; padding:0px;
	text-align:center;
}
#login .inner {
	width:260px;
	margin:0px auto;
	text-align:left;
	padding:10px;
	border:1px solid #68A;
	background-color:#EEF;
}
#login .inner .fheader {
	padding:0px;margin:6px 0px 6px 0;color:#2e3741;font-size:14px;font-weight:bold;
}
#login .inner .cssform p{
	clear: left;
	margin: 0;
	padding: 0px 0 0px 0;
	padding-left: 105px;	
	margin-bottom: 10px;	
}
#login .inner .cssform input[type='text']{ 
	width: 120px;
}
#login .inner .cssform label{
	font-weight: bold;
	float: left;
	margin-left: -105px; 
	width: 100px;
}
#login .inner .login_message {color:red;}
#login .inner .text_ {width:120px;}
#login .inner .chk {height:12px;}

</style>
	</head>
	<body>
	<div class="body">
		<div id='login' class="dialog">
			<div class='inner'>
			<g:if test='${flash.message}'>
				<div class='login_message'>${flash.message}</div>
			</g:if>
			<div class='fheader'>Please Login:</div>
			<form action='${request.contextPath}/j_spring_security_check' method='POST' id='loginForm' class='cssform'>
				<p>
					<label for='j_username'>Login ID</label>
					<input type='text' class='text_' name='j_username' id='j_username'  />
				</p>
				<p>
					<label for='j_password'>Password</label>
					<input type='password' class='text_' name='j_password' id='j_password' />
				</p>
				<p>
					<label for='remember_me'>Remember me</label>
					<input type='checkbox' class='chk' id='remember_me' name='_spring_security_remember_me'/>
				</p>
				<p>
					<input class='awesome small blue button' type='submit' value='Login' />
				</p>
			</form>
			</div>
		</div>
<script type='text/javascript'>
<!--
(function(){
	document.forms['loginForm'].elements['j_username'].focus();
})();
// -->
</script>
</div>
	</body>
</html>
