
<%@ page import="org.workflow4people.DayPart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dayPart.label', default: 'DayPart')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'dayPart.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="dayName" title="${message(code: 'dayPart.dayName.label', default: 'Day Name')}" />
                        
                            <g:sortableColumn property="fromTime" title="${message(code: 'dayPart.fromTime.label', default: 'From Time')}" />
                        
                            <g:sortableColumn property="toTime" title="${message(code: 'dayPart.toTime.label', default: 'To Time')}" />
                        
                            <g:sortableColumn property="position" title="${message(code: 'dayPart.position.label', default: 'Position')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${dayPartInstanceList}" status="i" var="dayPartInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${dayPartInstance.id}">${fieldValue(bean: dayPartInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "dayName")}</td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "fromTime")}</td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "toTime")}</td>
                        
                            <td>${fieldValue(bean: dayPartInstance, field: "position")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${dayPartInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${dayPartInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${dayPartInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${dayPartInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
