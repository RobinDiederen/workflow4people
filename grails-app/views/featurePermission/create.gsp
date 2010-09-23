
<%@ page import="org.workflow4people.FeaturePermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'featurePermission.label', default: 'FeaturePermission')}" />
        <title><g:message code="featurePermission.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="feature" action="show" id="${featurePermissionInstance?.feature?.id}">&laquo;&nbsp; ${featurePermissionInstance?.feature?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
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
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="authority"><g:message code="featurePermission.authority.label" default="Authority" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: featurePermissionInstance, field: 'authority', 'errors')}">
                                    <g:select name="authority.id" from="${org.workflow4people.Authority.list()}" optionKey="id" value="${featurePermissionInstance?.authority?.id}"  />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'featurePermission.authority.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="role"><g:message code="featurePermission.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: featurePermissionInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${org.workflow4people.Role.list()}" optionKey="id" value="${featurePermissionInstance?.role?.id}"  />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'featurePermission.role.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="remark"><g:message code="featurePermission.remark.label" default="Remark" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: featurePermissionInstance, field: 'remark', 'errors')}">
                                    <g:textField name="remark" value="${featurePermissionInstance?.remark}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'featurePermission.remark.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                                                    
                           	<g:hiddenField name="feature.id" value="${featurePermissionInstance?.feature?.id}" />                            
                                
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
					<g:hiddenField name="q" value="${params.q}" />
                    
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
