<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Process instance history for process &quot;${processDefinition.id}&quot;</title>
    </head>
    <body>
		<div class="body">
	        <div class="nav">          
	       <span class="menuButton"><g:link controller="wf4pProcessDefinition" class="awesome small blue button" action="list">&laquo; Process definitions</g:link></span>  
	        </div>
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
            <div class="">
                <table class="table table-bordered table-striped">
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>                            
                            <td valign="top" class="value">${processDefinition?.id}</td>                            
                        </tr>                        
                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>                            
                            <td valign="top" class="value">${processDefinition.name}</td>
                        </tr>            
                          <%--  TODO put this back when jBPM starts to support persistance of this field            
                        <tr class="prop">
                            <td valign="top" class="name">Description:</td>                            
                            <td valign="top" class="value">${processDefinition.description}</td>
                        </tr>            
                        --%>        
                        <tr class="prop">
                            <td valign="top" class="name">Version:</td>                            
                            <td valign="top" class="value">${processDefinition.version}</td>
                        </tr>
					</tbody>
				</table>
        	</div>
        	<h1>History Process Instances</h1>
        	<div class="list">
			    <table class="table table-striped table-bordered">
			      <thead>
			        <tr>
			          <th>Process Instance Id</th>
			          <th>Start time</th>
			          <th>End time</th>
			          <th>State</th>
			          <th>End activity</th>
			          <th>Details</th>
			        </tr>
			      </thead>
			      <tbody>
			        <g:each in="${historyProcessInstanceList}" status="i" var="historyInstance">
			        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			          <td>${historyInstance.processInstanceId}</td>
			          <td>${historyInstance.startTime}</td>
			          <td>${historyInstance.endTime}</td>
			          <td>${historyInstance.state}</td>
			          <td>${historyInstance.endActivityName}</td>
			          <td><g:link class="awesome small blue button" action="show" id="${historyInstance.processInstanceId}">details&nbsp;&raquo;</g:link></td>
			        </tr>
			        </g:each>
			      </tbody>
			    </table>
			</div>
			<div class="paginateButtons">
            	<g:paginate total="${historyProcessInstanceTotal}" params="${params}"/>
    		</div>
	   	</div>
    </body>
</html>
