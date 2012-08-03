<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title><g:message code="document.search" default="Lucene document search" /></title>
		<jq:jquery>
			var searchTable = $("#list").dataTable( {
				"bProcessing": true,
				"bServerSide": true,		
				"sAjaxSource": "${resource(dir:controllerName,contextPath:'',file: 'jsonlist')}",
				"sPaginationType": "full_numbers",
				"bFilter": false,
				"bJQueryUI": true,
				"aoColumnDefs": [ 
					{ "bSortable": false, "aTargets": [ 0 ] },
					{ "bSortable": false, "aTargets": [ 1 ] },
					{ "bSortable": false, "aTargets": [ ${dc.listProperties.size()} ] }
				],
				"fnServerData": function ( sSource, aoData, fnCallback ) {
					
					aoData.push( { "name": "q", "value": $("#q").val() } );
					
					$.ajax({
						"dataType": "json", 
						"type": "POST", 
						"url": sSource, 
						"data": aoData, 
						"success": fnCallback
					});
				}
			});
			
			$("#search").click( function() {
				searchTable.fnDraw();
				return false;
			});
		</jq:jquery>       
	</head>
	<body>
		<div class="body">
			<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr table-title" >
					<h1><g:message code="document.search" default="Lucene document search" /></h1>
					<div>
						<g:textField id="q" name="q" value="${params.q}" size="50"/> <input id="search" name="search" class="awesome small blue button" type="submit" value="Search!" />
					</div>
			</div>
			<div class="datatable">
				<table cellpadding="0" cellspacing="0" border="0" class="display" id="list">
					<thead>
						<tr>
							<g:each in="${dc.listProperties}" var="property">
							<th><g:message code="${controllerName}.${property}.label" default="${controllerName}.${property}.label" /></th>		
							</g:each>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="${dc.listProperties.size()}" class="dataTables_empty">Loading data from server</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<g:each in="${dc.listProperties}" var="property">
							<th><g:message code="${controllerName}.${property}.label" default="${controllerName}.${property}.label" /></th>		
							</g:each>
							<th>Actions</th>
						</tr>
					</tfoot>
				</table>
			</div>
			<div id="statusmessage" style="margin:auto;text-align:center;">...</div>

		</div>
	</body>
</html>
