
<%@ page import="org.workflow4people.Holiday" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'holiday.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'holiday.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="fromDate" title="${message(code: 'holiday.fromDate.label', default: 'From Date')}" />
                        
                            <g:sortableColumn property="toDate" title="${message(code: 'holiday.toDate.label', default: 'To Date')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${holidayInstanceList}" status="i" var="holidayInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${holidayInstance.id}">${fieldValue(bean: holidayInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: holidayInstance, field: "title")}</td>
                        
                            <td><g:formatDate date="${holidayInstance.fromDate}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                            <td><g:formatDate date="${holidayInstance.toDate}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${holidayInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${holidayInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${holidayInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${holidayInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
