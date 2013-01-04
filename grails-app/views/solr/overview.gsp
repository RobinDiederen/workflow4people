<g:applyLayout name="main">	
	<dialog:pageform name="solr.overview" class="span12">	
		<table class="table table-bordered">
			<thead>
				<tr><th>Domain</th><th>In database</th><th>In Solr</th></tr>
			</thead>
			<tbody>
				<tr><td>Task</td><td>${taskStats.numDocsInDb}</td><td>${taskStats.numDocsInSolr}</td></tr>
				<tr><td>Document</td><td>${documentStats.numDocsInDb}</td><td>${documentStats.numDocsInSolr}</td></tr>
			</tbody>
		</table>		
	</dialog:pageform>	
</g:applyLayout>
