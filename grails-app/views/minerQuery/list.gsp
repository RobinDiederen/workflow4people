
<%@ page import="org.workflow4people.MinerQuery" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'minerQuery.label', default: 'MinerQuery')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'minerQuery.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'minerQuery.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'minerQuery.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'minerQuery.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="explanationMessage" title="${message(code: 'minerQuery.explanationMessage.label', default: 'Explanation Message')}" />
                        
                            <g:sortableColumn property="query" title="${message(code: 'minerQuery.query.label', default: 'Query')}" />
                        
                        <th class="action">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${minerQueryInstanceList}" status="i" var="minerQueryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${minerQueryInstance.id}">${fieldValue(bean: minerQueryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "explanationMessage")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "query")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${minerQueryInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${minerQueryInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${minerQueryInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${minerQueryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
