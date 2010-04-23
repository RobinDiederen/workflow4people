
<%@ page import="org.workflow4people.FieldList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldList.label', default: 'FieldList')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'fieldList.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'fieldList.name.label', default: 'Name')}" />
                        
                            <th><g:message code="fieldList.namespace.label" default="Namespace" /></th>
                   	    
                            <th><g:message code="fieldList.baseType.label" default="Base Type" /></th>
                   	    
                            <g:sortableColumn property="label" title="${message(code: 'fieldList.label.label', default: 'Label')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'fieldList.description.label', default: 'Description')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fieldListInstanceList}" status="i" var="fieldListInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fieldListInstance.id}">${fieldValue(bean: fieldListInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "namespace")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "baseType")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "label")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "description")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${fieldListInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${fieldListInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldListInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${fieldListInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
