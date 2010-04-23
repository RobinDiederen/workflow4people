
<%@ page import="org.workflow4people.WorkflowDefinition" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowDefinition.label', default: 'WorkflowDefinition')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'workflowDefinition.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="publish" title="${message(code: 'workflowDefinition.publish.label', default: 'Publish')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'workflowDefinition.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'workflowDefinition.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'workflowDefinition.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'workflowDefinition.dateCreated.label', default: 'Date Created')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${workflowDefinitionInstanceList}" status="i" var="workflowDefinitionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${workflowDefinitionInstance.id}">${fieldValue(bean: workflowDefinitionInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatBoolean boolean="${workflowDefinitionInstance.publish}" /></td>
                        
                            <td>${fieldValue(bean: workflowDefinitionInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: workflowDefinitionInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: workflowDefinitionInstance, field: "description")}</td>
                        
                            <td><g:formatDate date="${workflowDefinitionInstance.dateCreated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${workflowDefinitionInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${workflowDefinitionInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${workflowDefinitionInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${workflowDefinitionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
