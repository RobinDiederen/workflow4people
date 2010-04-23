
<%@ page import="org.workflow4people.FeaturePermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'featurePermission.label', default: 'FeaturePermission')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="feature" action="show" id="${featurePermissionInstance?.feature?.id}">&laquo;&nbsp;Back to Feature ${featurePermissionInstance?.feature?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,featurePermissionInstance:featurePermissionInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@72cbe322[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="featurePermission.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featurePermissionInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@27ad080f[name=authority,type=class org.workflow4people.Authority,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@50ec2522[class org.workflow4people.FeaturePermission,authority,class org.workflow4people.Authority,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@3f7a04af[false]}] -->
                            <td valign="top" class="name"><g:message code="featurePermission.authority.label" default="Authority" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="authority" action="show" id="${featurePermissionInstance?.authority?.id}">${featurePermissionInstance?.authority?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@72a32604[name=role,type=class org.workflow4people.Role,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@35150b68[class org.workflow4people.FeaturePermission,role,class org.workflow4people.Role,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@789ff411[false]}] -->
                            <td valign="top" class="name"><g:message code="featurePermission.role.label" default="Role" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="role" action="show" id="${featurePermissionInstance?.role?.id}">${featurePermissionInstance?.role?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4d50c5f5[name=remark,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@71f47f7a[class org.workflow4people.FeaturePermission,remark,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6add5d08[true]}] -->
                            <td valign="top" class="name"><g:message code="featurePermission.remark.label" default="Remark" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featurePermissionInstance, field: "remark")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6b06ef07[name=feature,type=class org.workflow4people.Feature,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1436eb76[class org.workflow4people.FeaturePermission,feature,class org.workflow4people.Feature,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@219c9a58[false]}] -->
                            <td valign="top" class="name"><g:message code="featurePermission.feature.label" default="Feature" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="feature" action="show" id="${featurePermissionInstance?.feature?.id}">${featurePermissionInstance?.feature?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${featurePermissionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,featurePermissionInstance:featurePermissionInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
