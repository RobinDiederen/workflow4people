
<%@ page import="org.workflow4people.Field" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'field.label', default: 'Field')}" />
        <title><g:message code="field.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="field.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,fieldInstance:fieldInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'field.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="fieldPosition" title="${message(code: 'field.fieldPosition.label', default: 'Field Position')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'field.name.label', default: 'Name')}" />
                        
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
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'field.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${fieldInstance.id}"><g:message default="show" code="field.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'field.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${fieldInstance.id}"><g:message default="edit" code="field.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'field.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'field.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
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
