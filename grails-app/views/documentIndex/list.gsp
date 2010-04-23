
<%@ page import="org.workflow4people.DocumentIndex" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndex.label', default: 'DocumentIndex')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'documentIndex.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'documentIndex.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="value" title="${message(code: 'documentIndex.value.label', default: 'Value')}" />
                        
                            <th><g:message code="documentIndex.document.label" default="Document" /></th>
                   	    
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentIndexInstanceList}" status="i" var="documentIndexInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentIndexInstance.id}">${fieldValue(bean: documentIndexInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentIndexInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: documentIndexInstance, field: "value")}</td>
                        
                            <td>${fieldValue(bean: documentIndexInstance, field: "document")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${documentIndexInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${documentIndexInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentIndexInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${documentIndexInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
