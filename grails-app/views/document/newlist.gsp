<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
		<jqui:resources theme="smoothness" />
        <title><g:message code="${title}.list.title" default="${title}.list.title" /></title>
        <jq:jquery>
    
		$('#datatable').dataTable( {
		//"sDom": '<"toolbar">frtip',
		"bProcessing": true,
		"bServerSide": true,		
		"sAjaxSource": "${resource(dir:propName,file:'jsonlist')}",
		"sPaginationType": "full_numbers",
		"bFilter": false,
		"bJQueryUI": true,
		"aoColumnDefs": [ 
			{ "bSortable": false, "aTargets": [ ${dc.listProperties.size()} ] }
		]
		
		
	} );
	////$("div.datatable div.fg-toolbar div.datatable_length").prepend('<div style="float:left;height:20px;">test</div>');
	$("div.datatable div.fg-toolbar div#datatable_length").prepend('<a href="${request.contextPath}/${propName}/create">[new]</a>&nbsp;');
        </jq:jquery>       
    </head>
    
    <body>
    <div class="body">
    	<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr table-title" >
    	
    		<h1><g:message code="${title}.list.title" default="${title}.list.title" /></h1>
   		</div>
      <div class="datatable">
      
   <table cellpadding="0" cellspacing="0" border="0" class="display" id="datatable">
	<thead>

		<tr>
		<g:each in="${dc.listProperties}" var="property">
	 	<th><g:message code="document.${property}.label" default="document.${property}.label" /></th>		
		</g:each>
		<th>Actions</th>

		</tr>
	</thead>
	<tbody>
		<tr>
			<td colspan="6" class="dataTables_empty">Loading data from server</td>
		</tr>
	</tbody>
	<tfoot>

		<tr>
			<g:each in="${dc.listProperties}" var="property">
	 	<th><g:message code="document.${property}.label" default="document.${property}.label" /></th>		
		</g:each>
		<th>Actions</th>

		</tr>
	</tfoot>
</table>
</div>   
    
    
    </div>
    
    
    </body>
</html>
