
<%@ page import="org.workflow4people.DocumentIndexField" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndexField.label', default: 'DocumentIndexField')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,documentIndexFieldInstance:documentIndexFieldInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3ea948c2[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="documentIndexField.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexFieldInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@39165e21[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6b7de5ce[class org.workflow4people.DocumentIndexField,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@167a6e84[false]}] -->
                            <td valign="top" class="name"><g:message code="documentIndexField.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexFieldInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3feda7a3[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@b98df1f[class org.workflow4people.DocumentIndexField,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6160722b[false]}] -->
                            <td valign="top" class="name"><g:message code="documentIndexField.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexFieldInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2e796ff[name=description,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@326a40d6[class org.workflow4people.DocumentIndexField,description,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5dc6bb75[true]}] -->
                            <td valign="top" class="name"><g:message code="documentIndexField.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexFieldInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2ae61f87[name=xpath,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6a1fee11[class org.workflow4people.DocumentIndexField,xpath,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5646d485[false]}] -->
                            <td valign="top" class="name"><g:message code="documentIndexField.xpath.label" default="Xpath" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexFieldInstance, field: "xpath")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@442a9403[name=publish,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@475b73eb[class org.workflow4people.DocumentIndexField,publish,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@45176de6[false]}] -->
                            <td valign="top" class="name"><g:message code="documentIndexField.publish.label" default="Publish" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${documentIndexFieldInstance?.publish}" /></td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${documentIndexFieldInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,documentIndexFieldInstance:documentIndexFieldInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
