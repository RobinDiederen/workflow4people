<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Process instance details for instance &quot;${processInstance?.getId()}&quot;</title>
</head>
<body>
<div class="body">
  
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
   
  
  <div class="nav">
    
    <span class="menuButton"><a class="process" href="${createLink(controller:'wf4pProcessDefinition',action:'show',params:[processDefinitionId:processInstance.getProcessDefinitionId()])}">Process Definition</a></span>
    <span class="menuButton"><a class="create" href="${createLink(controller:'wf4pVariable',action:'create',params:[processInstanceId:processInstance.id])}">New variable</a></span>
   
  </div>  
                <div class="dialog">
                
                    <table>
                        <tbody>                      
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Process name:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${processInstance.getProcessDefinitionId()}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Process instance:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${processInstance.id}
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Version:</label>
                                </td>
                                <td valign="top" class="value">
                                   <%-- ${processInstance.version} --%>
                                </td>
                            </tr>                            
                        </tbody>
                    </table>
                </div>
                
                <h1>Tasks</h1>
                <div class="list" >

				    <table>
				      <thead>
				        <tr>
				          <th>Task</th>
				          <th>Description</th>
				          <th>Priority</th>
				          <th>Assignee</th>
				          <th>Create&nbsp;time</th>
				          <th>Due&nbsp;date</th>
				          <th>Outcomes</th>
				          <th>Details</th>
				        </tr>
				      </thead>
				      <tbody>
				        
				        <g:each status="i" in="${taskList}" var="taskInstance">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				          <td>${taskInstance.name}</td>
				          <td>${taskInstance.description}</td>
				          <td>${taskInstance.priority}</td>
				          <td>${taskInstance.assignee}</td>
				          <td>${taskInstance.createTime}</td> 
				          <td>${taskInstance.duedate}</td>
				          <td>${taskService.getOutcomes(taskInstance.id)}</td>
				          <td><g:link class="awesome small blue button" controller="wf4pTask" action="show" params="[taskId:taskInstance.id]">Details&nbsp;&raquo;</g:link></td>
				          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>
				
				<h1>Variables</h1>
                <div class="list" >
				    <table>
				      <thead>
				        <tr>
				          <th>Name</th>
				          <th>Class</th>
				          <th>Value</th>
				          <th>Edit</th>				          
				        </tr>
				      </thead>
				      <tbody>				        
				        <g:each status="i" in="${executionService.getVariableNames(processInstance.id)}" var="variableName">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				          <td>${variableName}</td>
				          <td>${executionService.getVariable(processInstance.id,variableName)?.class?.name}</td>
				          <td>${executionService.getVariable(processInstance.id,variableName)}</td>
				          <td><g:link class="awesome small blue button" controller="wf4pVariable" action="edit" params="${['processInstanceId':processInstance.id,'variableName':variableName]}">edit&nbsp;&raquo;</</g:link></td>				          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>              
  </div>
</body>
</html>
