
<%@ page import="org.workflow4people.Holiday" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
        <title><g:message code="holiday.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="holiday.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,holidayInstance:holidayInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'holiday.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="title" title="${message(code: 'holiday.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="fromDate" title="${message(code: 'holiday.fromDate.label', default: 'From Date')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="toDate" title="${message(code: 'holiday.toDate.label', default: 'To Date')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${holidayInstanceList}" status="i" var="holidayInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${holidayInstance.id}">${fieldValue(bean: holidayInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: holidayInstance, field: "title")}</td>
                        
                            <td><g:formatDate date="${holidayInstance.fromDate}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                            <td><g:formatDate date="${holidayInstance.toDate}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'holiday.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${holidayInstance.id}"><g:message default="show" code="holiday.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'holiday.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${holidayInstance.id}"><g:message default="edit" code="holiday.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'holiday.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'holiday.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${holidayInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${holidayInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${holidayInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
