
<%@ page import="org.workflow4people.WorkflowPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowPermission.label', default: 'WorkflowPermission')}" />
        <title><g:message code="workflowPermission.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="workflowPermission.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,workflowPermissionInstance:workflowPermissionInstance]"/>
        	</g:if>
        </div>
            
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'workflowPermission.id.label', default: 'Id')}" />
                        
                            <th><g:message code="workflowPermission.authority.label" default="Authority" /></th>
                   	    
                            <th><g:message code="workflowPermission.role.label" default="Role" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="remark" title="${message(code: 'workflowPermission.remark.label', default: 'Remark')}" />
                        
                            <th><g:message code="workflowPermission.workflow.label" default="Workflow" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${workflowPermissionInstanceList}" status="i" var="workflowPermissionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${workflowPermissionInstance.id}">${fieldValue(bean: workflowPermissionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: workflowPermissionInstance, field: "authority")}</td>
                        
                            <td>${fieldValue(bean: workflowPermissionInstance, field: "role")}</td>
                        
                            <td>${fieldValue(bean: workflowPermissionInstance, field: "remark")}</td>
                        
                            <td>${fieldValue(bean: workflowPermissionInstance, field: "workflow")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'workflowPermission.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${workflowPermissionInstance.id}"><g:message default="show" code="workflowPermission.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'workflowPermission.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${workflowPermissionInstance.id}"><g:message default="edit" code="workflowPermission.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'workflowPermission.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'workflowPermission.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${workflowPermissionInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${workflowPermissionInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${workflowPermissionInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
