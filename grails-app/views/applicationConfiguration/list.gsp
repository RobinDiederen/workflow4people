
<%@ page import="org.workflow4people.ApplicationConfiguration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationConfiguration.label', default: 'ApplicationConfiguration')}" />
        <title><g:message code="applicationConfiguration.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="applicationConfiguration.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'applicationConfiguration.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="configKey" title="${message(code: 'applicationConfiguration.configKey.label', default: 'Config Key')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="configValue" title="${message(code: 'applicationConfiguration.configValue.label', default: 'Config Value')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${applicationConfigurationInstanceList}" status="i" var="applicationConfigurationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${applicationConfigurationInstance.id}">${fieldValue(bean: applicationConfigurationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: applicationConfigurationInstance, field: "configKey")}</td>
                        
                            <td>${fieldValue(bean: applicationConfigurationInstance, field: "configValue")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'applicationConfiguration.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${applicationConfigurationInstance.id}"><g:message default="show" code="applicationConfiguration.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'applicationConfiguration.list.edit.help')}" action="edit" params="${filteredParams}" id="${applicationConfigurationInstance.id}"><g:message default="edit" code="applicationConfiguration.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'applicationConfiguration.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'applicationConfiguration.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${applicationConfigurationInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${applicationConfigurationInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${applicationConfigurationInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
