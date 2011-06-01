<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
		<jqui:resources theme="smoothness" />
        <title><g:message code="${controllerName}.list.title" default="${controllerName}.list.title" /></title>
        <jq:jquery>

		$('#datatable').dataTable( {
		//"sDom": '<"toolbar">frtip',
		"bProcessing": true,
		"bServerSide": true,		
		"sAjaxSource": "${resource(dir:controllerName,file:'jsonlist')}",
		"sPaginationType": "full_numbers",
		"bFilter": ${bFilter ? true : false},
		"bJQueryUI": true,
		"aoColumnDefs": [ 
			{ "bSortable": false, "aTargets": [ ${dc.listProperties.size()} ] }
		]
		
		} );
	
	
	
	////$("div.datatable div.fg-toolbar div.datatable_length").prepend('<div style="float:left;height:20px;">test</div>');
	$("div.datatable div.fg-toolbar div#datatable_length").prepend('<span class="list-toolbar-button ui-widget-content ui-state-default"><a href="${request.contextPath}/${controllerName}/create">New</a></span>&nbsp;');
        </jq:jquery>       
    </head>
    
    <body>
    <div class="body">
    	<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr table-title" >
    	
    		<h1><g:message code="${controllerName}.list.title" default="${controllerName}.list.title" /></h1>
   		</div>
      <div class="datatable">
      
   <table cellpadding="0" cellspacing="0" border="0" class="display" id="datatable">
	<thead>

		<tr>
		<g:each in="${dc.listProperties}" var="property">
	 	<th><g:message code="${controllerName}.${property}.label" default="${controllerName}.${property}.label" /></th>		
		</g:each>
		<th width="50px">Actions</th>

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
    
    
    </div>
    
    
    </body>
</html>
