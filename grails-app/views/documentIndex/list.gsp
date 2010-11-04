
<%@ page import="org.workflow4people.DocumentIndex" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndex.label', default: 'DocumentIndex')}" />
        <title><g:message code="documentIndex.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="documentIndex.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,documentIndexInstance:documentIndexInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'documentIndex.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'documentIndex.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="value" title="${message(code: 'documentIndex.value.label', default: 'Value')}" />
                        
                            <th><g:message code="documentIndex.document.label" default="Document" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentIndexInstanceList}" status="i" var="documentIndexInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentIndexInstance.id}">${fieldValue(bean: documentIndexInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentIndexInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: documentIndexInstance, field: "value")}</td>
                        
                            <td>${fieldValue(bean: documentIndexInstance, field: "document")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'documentIndex.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${documentIndexInstance.id}"><g:message default="show" code="documentIndex.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'documentIndex.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${documentIndexInstance.id}"><g:message default="edit" code="documentIndex.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'documentIndex.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'documentIndex.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentIndexInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${documentIndexInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${documentIndexInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
