<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="task.show" default="Show Task &quot;${task.id}&quot;" /></title>
    </head>
    <body>        
        <div class="body">            
            
          	<div class="navbar">
			<div class="navbar-inner">			
				<ul class="nav">	        	          	          	                      
   	              <li><a class="process" href="${createLink(controller:'wf4pProcessInstance',action:'show',params:[processInstanceId:processInstance.id])}">&laquo; Process instance ${processInstance.id}</a></li>
   	              </ul>
   	              </div>
	        </div>
            
           <g:form method="post">
                <g:hiddenField name="taskId" value="${task?.id}" />                                
                <div class="dialog">
                    <table class="table table-bordered">
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.id" default="Task id" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: task, field: "id")}</td>                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.name" default="Task name" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: task, field: "name")}</td>                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.description" default="Description" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: task, field: "description")}</td>                                
                            </tr>
                        </tbody>
                    </table>
                   
                    
                </div>
                 <div class="buttons">
                    <g:if test="${task.assignee}">
                	<span class="button"><g:actionSubmit class="btn edit" action="reassign" params="[taskId: task.id, previousAction: 'show']" value="Reassign&nbsp;&raquo;" /></span>
                	</g:if>
                </div>
                
                
                <h4>Available process actions</h4>
                 <div class="buttons">
                	<g:each in="${taskService.getOutcomes(task.id)}" var="outcome" >
                	<span class="button"><g:actionSubmit class="btn edit" action="complete" value="${outcome}" /></span>
                    </g:each>
                </div>
                
                <h4>Variables</h4>
                <div class="list" >
				    <table class="table table-bordered table-striped">
				      <thead>
				        <tr>
				          <th>Name</th>
				          <th>Value</th>
				          <th>Edit</th>				          
				        </tr>
				      </thead>
				      <tbody>				        
				        <g:each status="i" in="${taskService.getVariableNames(task.id)}" var="variableName">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				          <td>${variableName}</td>
				          <td>${taskService.getVariable(task.id,variableName)}</td>
				          <td><g:link class="btn btn-small" controller="wf4pVariable" action="edit" params="${['processInstanceId':processInstance.id,'variableName':variableName]}">edit&nbsp;&raquo;</</g:link></td>			          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>
                
                
            </g:form>
        </div>
    </body>
</html>
