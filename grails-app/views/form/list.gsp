
<%@ page import="org.workflow4people.Form" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'form.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'form.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'form.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'form.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="explanationMessage" title="${message(code: 'form.explanationMessage.label', default: 'Explanation Message')}" />
                        
                            <g:sortableColumn property="confirmationMessage" title="${message(code: 'form.confirmationMessage.label', default: 'Confirmation Message')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${formInstanceList}" status="i" var="formInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${formInstance.id}">${fieldValue(bean: formInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: formInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "explanationMessage")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "confirmationMessage")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${formInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${formInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${formInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${formInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
