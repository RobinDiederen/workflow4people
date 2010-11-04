
<%@ page import="org.workflow4people.FieldType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldType.label', default: 'FieldType')}" />
        <title><g:message code="fieldType.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="fieldType.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,fieldTypeInstance:fieldTypeInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'fieldType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'fieldType.name.label', default: 'Name')}" />
                        
                            <th><g:message code="fieldType.namespace.label" default="Namespace" /></th>
                   	    
                            <th><g:message code="fieldType.baseType.label" default="Base Type" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="baseSchemaType" title="${message(code: 'fieldType.baseSchemaType.label', default: 'Base Schema Type')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="description" title="${message(code: 'fieldType.description.label', default: 'Description')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
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
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'fieldType.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${fieldTypeInstance.id}"><g:message default="show" code="fieldType.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'fieldType.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${fieldTypeInstance.id}"><g:message default="edit" code="fieldType.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'fieldType.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'fieldType.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldTypeInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${fieldTypeInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${fieldTypeInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
