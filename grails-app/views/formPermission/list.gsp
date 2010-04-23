
<%@ page import="org.workflow4people.FormPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formPermission.label', default: 'FormPermission')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'formPermission.id.label', default: 'Id')}" />
                        
                            <th><g:message code="formPermission.authority.label" default="Authority" /></th>
                   	    
                            <th><g:message code="formPermission.role.label" default="Role" /></th>
                   	    
                            <g:sortableColumn property="remark" title="${message(code: 'formPermission.remark.label', default: 'Remark')}" />
                        
                            <th><g:message code="formPermission.form.label" default="Form" /></th>
                   	    
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${formPermissionInstanceList}" status="i" var="formPermissionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${formPermissionInstance.id}">${fieldValue(bean: formPermissionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: formPermissionInstance, field: "authority")}</td>
                        
                            <td>${fieldValue(bean: formPermissionInstance, field: "role")}</td>
                        
                            <td>${fieldValue(bean: formPermissionInstance, field: "remark")}</td>
                        
                            <td>${fieldValue(bean: formPermissionInstance, field: "form")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${formPermissionInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${formPermissionInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${formPermissionInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${formPermissionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
