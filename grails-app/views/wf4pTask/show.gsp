<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="task.show" default="Show Task &quot;${task.id}&quot;" /></title>
    </head>
    <body>        
        <div class="body">            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>            
            
          	<div class="nav">          	          	                      
   	              <span class="menuButton"><a class="process" href="${createLink(controller:'wf4pProcessInstance',action:'show',params:[processInstanceId:processInstance.id])}">&laquo; Process instance ${processInstance.id}</a></span>
	        </div>
            
           <g:form method="post">
                <g:hiddenField name="taskId" value="${task?.id}" />                                
                <div class="dialog">
                    <table>
                        <tbody>                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.id" default="Task id" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: task, field: "id")}</td>                                
                            </tr>                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.name" default="Task name" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: task, field: "name")}</td>                                
                            </tr>
                            <%-- TODO put this back when jBPM starts to support persistance of this field                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.description" default="Description" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: task, field: "description")}</td>                                
                            </tr>            
                            --%>                
                        </tbody>
                    </table>
                   
                    
                </div>
                 <div class="buttons">
                	<g:each in="${taskService.getOutcomes(task.id)}" var="outcome" >
                	<span class="button"><g:actionSubmit class="edit" action="complete" value="${outcome}" /></span>
                    </g:each>                    
                </div>
                    
                <h1>Variables</h1>
                <div class="list" >
				    <table>
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
				          <td><g:link class="awesome small blue button" controller="wf4pVariable" action="edit" params="${['processInstanceId':processInstance.id,'variableName':variableName]}">edit&nbsp;&raquo;</</g:link></td>			          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>
                
                
            </g:form>
        </div>
    </body>
</html>
