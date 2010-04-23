
<%@ page import="org.workflow4people.ApplicationConfiguration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationConfiguration.label', default: 'ApplicationConfiguration')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'applicationConfiguration.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="configKey" title="${message(code: 'applicationConfiguration.configKey.label', default: 'Config Key')}" />
                        
                            <g:sortableColumn property="configValue" title="${message(code: 'applicationConfiguration.configValue.label', default: 'Config Value')}" />
                        
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${applicationConfigurationInstanceList}" status="i" var="applicationConfigurationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${applicationConfigurationInstance.id}">${fieldValue(bean: applicationConfigurationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: applicationConfigurationInstance, field: "configKey")}</td>
                        
                            <td>${fieldValue(bean: applicationConfigurationInstance, field: "configValue")}</td>
                        
                        <td><g:link title ="Show this item" action="show" class="awesome small blue button" id="${applicationConfigurationInstance.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" title="Modify this item" action="edit" id="${applicationConfigurationInstance.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${applicationConfigurationInstance.id}">&times;</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${applicationConfigurationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
