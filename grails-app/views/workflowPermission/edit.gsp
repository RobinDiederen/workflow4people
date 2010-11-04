
<%@ page import="org.workflow4people.WorkflowPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowPermission.label', default: 'WorkflowPermission')}" />
        <title><g:message code="workflowPermission.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="workflowDefinition" action="show" id="${workflowPermissionInstance?.workflow?.id}">&laquo;&nbsp; ${workflowPermissionInstance?.workflow?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,workflowPermissionInstance:workflowPermissionInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${workflowPermissionInstance}">
            <div class="errors">
                <g:renderErrors bean="${workflowPermissionInstance}" as="list" />
            </div>
            </g:hasErrors>
                <g:hiddenField name="id" value="${workflowPermissionInstance?.id}" />
                <g:hiddenField name="version" value="${workflowPermissionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="authority"><g:message code="workflowPermission.authority.label" default="Authority" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowPermissionInstance, field: 'authority', 'errors')}">
                                    <g:select name="authority.id" from="${org.workflow4people.Authority.list()}" optionKey="id" value="${workflowPermissionInstance?.authority?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowPermission.authority.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="role"><g:message code="workflowPermission.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowPermissionInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${org.workflow4people.Role.list()}" optionKey="id" value="${workflowPermissionInstance?.role?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowPermission.role.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="remark"><g:message code="workflowPermission.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: workflowPermissionInstance, field: 'remark', 'errors')}">
                                    <g:textField name="remark" value="${workflowPermissionInstance?.remark}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'workflowPermission.remark.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="workflow"><g:message code="workflowPermission.workflow.label" default="Workflow" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowPermissionInstance, field: 'workflow', 'errors')}">
                                    <g:select name="workflow.id" from="${org.workflow4people.WorkflowDefinition.list()}" optionKey="id" value="${workflowPermissionInstance?.workflow?.id}"  />

                                                                        
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                        
                        
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
                    <g:hiddenField name="q" value="${params.q}" />
                        
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>                    
                </div>
            </g:form>
        </div>
    </body>
</html>
