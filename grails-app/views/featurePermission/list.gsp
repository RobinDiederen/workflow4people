
<%@ page import="org.workflow4people.FeaturePermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'featurePermission.label', default: 'FeaturePermission')}" />
        <title><g:message code="featurePermission.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="featurePermission.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'featurePermission.id.label', default: 'Id')}" />
                        
                            <th><g:message code="featurePermission.authority.label" default="Authority" /></th>
                   	    
                            <th><g:message code="featurePermission.role.label" default="Role" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams}" property="remark" title="${message(code: 'featurePermission.remark.label', default: 'Remark')}" />
                        
                            <th><g:message code="featurePermission.feature.label" default="Feature" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
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
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'featurePermission.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${featurePermissionInstance.id}"><g:message default="show" code="featurePermission.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'featurePermission.list.edit.help')}" action="edit" params="${filteredParams}" id="${featurePermissionInstance.id}"><g:message default="edit" code="featurePermission.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'featurePermission.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'featurePermission.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${featurePermissionInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${featurePermissionInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${featurePermissionInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
