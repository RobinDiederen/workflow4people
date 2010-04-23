<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Process Definition details for process &quot;${processDefinition.id}&quot;</title>
    </head>
    <body>
		<div class="body">
	        <div class="nav">          
	          <span class="menuButton"><a class="awesome small blue button" href="${createLink(action:'newinstance',params:[processName:processDefinition.name,processDefinitionId:processDefinition.id])}">New process instance</a></span>            
	        </div>
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
            <div class="dialog">
                <table>
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
        	<h1>Process Instances</h1>
        	<div class="list">
			    <table>
			      <thead>
			        <tr>
			          <th>Id</th>
			          <th>State</th>
			          <th>Ended</th>
			          <th>Executions</th>
			          <th>Active activities</th>
			          <th>Executions</th>
			          <th>Details</th>
			        </tr>
			      </thead>
			      <tbody>
			        <g:each in="${processInstanceList}" status="i" var="instance">
			        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			          <td>${instance.getId()}</td>
			          <td>${instance.state}</td>
			          <td>${instance.isEnded()}</td>
			
			          <td>${instance.executionsMap}</td>          
			          <td>${instance.findActiveActivityNames()}</td>
			          <td></td>
			
			 		  <td><g:link class="awesome small blue button" action="show" controller="wf4pProcessInstance" params="[processInstanceId:instance.id]">details&nbsp;&raquo;</g:link></td>
			        </tr>
			        </g:each>
			      </tbody>
			    </table>
			</div>
			<div class="paginateButtons">
            	<g:paginate total="${processInstanceTotal}" params="${params}"/>
    		</div>
	   	</div>
    </body>
</html>
