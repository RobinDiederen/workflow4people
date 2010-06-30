
<%@ page import="org.workflow4people.DocumentType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentType.label', default: 'DocumentType')}" />
        <title><g:message code="documentType.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="documentType.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'documentType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="name" title="${message(code: 'documentType.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="description" title="${message(code: 'documentType.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="descriptionTemplate" title="${message(code: 'documentType.descriptionTemplate.label', default: 'Description Template')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="dateCreated" title="${message(code: 'documentType.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="lastUpdated" title="${message(code: 'documentType.lastUpdated.label', default: 'Last Updated')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentTypeInstanceList}" status="i" var="documentTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentTypeInstance.id}">${fieldValue(bean: documentTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: documentTypeInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: documentTypeInstance, field: "descriptionTemplate")}</td>
                        
                            <td><g:formatDate date="${documentTypeInstance.dateCreated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                            <td><g:formatDate date="${documentTypeInstance.lastUpdated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'documentType.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${documentTypeInstance.id}"><g:message default="show" code="documentType.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'documentType.list.edit.help')}" action="edit" params="${filteredParams}" id="${documentTypeInstance.id}"><g:message default="edit" code="documentType.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'documentType.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'documentType.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentTypeInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${documentTypeInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${documentTypeInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
