<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="task.reassign" default="Reassign Task &quot;${taskInstance.id}&quot;" /></title>
    </head>
    <body>
        <div class="body">            
            <g:if test="${flash.message}">
            <div class="errors"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>   
            
          	<div class="nav">
          	    <g:if test="${params.previousAction == 'list'}">
   	              <span class="menuButton"><a class="process" href="${createLink(controller:'wf4pTask',action:'list')}">&laquo; All tasks</a></span>
   	            </g:if>
          	    <g:elseif test="${params.previousAction == 'userlist'}">
   	              <span class="menuButton"><a class="process" href="${createLink(controller:'wf4pTask',action:'userlist',params:[userId:taskInstance.assignee])}">&laquo; Tasks by user ${taskInstance?.assignee}</a></span>
   	            </g:elseif>
       	        <span class="menuButton"><a class="process" href="${createLink(controller:'wf4pTask',action:'show',params:[taskId:taskInstance.id])}">&laquo; Show task</a></span>
	        </div>
            
           <g:form method="post">
                <g:hiddenField name="taskId" value="${taskInstance?.id}" />
                <g:hiddenField name="taskVersion" value="${taskInstance?.dbversion}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.id" default="Task id" /></td>                                
                                <td valign="top" class="value">${fieldValue(bean: taskInstance, field: "id")}</td>                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.name" default="Task name" /></td>                                
                                <td valign="top" class="value">${fieldValue(bean: taskInstance, field: "name")}</td>                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.description" default="Description" /></td>
                                <td valign="top" class="value">${fieldValue(bean: taskInstance, field: "description")}</td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="task.assignee" default="Current assignee" /></td>
                                <td valign="top" class="value">${fieldValue(bean: taskInstance, field: "assignee")} (${currentAssignee?.familyName}, ${currentAssignee?.givenName})</td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reassignTo"><g:message code="field.newAssignee.label" default="Reassign to" /></label>
                                </td>
                                <td valign="top" class="value ${flash.message == "task.reassignTo.invalid" ? "errors" : ""}">
                                    <g:select name="reassignTo" optionKey="${{it.getUsername()}}" optionValue="${{it.familyName+', '+it.givenName}}" from="${userList}" value="${params.reassignTo ? params.reassignTo : ''}" /><%-- noSelection="${['':'- - - REASSIGN TO GROUP - - -']}" --%>
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'task.reassignTo.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                   
                    
                </div>
                 <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="doreassign" value="${message(code: 'default.button.reassign.label', default: 'Reassign')}" /></span> 
                </div>
                
            </g:form>
        </div>
    </body>
</html>
