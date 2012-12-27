<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title>
			<g:message code="status.title" default="Workflow4people status page" />
		</title>
	</head>
	<body>
		<h4><g:message code="status.title" default="Workflow4people status page" /></h4>
		<table class="table table-bordered table-striped">
			<thead>					
				<tr><th>Item</th><th>Value</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>Webapp location</td>
					<td>${webAppLocation}</td>											
				</tr>							
				<tr>
					<td>Total Memory</td>
					<td>${totalMemory}</td>											
				</tr>
				<tr>
					<td>Free Memory</td>
					<td>${freeMemory}</td>											
				</tr>
				<tr>
					<td>Max Memory</td>
					<td>${maxMemory}</td>											
				</tr>
			</tbody>
		</table>


		
		<table class="table table-bordered table-striped">
			<thead>
				<tr><th colspan="2">Grails application config</th></tr>
				<tr><th>Name</th><th>Value</th></tr>		    
			</thead>
			<tbody>								
				<g:each var="property" in="${grailsApplicationConfig}" status="i">								
					<tr><td>${property.key}</td><td>${property.value}</td></tr>									
				</g:each>										
			</tbody>
		</table>

					
		
		
		<table class="table table-bordered table-striped">
			<thead>
				<tr><th colspan="2">Environment</th></tr>
			<tr><th>Name</th><th>Value</th></tr>
		    
			</thead>
			<tbody>								
			<g:each var="property" in="${env}" status="i">								
					<tr>
						<td>${property.key}</td><td>${property.value}</td>								 										
					</tr>
				
			</g:each>										
			</tbody>
		</table>

						
												
		
		<table class="table table-bordered table-striped">
			<thead>
			<tr><th colspan="2">System properties</th></tr>
			<tr><th>Name</th><th>Value</th></tr>
		    
			</thead>
			<tbody>								
			<g:each var="property" in="${theProperties}" status="i">								
					<tr>
						<td>${property.key}</td><td>${property.value}</td>								 										
					</tr>
				
			</g:each>										
			</tbody>
		</table>
	
		<table class="table table-bordered table-striped">
			<thead>
			<tr><th colspan="2">Memory statistics</th></tr>
		    <tr><th>Name</th><th>Type</th><th>Usage</th><th>Peak</th><th>Collections</th></tr>
			</thead>
			<tbody>								
			<g:each var="memItem" in="${memItems}" status="i">								
					<tr>
						<td>${memItem.name}</td>
						<td>${memItem.type}</td>
							<td>${memItem.usage}</td>
							<td>${memItem.peak}</td>
							<td>${memItem.collections}</td>			
					</tr>									
			</g:each>										
			</tbody>
		</table>
						
						
						




	</body>
</html>
