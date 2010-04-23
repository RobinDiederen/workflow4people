
<%@ page import="org.workflow4people.FeaturePermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'featurePermission.label', default: 'FeaturePermission')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'featurePermission.id.label', default: 'Id')}" />
                        
                            <th><g:message code="featurePermission.authority.label" default="Authority" /></th>
                   	    
                            <th><g:message code="featurePermission.role.label" default="Role" /></th>
                   	    
                            <g:sortableColumn property="remark" title="${message(code: 'featurePermission.remark.label', default: 'Remark')}" />
                        
                            <th><g:message code="featurePermission.feature.label" default="Feature" /></th>
                   	    
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${featurePermissionInstanceList}" status="i" var="featurePermissionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${featurePermissionInstance.id}">${fieldValue(bean: featurePermissionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: featurePermissionInstance, field: "authority")}</td>
                        
                            <td>${fieldValue(bean: featurePermissionInstance, field: "role")}</td>
                        
                            <td>${fieldValue(bean: featurePermissionInstance, field: "remark")}</td>
                        
                            <td>${fieldValue(bean: featurePermissionInstance, field: "feature")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${featurePermissionInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${featurePermissionInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${featurePermissionInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${featurePermissionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
