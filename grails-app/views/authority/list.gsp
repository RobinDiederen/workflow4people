
<%@ page import="org.workflow4people.Authority" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
        <title><g:message code="authority.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="authority.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'authority.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="authority" title="${message(code: 'authority.authority.label', default: 'Authority')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="description" title="${message(code: 'authority.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="authorityType" title="${message(code: 'authority.authorityType.label', default: 'Authority Type')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${authorityInstanceList}" status="i" var="authorityInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${authorityInstance.id}">${fieldValue(bean: authorityInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: authorityInstance, field: "authority")}</td>
                        
                            <td>${fieldValue(bean: authorityInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: authorityInstance, field: "authorityType")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'authority.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${authorityInstance.id}"><g:message default="show" code="authority.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'authority.list.edit.help')}" action="edit" params="${filteredParams}" id="${authorityInstance.id}"><g:message default="edit" code="authority.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'authority.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'authority.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${authorityInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${authorityInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${authorityInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
