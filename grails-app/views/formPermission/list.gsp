
<%@ page import="org.workflow4people.FormPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formPermission.label', default: 'FormPermission')}" />
        <title><g:message code="formPermission.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="formPermission.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,formPermissionInstance:formPermissionInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'formPermission.id.label', default: 'Id')}" />
                        
                            <th><g:message code="formPermission.authority.label" default="Authority" /></th>
                   	    
                            <th><g:message code="formPermission.role.label" default="Role" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="remark" title="${message(code: 'formPermission.remark.label', default: 'Remark')}" />
                        
                            <th><g:message code="formPermission.form.label" default="Form" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
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
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'formPermission.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${formPermissionInstance.id}"><g:message default="show" code="formPermission.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'formPermission.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${formPermissionInstance.id}"><g:message default="edit" code="formPermission.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'formPermission.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'formPermission.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${formPermissionInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${formPermissionInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${formPermissionInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
