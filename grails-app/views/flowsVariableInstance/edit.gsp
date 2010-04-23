<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta name="layout" content="main" />
		<title>Edit Variable</title>
	</head>
	<body>
		<div class="nav">
			<span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
			<span class="menuButton"><a class="back" href="${createLink(controller:'fprocess',action:'instanceDetails',params:[processInstanceId:params.processInstanceId])}">Process details</a></span>
		</div>
		<div class="body">
			
			<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
			</g:if>
			
			<g:form method="post" action="update">
				<input type="hidden" name="processInstanceId" value="${params?.processInstanceId}" />
				<div class="dialog">
					<table>
					<tbody>
 						<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="variableName">Variable name:</label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" id="variableName" name="variableName" value="${params.variableName}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="variableValue">Variable value:</label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" id="variableValue" name="variableValue" value="${params.variableValue}"/>
                                </td>
                            </tr> 
                        
					</tbody>
					</table>
				</div>

				<div class="buttons">
					<span class="button"><g:actionSubmit class="update" value="Update" /></span>
					<span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
				</div>

			</g:form>

		</div>
	</body>
</html>

