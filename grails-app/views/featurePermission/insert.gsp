
<%@ page import="org.workflow4people.FeaturePermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'featurePermission.label', default: 'FeaturePermission')}" />
        <title><g:message code="featurePermission.insert.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="feature" action="show" id="${featurePermissionInstance?.feature?.id}">&laquo;&nbsp; Feature ${featurePermissionInstance?.feature?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,featurePermissionInstance:featurePermissionInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${featurePermissionInstance}">
            <div class="errors">
                <g:renderErrors bean="${featurePermissionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${featurePermissionInstance?.id}" />
                <g:hiddenField name="version" value="${featurePermissionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="authority"><g:message code="featurePermission.authority.label" default="Authority" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: featurePermissionInstance, field: 'authority', 'errors')}">
                                    <g:select name="authority.id" from="${org.workflow4people.Authority.list()}" optionKey="id" value="${featurePermissionInstance?.authority?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="role"><g:message code="featurePermission.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: featurePermissionInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${org.workflow4people.Role.list()}" optionKey="id" value="${featurePermissionInstance?.role?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="remark"><g:message code="featurePermission.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: featurePermissionInstance, field: 'remark', 'errors')}">
                                    <g:textField name="remark" value="${featurePermissionInstance?.remark}" />

                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                        
                           	<g:hiddenField name="feature.id" value="${featurePermissionInstance?.feature?.id}" />
                            
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="insertsave" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
