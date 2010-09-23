
<%@ page import="org.workflow4people.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
        <title><g:message code="document.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="document.new.label"  /></g:link></span>
            
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
                        
                            <th><g:message code="document.documentType.label" default="Document Type" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams}" property="documentDescription" title="${message(code: 'document.documentDescription.label', default: 'Document Description')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="dateCreated" title="${message(code: 'document.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="lastUpdated" title="${message(code: 'document.lastUpdated.label', default: 'Last Updated')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentInstanceList}" status="i" var="documentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "documentType")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentInstance, field: "documentDescription")}</td>
                        
                            <td><g:formatDate date="${documentInstance.dateCreated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                            <td><g:formatDate date="${documentInstance.lastUpdated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'document.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${documentInstance.id}"><g:message default="show" code="document.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'document.list.edit.help')}" action="edit" params="${filteredParams}" id="${documentInstance.id}"><g:message default="edit" code="document.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'document.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'document.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${documentInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${documentInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
