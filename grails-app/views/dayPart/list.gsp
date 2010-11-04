
<%@ page import="org.workflow4people.DayPart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dayPart.label', default: 'DayPart')}" />
        <title><g:message code="dayPart.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="dayPart.new.label"  /></g:link></span>
            
         	<g:if test="${searchTemplate}" >
        		<g:render template="${searchTemplate}" model="[entityName:entityName,dayPartInstance:dayPartInstance]"/>
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
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="id" title="${message(code: 'dayPart.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="position" title="${message(code: 'dayPart.position.label', default: 'Position')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="dayName" title="${message(code: 'dayPart.dayName.label', default: 'Day Name')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="fromTime" title="${message(code: 'dayPart.fromTime.label', default: 'From Time')}" />
                        
                            <g:sortableColumn params="${filteredParams ? filteredParams : ''}" property="toTime" title="${message(code: 'dayPart.toTime.label', default: 'To Time')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${dayPartInstanceList}" status="i" var="dayPartInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${dayPartInstance.id}">${fieldValue(bean: dayPartInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "position")}</td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "dayName")}</td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "fromTime")}</td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "toTime")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'dayPart.list.show.help')}" params="${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="${dayPartInstance.id}"><g:message default="show" code="dayPart.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'dayPart.list.edit.help')}" action="edit" params="${filteredParams ? filteredParams : ''}" id="${dayPartInstance.id}"><g:message default="edit" code="dayPart.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'dayPart.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'dayPart.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${dayPartInstance.id}" params="${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${dayPartInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${dayPartInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
