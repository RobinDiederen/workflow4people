<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Process instances for process &quot;${processDefinition.id}&quot;</title>
    </head>
    <body>
		<div class="body">
		<div class="navbar">
			<div class="navbar-inner">			
				<ul class="nav">	        	
	          		<li><g:link class="awesome small blue button" action="list">&laquo; Process definitions</g:link></li>
	          		<li><a class="awesome small blue button" href="${createLink(action:'newinstance',params:[processName:processDefinition.name,processDefinitionId:processDefinition.id])}">New process instance</a></li>            
	        	</ul>
	        </div>
        </div>
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
            <div class="dialog">
                <table class="table table-bordered">
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>                            
                            <td valign="top" class="value">${processDefinition?.id}</td>                            
                        </tr>                        
                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>                            
                            <td valign="top" class="value">${processDefinition.name}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Description:</td>                            
                            <td valign="top" class="value">${processDefinition.description}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Version:</td>                            
                            <td valign="top" class="value">${processDefinition.version}</td>
                        </tr>
					</tbody>
				</table>
        	</div>
        	<h4>Process Instances</h4>
        	<div class="list">
			    <table class="table table-striped table-bordered">
			      <thead>
			        <tr>
			          <th>Id</th>
			          <th>State</th>
			          <th>Ended</th>
			          <th>Executions</th>
			          <th>Active activities</th>
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
			          
			
			 		  <td><div class="btn-group">
			 		  		<g:link class="btn btn-small" action="show" controller="wf4pProcessInstance" params="[processInstanceId:instance.id]">details&nbsp;&raquo;</g:link>
			 		  	  <g:link class="btn btn-small" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" controller="wf4pProcessInstance" action="delete" id="${instance.id}">&times;</g:link>
			 		  	  </div>			 		  
			 		  </td>
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
