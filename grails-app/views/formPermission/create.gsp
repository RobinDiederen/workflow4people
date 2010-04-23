
<%@ page import="org.workflow4people.FormPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formPermission.label', default: 'FormPermission')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                     	<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>                		                        
                    
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
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="authority"><g:message code="formPermission.authority.label" default="Authority" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formPermissionInstance, field: 'authority', 'errors')}">
                                    <g:select name="authority.id" from="${org.workflow4people.Authority.list()}" optionKey="id" value="${formPermissionInstance?.authority?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="role"><g:message code="formPermission.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formPermissionInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${org.workflow4people.Role.list()}" optionKey="id" value="${formPermissionInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="remark"><g:message code="formPermission.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formPermissionInstance, field: 'remark', 'errors')}">
                                    <g:textField name="remark" value="${formPermissionInstance?.remark}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                            
                    
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
