
<%@ page import="org.workflow4people.Authority" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'authority.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="authority" title="${message(code: 'authority.authority.label', default: 'Authority')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'authority.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="authorityType" title="${message(code: 'authority.authorityType.label', default: 'Authority Type')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${authorityInstanceList}" status="i" var="authorityInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${authorityInstance.id}">${fieldValue(bean: authorityInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: authorityInstance, field: "authority")}</td>
                        
                            <td>${fieldValue(bean: authorityInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: authorityInstance, field: "authorityType")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${authorityInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${authorityInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${authorityInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${authorityInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
