
<%@ page import="org.workflow4people.DocumentType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentType.label', default: 'DocumentType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'documentType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'documentType.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'documentType.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="descriptionTemplate" title="${message(code: 'documentType.descriptionTemplate.label', default: 'Description Template')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'documentType.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'documentType.lastUpdated.label', default: 'Last Updated')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentTypeInstanceList}" status="i" var="documentTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentTypeInstance.id}">${fieldValue(bean: documentTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: documentTypeInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: documentTypeInstance, field: "descriptionTemplate")}</td>
                        
                            <td><g:formatDate date="${documentTypeInstance.dateCreated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                            <td><g:formatDate date="${documentTypeInstance.lastUpdated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${documentTypeInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${documentTypeInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentTypeInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${documentTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
