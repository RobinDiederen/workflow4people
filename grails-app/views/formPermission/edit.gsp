
<%@ page import="org.workflow4people.FormPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formPermission.label', default: 'FormPermission')}" />
        <title><g:message code="formPermission.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="formPermission.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,formPermissionInstance:formPermissionInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${formPermissionInstance}">
            <div class="errors">
                <g:renderErrors bean="${formPermissionInstance}" as="list" />
            </div>
            </g:hasErrors>
                <g:hiddenField name="id" value="${formPermissionInstance?.id}" />
                <g:hiddenField name="version" value="${formPermissionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="authority"><g:message code="formPermission.authority.label" default="Authority" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formPermissionInstance, field: 'authority', 'errors')}">
                                    <g:select name="authority.id" from="${org.workflow4people.Authority.list()}" optionKey="id" value="${formPermissionInstance?.authority?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'formPermission.authority.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="role"><g:message code="formPermission.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formPermissionInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${org.workflow4people.Role.list()}" optionKey="id" value="${formPermissionInstance?.role?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'formPermission.role.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="remark"><g:message code="formPermission.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: formPermissionInstance, field: 'remark', 'errors')}">
                                    <g:textField name="remark" value="${formPermissionInstance?.remark}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'formPermission.remark.help',default:'x')}" href="" >?</a>                                    
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
