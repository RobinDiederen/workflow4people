
<%@ page import="org.workflow4people.Role" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="role.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="role.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,roleInstance:roleInstance]"/>
        	</g:if>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'role.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'role.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="title" title="${message(code: 'role.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="description" title="${message(code: 'role.description.label', default: 'Description')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${roleInstanceList}" status="i" var="roleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${roleInstance.id}">${fieldValue(bean: roleInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: roleInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: roleInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: roleInstance, field: "description")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'role.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${roleInstance.id}"><g:message default="show" code="role.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'role.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${roleInstance.id}"><g:message default="edit" code="role.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'role.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'role.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${roleInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${roleInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${roleInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
