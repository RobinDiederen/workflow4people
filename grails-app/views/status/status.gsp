
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title>
			<g:message code="status.title" default="Workflow4people status page" />
		</title>
	</head>
	<body>
		<div class="body">

			<div class="nav">
				<span class="menuButton">
					<b>Workflow4people status page</b>
				</span>
				</div>



				<div id="main">

					<div id="body" >

						<div class="list statuslist">
							<table>
								<thead>
								
									<tr>

										<th>
											Item
										</th>
										<th>
											Value
										</th>

									</tr>
								</thead>
								<tbody>

									
										<tr class="even">
											<td>Webapp location</td>
											<td>${webAppLocation}</td>											
										</tr>
										
										<tr class="even">
											<td>Total Memory</td>
											<td>${totalMemory}</td>											
										</tr>
										<tr class="odd">
											<td>Free Memory</td>
											<td>${freeMemory}</td>											
										</tr>
										<tr class="even">
											<td>Max Memory</td>
											<td>${maxMemory}</td>											
										</tr>

										

								</tbody>
							</table>
						</div>
						<div class="list statuslist">
							<table>
								<thead>
								<tr><th>Grails application config</th></tr>
							    
								</thead>
								<tbody>								
								<g:each var="value" in="${grailsApplicationConfig}" status="i">								
										<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
											<td>${value}</td>								 										
										</tr>
									
								</g:each>										
								</tbody>
							</table>
						</div>
						
						<div class="list statuslist">
							<table>
								<thead>
								<tr><th>Environment</th></tr>
							    
								</thead>
								<tbody>								
								<g:each var="value" in="${env}" status="i">								
										<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
											<td>${value}</td>								 										
										</tr>
									
								</g:each>										
								</tbody>
							</table>
						</div>
						
												
							<div class="list statuslist">
							<table>
								<thead>
								<tr><th>Properties</th></tr>
							    
								</thead>
								<tbody>								
								<g:each var="value" in="${theProperties}" status="i">								
										<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
											<td>${value}</td>								 										
										</tr>
									
								</g:each>										
								</tbody>
							</table>
						</div>
						
						<div class="list statuslist">
							<table>
								<thead>
								<tr><th colspan="2">Memory statistics</th></tr>
							    <tr><th>Name</th><th>Type</th><th>Usage</th><th>Peak</th><th>Collections</th></tr>
								</thead>
								<tbody>								
								<g:each var="memItem" in="${memItems}" status="i">								
										<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
											<td>${memItem.name}</td>
											<td>${memItem.type}</td>
				 							<td>${memItem.usage}</td>
				 							<td>${memItem.peak}</td>
				 							<td>${memItem.collections}</td>			
										</tr>									
								</g:each>										
								</tbody>
							</table>
						</div>
						
						
						
					</div>

				</div>
			</div>


	</body>
</html>
