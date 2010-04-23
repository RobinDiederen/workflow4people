<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Personal task list for user ${params.userId}</title>
</head>
<body>
<div class="body">
  
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
   
  
    <div class="nav">     
    <span class="menuButton">
    Select user: <g:select name="userId" optionKey="${{it.getId()}}" optionValue="${{it.familyName+', '+it.givenName}}" from="${userList}" onChange="location.href='?userId='+this.value" value="${params.userId}"/>
    </span>      
  	</div>  
                                
                
                <div class="list" >

				    <table>
				      <thead>
				        <tr>
				          <th>Task</th>
				          <th>Name</th>
				          <th>Execution</th>
				          <%-- TODO bring this back when descriptions are supported 
				          <th>Description</th>
				          --%>
				          
				          <th>Priority</th>
				          <th>Assignee</th>
				          <th>Create&nbsp;time</th>
				          <th>Due&nbsp;date</th>
				          <th>Details</th>
				        </tr>
				      </thead>
				      <tbody>
				        
				        <g:each status="i" in="${personalTaskList}" var="taskInstance">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				        <td>${taskInstance.id}</td>
				          
			             <td>${taskInstance.name}</td>
			             <td>${taskInstance.executionId}</td>
			             <%-- TODO bring this back when descriptions are supported 
				          <td>${taskInstance.description}</td>
				          --%>
				          <td>${taskInstance.priority}</td>
				          <td>${taskInstance.assignee}</td>
				          <td>${taskInstance.createTime}</td> 
				          <td>${taskInstance.duedate}</td>
				          <td><g:link controller="wf4pTask" action="show" params="[taskId:taskInstance.id]">Details&nbsp;&gt;&gt;&gt;</g:link></td>				          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>

               <div class="paginateButtons">
                	<g:paginate total="${taskTotal}" />
            	</div>

				
  </div>
</body>
</html>
