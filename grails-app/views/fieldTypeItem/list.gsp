
<%@ page import="org.workflow4people.FieldTypeItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldTypeItem.label', default: 'FieldTypeItem')}" />
        <title><g:message code="fieldTypeItem.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="fieldTypeItem.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,fieldTypeItemInstance:fieldTypeItemInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'fieldTypeItem.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="itemPosition" title="${message(code: 'fieldTypeItem.itemPosition.label', default: 'Item Position')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="label" title="${message(code: 'fieldTypeItem.label.label', default: 'Label')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="value" title="${message(code: 'fieldTypeItem.value.label', default: 'Value')}" />
                        
                            <th><g:message code="fieldTypeItem.fieldType.label" default="Field Type" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
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
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'fieldTypeItem.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${fieldTypeItemInstance.id}"><g:message default="show" code="fieldTypeItem.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'fieldTypeItem.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${fieldTypeItemInstance.id}"><g:message default="edit" code="fieldTypeItem.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'fieldTypeItem.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'fieldTypeItem.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldTypeItemInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${fieldTypeItemInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${fieldTypeItemInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
