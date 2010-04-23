
<%@ page import="org.workflow4people.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'document.id.label', default: 'Id')}" />
                        
                            <th><g:message code="document.documentType.label" default="Document Type" /></th>
                   	    
                            <g:sortableColumn property="documentStatus" title="${message(code: 'document.documentStatus.label', default: 'Document Status')}" />
                        
                            <g:sortableColumn property="documentKey" title="${message(code: 'document.documentKey.label', default: 'Document Key')}" />
                        
                            <g:sortableColumn property="documentDescription" title="${message(code: 'document.documentDescription.label', default: 'Document Description')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'document.dateCreated.label', default: 'Date Created')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentInstanceList}" status="i" var="documentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentInstance, field: "documentType")}</td>
                        
                            <td>${fieldValue(bean: documentInstance, field: "documentStatus")}</td>
                        
                            <td>${fieldValue(bean: documentInstance, field: "documentKey")}</td>
                        
                            <td>${fieldValue(bean: documentInstance, field: "documentDescription")}</td>
                        
                            <td><g:formatDate date="${documentInstance.dateCreated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${documentInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${documentInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${documentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
