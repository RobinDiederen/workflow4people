
<%@ page import="org.workflow4people.FieldList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldList.label', default: 'FieldList')}" />
        <title><g:message code="fieldList.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="fieldList.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,fieldListInstance:fieldListInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'fieldList.id.label', default: 'Id')}" />
                        
                            <th><g:message code="fieldList.parent.label" default="Parent" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'fieldList.name.label', default: 'Name')}" />
                        
                            <th><g:message code="fieldList.namespace.label" default="Namespace" /></th>
                   	    
                            <th><g:message code="fieldList.baseType.label" default="Base Type" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="label" title="${message(code: 'fieldList.label.label', default: 'Label')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fieldListInstanceList}" status="i" var="fieldListInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fieldListInstance.id}">${fieldValue(bean: fieldListInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "parent")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "namespace")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "baseType")}</td>
                        
                            <td>${fieldValue(bean: fieldListInstance, field: "label")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'fieldList.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${fieldListInstance.id}"><g:message default="show" code="fieldList.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'fieldList.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${fieldListInstance.id}"><g:message default="edit" code="fieldList.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'fieldList.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'fieldList.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${fieldListInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${fieldListInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${fieldListInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
