<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Task Session List</title>
  <jq:jquery>
        
    //Create Id for the table
    var tableId="taskSessionTable";

		dataTableHashList[tableId]=$("#"+tableId).dataTable( {
			"bProcessing": true,
			"bServerSide": false,
			"bFilter": false,
			"bJQueryUI": true,
			"aLengthMenu": [[1000], [1000]],
		 	"iDisplayLength": 1000,
		  "iDisplayStart": 0,
			"aoColumnDefs": [ 
				{ "bSortable": false, "aTargets": [ 0 ] },
				{ "bSortable": false, "aTargets": [ 1 ] },
				{ "bSortable": false, "aTargets": [ 2 ] },
				{ "bSortable": false, "aTargets": [ 2 ] },
				{ "bSortable": false, "aTargets": [ 3 ] },
				{ "bSortable": false, "aTargets": [ 4 ] },
				{ "bSortable": false, "aTargets": [ 5 ] },
				{ "bSortable": false, "aTargets": [ 6 ] }
			]
		} );
  </jq:jquery> 
</head>
<body>
<div class="body">
    	<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr table-title" >
    	
    		<h1>Task Session List</h1>
   		</div>
      <div class="datatable">
      
   <table cellpadding="0" cellspacing="0" border="0" class="display" id="taskSessionTable">
	<thead>

		<tr>
      <th>Task</th>
      <th>Username</th>
      <th>Real name</th>
      <th>Session id</th>
      <th>IP address</th>
      <th>User agent</th>
      <th>Last updated</th>
      <th width="50px">Actions</th>
		</tr>
	</thead>
	<tbody>
				        
    <g:each status="i" in="${taskSessionList}" var="taskSessionInstance">
    <tr>
      <td>${taskSessionInstance.taskId}</td>
      <td>${taskSessionInstance.userName}</td>
      <td>${taskSessionInstance.userRealName}</td>			          
      <td>${taskSessionInstance.sessionId}</td>
      <td>${taskSessionInstance.userIpAddress}</td>
      <td>${taskSessionInstance.userAgent}</td>
      <td>${taskSessionInstance.lastUpdated}</td>
      <td>
          <g:link class="awesome small blue button" controller="taskSession" action="remove" id="${taskSessionInstance.taskId}">remove&nbsp;&raquo;</g:link>
      </td>
    </tr>
    </g:each>
	</tbody>
	<tfoot>

		<tr>
      <th>Task</th>
      <th>Username</th>
      <th>Real name</th>
      <th>Session id</th>
      <th>IP address</th>
      <th>User agent</th>
      <th>Last updated</th>
      <th width="50px">Actions</th>
		</tr>
	</tfoot>
</table>
</div>
</body>
</html>
