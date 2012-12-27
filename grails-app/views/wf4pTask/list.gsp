<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Task list</title>
</head>
<body>
<div class="body">
  
  <g:if test="${flash.message}">
    <div class="message">
    <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
  </g:if>
   
  
  <div class="nav">&nbsp; </div>  
                                

                <div class="list" >

				    <table class="table table-striped table-bordered">
				      <thead>
				        <tr>
				          <th>Task</th>
				          <th>Name</th>
				          <th>Execution</th>
				          <th>Description</th>
				          <th>Priority</th>
				          <th>Assignee</th>
				          <th>Create&nbsp;time</th>
				          <th>Due&nbsp;date</th>
				          <th>Action</th>
				        </tr>
				      </thead>
				      <tbody>
				        
				        <g:each status="i" in="${taskList}" var="taskInstance">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				          <td>${taskInstance.id}</td>
				          <td>${taskInstance.name}</td>
				          <td>${taskInstance.executionId}</td>			          
				          <td>${taskInstance.description}</td>
				          <td>${taskInstance.priority}</td>
				          <td>${taskInstance.assignee}</td>
				          <td>${taskInstance.createTime}</td> 
				          <td>${taskInstance.duedate}</td>
				          <td><div class="btn-group">
			                <g:link class="btn btn-small" controller="wf4pTask" action="show" params="[taskId: taskInstance.id, previousAction: 'list']">show&nbsp;&raquo;</g:link>
			                <g:if test="${taskInstance.assignee}">
			                    <g:link class="btn btn-small" controller="wf4pTask" action="reassign" params="[taskId: taskInstance.id, previousAction: 'list']">reassign&nbsp;&raquo;</g:link>
			                </g:if>
			                </div>
				          </td>
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>
				
				<div class="paginateButtons">
                	<g:paginate action="list" total="${taskTotal}" params="${params}" />
            	</div>
				
  </div>
</body>
</html>
