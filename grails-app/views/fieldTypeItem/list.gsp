
<%@ page import="org.workflow4people.FieldTypeItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldTypeItem.label', default: 'FieldTypeItem')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'fieldTypeItem.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="itemPosition" title="${message(code: 'fieldTypeItem.itemPosition.label', default: 'Item Position')}" />
                        
                            <g:sortableColumn property="label" title="${message(code: 'fieldTypeItem.label.label', default: 'Label')}" />
                        
                            <g:sortableColumn property="value" title="${message(code: 'fieldTypeItem.value.label', default: 'Value')}" />
                        
                            <th><g:message code="fieldTypeItem.fieldType.label" default="Field Type" /></th>
                   	    
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fieldTypeItemInstanceList}" status="i" var="fieldTypeItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fieldTypeItemInstance.id}">${fieldValue(bean: fieldTypeItemInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fieldTypeItemInstance, field: "itemPosition")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeItemInstance, field: "label")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeItemInstance, field: "value")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeItemInstance, field: "fieldType")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${fieldTypeItemInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${fieldTypeItemInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldTypeItemInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${fieldTypeItemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
