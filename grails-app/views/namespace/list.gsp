
<%@ page import="org.workflow4people.Namespace" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'namespace.label', default: 'Namespace')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'namespace.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="prefix" title="${message(code: 'namespace.prefix.label', default: 'Prefix')}" />
                        
                            <g:sortableColumn property="uri" title="${message(code: 'namespace.uri.label', default: 'Uri')}" />
                        
                            <g:sortableColumn property="filename" title="${message(code: 'namespace.filename.label', default: 'Filename')}" />
                        
                            <g:sortableColumn property="generateXSDFile" title="${message(code: 'namespace.generateXSDFile.label', default: 'Generate XSDF ile')}" />
                        
                            <g:sortableColumn property="includeSchema" title="${message(code: 'namespace.includeSchema.label', default: 'Include Schema')}" />
                        
                        <th class="action">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${namespaceInstanceList}" status="i" var="namespaceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${namespaceInstance.id}">${fieldValue(bean: namespaceInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: namespaceInstance, field: "prefix")}</td>
                        
                            <td>${fieldValue(bean: namespaceInstance, field: "uri")}</td>
                        
                            <td>${fieldValue(bean: namespaceInstance, field: "filename")}</td>
                        
                            <td><g:formatBoolean boolean="${namespaceInstance.generateXSDFile}" /></td>
                        
                            <td>${fieldValue(bean: namespaceInstance, field: "includeSchema")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${namespaceInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${namespaceInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${namespaceInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${namespaceInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
