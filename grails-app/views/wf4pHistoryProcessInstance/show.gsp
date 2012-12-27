<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Task history for process instance &quot;${historyProcessInstance.processInstanceId}&quot;</title>
    </head>
    <body>
		<div class="body">
	        <div class="nav">          
	  		<span class="menuButton"><g:link class="awesome small blue button" action="list" id="${historyProcessInstance.processDefinitionId}" >&laquo; History of process definition ${historyProcessInstance.processDefinitionId}</g:link></span>  
	                    
	        </div>
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
           
                <div class="dialog">
                
                    <table >
                        <tbody>                      
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Process name:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${historyProcessInstance.getProcessDefinitionId()}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Process instance:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${historyProcessInstance.processInstanceId}
                                </td>
                            </tr>
                                                 
                        </tbody>
                    </table>
                </div>
                
        	<h1>Task history</h1>
        	<div>
			    <table class="table table-striped table-bordered">
			      <thead>
			        <tr>
			          <th>Task Id</th>
			          <th>Start time</th>
			          <th>End time</th>
			          <th>Assignee</th>
			          <th>Outcome</th>
			          <th>State</th>
			        </tr>
			      </thead>
			      <tbody>
			        <g:each in="${historyTaskList}" status="i" var="historyTask">
			        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			          <td>${historyTask.id}</td>
			          <td>${historyTask.createTime}</td>
			          <td>${historyTask.endTime}</td>
			          <td>${historyTask.assignee}</td>
			          <td>${historyTask.outcome}</td>
			          <td>${historyTask.state}</td>			          			          
			        </tr>
			        </g:each>
			      </tbody>
			    </table>
			</div>
			<div class="paginateButtons">
            	<g:paginate total="${historyTaskTotal}" params="${params}"/>
    		</div>
	   	</div>
    </body>
</html>
