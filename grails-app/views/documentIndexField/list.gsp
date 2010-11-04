
<%@ page import="org.workflow4people.DocumentIndexField" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndexField.label', default: 'DocumentIndexField')}" />
        <title><g:message code="documentIndexField.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="documentIndexField.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,documentIndexFieldInstance:documentIndexFieldInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'documentIndexField.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'documentIndexField.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="title" title="${message(code: 'documentIndexField.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="description" title="${message(code: 'documentIndexField.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="xpath" title="${message(code: 'documentIndexField.xpath.label', default: 'Xpath')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="publish" title="${message(code: 'documentIndexField.publish.label', default: 'Publish')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentIndexFieldInstanceList}" status="i" var="documentIndexFieldInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${documentIndexFieldInstance.id}">${fieldValue(bean: documentIndexFieldInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: documentIndexFieldInstance, field: "xpath")}</td>
                        
                            <td><g:formatBoolean boolean="${documentIndexFieldInstance.publish}" /></td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'documentIndexField.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${documentIndexFieldInstance.id}"><g:message default="show" code="documentIndexField.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'documentIndexField.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${documentIndexFieldInstance.id}"><g:message default="edit" code="documentIndexField.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'documentIndexField.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'documentIndexField.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${documentIndexFieldInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${documentIndexFieldInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${documentIndexFieldInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
