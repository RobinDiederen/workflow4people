
<%@ page import="org.workflow4people.WorkflowDefinition" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowDefinition.label', default: 'WorkflowDefinition')}" />
        <title><g:message code="workflowDefinition.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="workflowDefinition.new.label"  /></g:link></span>
            
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
                        
                            <g:sortableColumn params="${filteredParams}" property="id" title="${message(code: 'workflowDefinition.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="publish" title="${message(code: 'workflowDefinition.publish.label', default: 'Publish')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="name" title="${message(code: 'workflowDefinition.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="title" title="${message(code: 'workflowDefinition.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="description" title="${message(code: 'workflowDefinition.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn params="${filteredParams}" property="dateCreated" title="${message(code: 'workflowDefinition.dateCreated.label', default: 'Date Created')}" />
                        
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${workflowDefinitionInstanceList}" status="i" var="workflowDefinitionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${workflowDefinitionInstance.id}">${fieldValue(bean: workflowDefinitionInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatBoolean boolean="${workflowDefinitionInstance.publish}" /></td>
                        
                            <td>${fieldValue(bean: workflowDefinitionInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: workflowDefinitionInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: workflowDefinitionInstance, field: "description")}</td>
                        
                            <td><g:formatDate date="${workflowDefinitionInstance.dateCreated}" format="yyyy-MM-dd'T'HH:mm:ss"/></td>
                        
                        <td> 
                            
                        		<g:link title ="${message(default: 'Show this item',code: 'workflowDefinition.list.show.help')}" params="${filteredParams}" action="show" class="awesome small blue button" id="${workflowDefinitionInstance.id}"><g:message default="show" code="workflowDefinition.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	
                        	
                            	<g:link class="awesome small blue button" title="${message(default: 'Modify this item',code: 'workflowDefinition.list.edit.help')}" action="edit" params="${filteredParams}" id="${workflowDefinitionInstance.id}"><g:message default="edit" code="workflowDefinition.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            
                            
                            	<g:link title="${message(default: 'Delete this item',code: 'workflowDefinition.list.delete.help')}" class="awesome small red button" onclick="return confirm('${message(code: 'workflowDefinition.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="${workflowDefinitionInstance.id}" params="${filteredParams}">&times;</g:link></td>
                                                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="${q}" >
                <g:paginate total="${workflowDefinitionInstanceTotal}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="${workflowDefinitionInstanceTotal}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
