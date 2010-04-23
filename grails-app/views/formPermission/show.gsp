
<%@ page import="org.workflow4people.FormPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formPermission.label', default: 'FormPermission')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,formPermissionInstance:formPermissionInstance]"/>
            	</g:if>
        	</div>
           
            <g:if test="${flash.message}">
                        <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@22930462[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="formPermission.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formPermissionInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6204cfa9[name=authority,type=class org.workflow4people.Authority,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@29dd9285[class org.workflow4people.FormPermission,authority,class org.workflow4people.Authority,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@11be6f3c[false]}] -->
                            <td valign="top" class="name"><g:message code="formPermission.authority.label" default="Authority" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="authority" action="show" id="${formPermissionInstance?.authority?.id}">${formPermissionInstance?.authority?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6d78d53d[name=role,type=class org.workflow4people.Role,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@17f7cff1[class org.workflow4people.FormPermission,role,class org.workflow4people.Role,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@e74e382[false]}] -->
                            <td valign="top" class="name"><g:message code="formPermission.role.label" default="Role" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="role" action="show" id="${formPermissionInstance?.role?.id}">${formPermissionInstance?.role?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@36ca9a76[name=remark,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2f62d514[class org.workflow4people.FormPermission,remark,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1932c5a[true]}] -->
                            <td valign="top" class="name"><g:message code="formPermission.remark.label" default="Remark" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formPermissionInstance, field: "remark")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6544c984[name=form,type=class org.workflow4people.Form,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@70a2d0d[class org.workflow4people.FormPermission,form,class org.workflow4people.Form,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2d13b417[false]}] -->
                            <td valign="top" class="name"><g:message code="formPermission.form.label" default="Form" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="form" action="show" id="${formPermissionInstance?.form?.id}">${formPermissionInstance?.form?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${formPermissionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,formPermissionInstance:formPermissionInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
