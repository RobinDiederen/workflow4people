
<%@ page import="org.workflow4people.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'person.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'person.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="userRealName" title="${message(code: 'person.userRealName.label', default: 'User Real Name')}" />
                        
                            <g:sortableColumn property="familyName" title="${message(code: 'person.familyName.label', default: 'Family Name')}" />
                        
                            <g:sortableColumn property="givenName" title="${message(code: 'person.givenName.label', default: 'Given Name')}" />
                        
                            <g:sortableColumn property="email" title="${message(code: 'person.email.label', default: 'Email')}" />
                        
                        <th>Action</th>
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
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${personInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${personInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${personInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${personInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
