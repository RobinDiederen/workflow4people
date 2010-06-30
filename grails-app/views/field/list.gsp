
<%@ page import="org.workflow4people.Field" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'field.label', default: 'Field')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'field.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="fieldPosition" title="${message(code: 'field.fieldPosition.label', default: 'Field Position')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'field.name.label', default: 'Name')}" />
                        
                            <th><g:message code="field.fieldType.label" default="Field Type" /></th>
                   	    
                            <th><g:message code="field.childFieldList.label" default="Child Field List" /></th>
                   	    
                            <th><g:message code="field.fieldList.label" default="Field List" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fieldInstanceList}" status="i" var="fieldInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fieldInstance.id}">${fieldValue(bean: fieldInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fieldInstance, field: "fieldPosition")}</td>
                        
                            <td>${fieldValue(bean: fieldInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: fieldInstance, field: "fieldType")}</td>
                        
                            <td>${fieldValue(bean: fieldInstance, field: "childFieldList")}</td>
                        
                            <td>${fieldValue(bean: fieldInstance, field: "fieldList")}</td>
                        
                        <td><g:link title ="${message(default: 'Show this item',code: 'default.list.show.help')}" action="show" class="awesome small blue button" id="${fieldInstance.id}"><g:message default="show" code="default.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'default.list.edit.help')}" action="edit" id="${fieldInstance.id}"><g:message default="edit" code="default.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;<g:link title="${message(default: 'Delete this item',code: 'default.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldInstance.id}">&times;</g:link></td>
                        
                        
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${fieldInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${fieldInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
