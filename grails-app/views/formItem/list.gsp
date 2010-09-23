
<%@ page import="org.workflow4people.FormItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formItem.label', default: 'FormItem')}" />
        <title><g:message code="formItem.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="formItem.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'formItem.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="position" title="${message(code: 'formItem.position.label', default: 'Position')}" />
                        
                            <th><g:message code="formItem.field.label" default="Field" /></th>
                   	    
                            <g:sortableColumn params="${filteredParams}" property="baseXpath" title="${message(code: 'formItem.baseXpath.label', default: 'Base Xpath')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="readonly" title="${message(code: 'formItem.readonly.label', default: 'Readonly')}" />
                        
                            <th><g:message code="formItem.form.label" default="Form" /></th>
                   	    
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${formItemInstanceList}" status="i" var="formItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${formItemInstance.id}">${fieldValue(bean: formItemInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: formItemInstance, field: "position")}</td>
                        
                            <td>${fieldValue(bean: formItemInstance, field: "field")}</td>
                        
                            <td>${fieldValue(bean: formItemInstance, field: "baseXpath")}</td>
                        
                            <td><g:formatBoolean boolean="${formItemInstance.readonly}" /></td>
                        
                            <td>${fieldValue(bean: formItemInstance, field: "form")}</td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'formItem.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${formItemInstance.id}"><g:message default="show" code="formItem.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'formItem.list.edit.help')}" action="edit" params="${filteredParams}" id="${formItemInstance.id}"><g:message default="edit" code="formItem.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'formItem.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'formItem.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${formItemInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${formItemInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${formItemInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
