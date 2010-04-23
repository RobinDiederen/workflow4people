
<%@ page import="org.workflow4people.BaseType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'baseType.label', default: 'BaseType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'baseType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'baseType.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'baseType.description.label', default: 'Description')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${baseTypeInstanceList}" status="i" var="baseTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${baseTypeInstance.id}">${fieldValue(bean: baseTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: baseTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: baseTypeInstance, field: "description")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${baseTypeInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${baseTypeInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${baseTypeInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${baseTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
