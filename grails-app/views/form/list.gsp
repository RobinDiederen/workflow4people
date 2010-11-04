
<%@ page import="org.workflow4people.Form" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
        <title><g:message code="form.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="form.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,formInstance:formInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'form.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="name" title="${message(code: 'form.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="title" title="${message(code: 'form.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="description" title="${message(code: 'form.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="explanationMessage" title="${message(code: 'form.explanationMessage.label', default: 'Explanation Message')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="confirmationMessage" title="${message(code: 'form.confirmationMessage.label', default: 'Confirmation Message')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${formInstanceList}" status="i" var="formInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${formInstance.id}">${fieldValue(bean: formInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: formInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "explanationMessage")}</td>
                        
                            <td>${fieldValue(bean: formInstance, field: "confirmationMessage")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'form.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${formInstance.id}"><g:message default="show" code="form.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'form.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${formInstance.id}"><g:message default="edit" code="form.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'form.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'form.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${formInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${formInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${formInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
