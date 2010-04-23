
<%@ page import="org.workflow4people.Feature" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feature.label', default: 'Feature')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,featureInstance:featureInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2e796ff[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="feature.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featureInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5dc6bb75[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@223d2e6c[class org.workflow4people.Feature,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5eb2c603[false]}] -->
                            <td valign="top" class="name"><g:message code="feature.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featureInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5646d485[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@442a9403[class org.workflow4people.Feature,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@475b73eb[false]}] -->
                            <td valign="top" class="name"><g:message code="feature.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featureInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@45176de6[name=description,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5303a7a[class org.workflow4people.Feature,description,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@214f223f[true]}] -->
                            <td valign="top" class="name"><g:message code="feature.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featureInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${featureInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,featureInstance:featureInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="feature.featurePermission.label" default="Feature Permission" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="featurePermission" action="create" params="['feature.id': featureInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${featureInstance.featurePermission}" var="f">
                                <tr>
                                <td>${f?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="featurePermission" action="show" id="${f.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="featurePermission" action="edit" id="${f.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="featurePermission" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
