<html>
	<head>
		<meta name="layout" content="main" />
		<meta name="tabname" content="process" />
		<title>Workflow Wizard</title>
	</head>
	<body>
		<div class="body">
			<div class="nav">
				<span class="menuButton">
					<b>2. Process analysis</b>
				</span>
			</div>

			<g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
			</g:if>
			<div class="explanation">
				<div class="inner-explanation">
					The analysis of the process shows the information below.
					<br />
					If this is not what you expected, you can exit the wizard and correct the process definition file.
				</div>
			</div>
			<g:form method="post" action="install" enctype="multipart/form-data">

				<div class="new-dialog">
					<div class="inner-new-dialog">

						<table class="dialog-table">
							<tbody>
								<tr><th colspan="2">Workflow definition</th></tr>
								<tr class="prop">
									<td valign="top" class="name">Workflow definition &quot;${processName}&quot; :</td>
									<td valign="top" class="value">
										<g:if test="${workflowDefiniton}" >found</g:if>
										<g:else>not found</g:else>
									</td>									
								</tr>
								<tr class="prop">
									<td valign="top" class="name">Field list :</td>
									<td valign="top" class="value">${workflowDefinition?.fieldList}										
									</td>									
								</tr>
								
							</tbody>
						</table>
						
						<table class="dialog-table">
							<tbody>
								<tr><th colspan="2">Task forms</th></tr>
								<g:each in="${tasks}" var="task">
								<tr class="prop">
									<td valign="top" class="name">${task.name}</td>
									<td valign="top" class="value">
										<g:if test="${task.formFound}" >found</g:if>
										<g:else>not found</g:else>
									</td>									
								</tr>
								</g:each>
								
								
							</tbody>
						</table>
						
						
						
					</div>
				</div>

				<div class="dialog-buttons">
					<div class="inner-dialog-buttons">
						<g:actionSubmit class="awesome small blue button"
							action="next" value="Next &raquo;" />
					</div>
				</div>
			</g:form>
		</div>
	</body>
</html>
