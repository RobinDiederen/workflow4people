
<%@ page import="org.workflow4people.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="person.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="person.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'person.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="username" title="${message(code: 'person.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="userRealName" title="${message(code: 'person.userRealName.label', default: 'User Real Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="familyName" title="${message(code: 'person.familyName.label', default: 'Family Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="givenName" title="${message(code: 'person.givenName.label', default: 'Given Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="email" title="${message(code: 'person.email.label', default: 'Email')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${personInstanceList}" status="i" var="personInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${personInstance.id}">${fieldValue(bean: personInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: personInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "userRealName")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "familyName")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "givenName")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "email")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'person.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${personInstance.id}"><g:message default="show" code="person.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'person.list.edit.help')}" action="edit" params="${filteredParams}" id="${personInstance.id}"><g:message default="edit" code="person.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'person.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'person.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${personInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${personInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${personInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
