
<%@ page import="org.workflow4people.Namespace" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'namespace.label', default: 'Namespace')}" />
        <title><g:message code="namespace.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="namespace.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'namespace.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="prefix" title="${message(code: 'namespace.prefix.label', default: 'Prefix')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="uri" title="${message(code: 'namespace.uri.label', default: 'Uri')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="filename" title="${message(code: 'namespace.filename.label', default: 'Filename')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="generateXSDFile" title="${message(code: 'namespace.generateXSDFile.label', default: 'Generate XSDF ile')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="includeSchema" title="${message(code: 'namespace.includeSchema.label', default: 'Include Schema')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
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
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'namespace.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${namespaceInstance.id}"><g:message default="show" code="namespace.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'namespace.list.edit.help')}" action="edit" params="${filteredParams}" id="${namespaceInstance.id}"><g:message default="edit" code="namespace.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'namespace.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'namespace.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${namespaceInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${namespaceInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${namespaceInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
