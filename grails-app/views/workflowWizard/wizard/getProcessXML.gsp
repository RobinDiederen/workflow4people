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
					<b>1. Process definition</b>
				</span>
			</div>

			<g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
			</g:if>
			<div class="explanation">
				<div class="inner-explanation">
					Welcome to the Workflow Wizard!
					<br />
					This wizard will guide you through the process of defining a
					workflow in workflow4people.
				</div>
			</div>
			<g:form method="post" action="wizard" enctype="multipart/form-data">

				<div class="new-dialog">
					<div class="inner-new-dialog">

						<table class="dialog-table">
							<tbody>
								<tr class="prop">
									<td valign="top" class="name">Process definition file</td>
									<td valign="top" class="value">
										<input type="file" name="processdefinition" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="dialog-buttons">
					<div class="inner-dialog-buttons">
						
						<button class="awesome small blue button" name="_eventId_next" type="submit" value="next">Next &raquo;</button>
					</div>
				</div>
			</g:form>
		</div>
	</body>
</html>
