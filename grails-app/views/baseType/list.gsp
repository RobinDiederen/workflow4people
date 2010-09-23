
<%@ page import="org.workflow4people.BaseType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'baseType.label', default: 'BaseType')}" />
        <title><g:message code="baseType.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="baseType.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'baseType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="name" title="${message(code: 'baseType.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="description" title="${message(code: 'baseType.description.label', default: 'Description')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${baseTypeInstanceList}" status="i" var="baseTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${baseTypeInstance.id}">${fieldValue(bean: baseTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: baseTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: baseTypeInstance, field: "description")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'baseType.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${baseTypeInstance.id}"><g:message default="show" code="baseType.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'baseType.list.edit.help')}" action="edit" params="${filteredParams}" id="${baseTypeInstance.id}"><g:message default="edit" code="baseType.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'baseType.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'baseType.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${baseTypeInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${baseTypeInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${baseTypeInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
