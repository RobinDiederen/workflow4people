
<%@ page import="org.workflow4people.Action" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'action.label', default: 'Action')}" />
        <title><g:message code="action.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="action.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'action.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="name" title="${message(code: 'action.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="title" title="${message(code: 'action.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="description" title="${message(code: 'action.description.label', default: 'Description')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${actionInstanceList}" status="i" var="actionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${actionInstance.id}">${fieldValue(bean: actionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: actionInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: actionInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: actionInstance, field: "description")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'action.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${actionInstance.id}"><g:message default="show" code="action.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'action.list.edit.help')}" action="edit" params="${filteredParams}" id="${actionInstance.id}"><g:message default="edit" code="action.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'action.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'action.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${actionInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${actionInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${actionInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
