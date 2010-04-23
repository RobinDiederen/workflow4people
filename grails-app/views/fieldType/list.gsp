
<%@ page import="org.workflow4people.FieldType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldType.label', default: 'FieldType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'fieldType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'fieldType.name.label', default: 'Name')}" />
                        
                            <th><g:message code="fieldType.namespace.label" default="Namespace" /></th>
                   	    
                            <th><g:message code="fieldType.baseType.label" default="Base Type" /></th>
                   	    
                            <g:sortableColumn property="baseSchemaType" title="${message(code: 'fieldType.baseSchemaType.label', default: 'Base Schema Type')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'fieldType.description.label', default: 'Description')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fieldTypeInstanceList}" status="i" var="fieldTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fieldTypeInstance.id}">${fieldValue(bean: fieldTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "namespace")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "baseType")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "baseSchemaType")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "description")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${fieldTypeInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${fieldTypeInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldTypeInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${fieldTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
