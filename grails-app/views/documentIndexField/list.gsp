
<%@ page import="org.workflow4people.DocumentIndexField" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndexField.label', default: 'DocumentIndexField')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'documentIndexField.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'documentIndexField.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'documentIndexField.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'documentIndexField.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="xpath" title="${message(code: 'documentIndexField.xpath.label', default: 'Xpath')}" />
                        
                            <g:sortableColumn property="publish" title="${message(code: 'documentIndexField.publish.label', default: 'Publish')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentIndexFieldInstanceList}" status="i" var="documentIndexFieldInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentIndexFieldInstance.id}">${fieldValue(bean: documentIndexFieldInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "xpath")}</td>
                        
                            <td><g:formatBoolean boolean="${documentIndexFieldInstance.publish}" /></td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${documentIndexFieldInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${documentIndexFieldInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentIndexFieldInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${documentIndexFieldInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
