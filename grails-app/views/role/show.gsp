
<%@ page import="org.workflow4people.Role" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,roleInstance:roleInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5eb2c603[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="role.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5646d485[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@442a9403[class org.workflow4people.Role,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@475b73eb[false]}] -->
                            <td valign="top" class="name"><g:message code="role.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@45176de6[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5303a7a[class org.workflow4people.Role,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@214f223f[false]}] -->
                            <td valign="top" class="name"><g:message code="role.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1b4a8134[name=description,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@38688aeb[class org.workflow4people.Role,description,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5778673b[true]}] -->
                            <td valign="top" class="name"><g:message code="role.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@37aff6b1[name=roleAction,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@16cfb07[class org.workflow4people.Role,roleAction,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@19d4894c[true]}] -->
                            <td valign="top" class="name"><g:message code="role.roleAction.label" default="Role Action" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${roleInstance.roleAction}" var="r">
                                    <li><g:link controller="action" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${roleInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,roleInstance:roleInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
