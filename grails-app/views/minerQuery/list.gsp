
<%@ page import="org.workflow4people.MinerQuery" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'minerQuery.label', default: 'MinerQuery')}" />
        <title><g:message code="minerQuery.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="minerQuery.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,minerQueryInstance:minerQueryInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'minerQuery.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'minerQuery.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="title" title="${message(code: 'minerQuery.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="description" title="${message(code: 'minerQuery.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="explanationMessage" title="${message(code: 'minerQuery.explanationMessage.label', default: 'Explanation Message')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="query" title="${message(code: 'minerQuery.query.label', default: 'Query')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${minerQueryInstanceList}" status="i" var="minerQueryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${minerQueryInstance.id}">${fieldValue(bean: minerQueryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "explanationMessage")}</td>
                        
                            <td>${fieldValue(bean: minerQueryInstance, field: "query")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'minerQuery.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${minerQueryInstance.id}"><g:message default="show" code="minerQuery.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'minerQuery.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${minerQueryInstance.id}"><g:message default="edit" code="minerQuery.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'minerQuery.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'minerQuery.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${minerQueryInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${minerQueryInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${minerQueryInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
