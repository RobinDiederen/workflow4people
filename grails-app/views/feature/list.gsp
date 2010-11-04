
<%@ page import="org.workflow4people.Feature" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feature.label', default: 'Feature')}" />
        <title><g:message code="feature.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="feature.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,featureInstance:featureInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'feature.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'feature.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="title" title="${message(code: 'feature.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="description" title="${message(code: 'feature.description.label', default: 'Description')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${featureInstanceList}" status="i" var="featureInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${featureInstance.id}">${fieldValue(bean: featureInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: featureInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: featureInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: featureInstance, field: "description")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'feature.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${featureInstance.id}"><g:message default="show" code="feature.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'feature.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${featureInstance.id}"><g:message default="edit" code="feature.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'feature.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'feature.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${featureInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${featureInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${featureInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
