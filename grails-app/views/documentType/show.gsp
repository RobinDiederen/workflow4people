
<%@ page import="org.workflow4people.DocumentType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentType.label', default: 'DocumentType')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,documentTypeInstance:documentTypeInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6add5d08[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="documentType.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentTypeInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6b06ef07[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1436eb76[class org.workflow4people.DocumentType,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@219c9a58[false]}] -->
                            <td valign="top" class="name"><g:message code="documentType.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentTypeInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@23bfa3a2[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7a8ff303[class org.workflow4people.DocumentType,description,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@9b88d2[false]}] -->
                            <td valign="top" class="name"><g:message code="documentType.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentTypeInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6333934d[name=descriptionTemplate,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4f0bd71c[class org.workflow4people.DocumentType,descriptionTemplate,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@125797cf[false]}] -->
                            <td valign="top" class="name"><g:message code="documentType.descriptionTemplate.label" default="Description Template" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentTypeInstance, field: "descriptionTemplate")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@34afa071[name=dateCreated,type=class java.util.Date,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@764e75bc[class org.workflow4people.DocumentType,dateCreated,class java.util.Date,{}] -->
                            <td valign="top" class="name"><g:message code="documentType.dateCreated.label" default="Date Created" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentTypeInstance?.dateCreated}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1913c652[name=lastUpdated,type=class java.util.Date,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@61413e5a[class org.workflow4people.DocumentType,lastUpdated,class java.util.Date,{}] -->
                            <td valign="top" class="name"><g:message code="documentType.lastUpdated.label" default="Last Updated" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentTypeInstance?.lastUpdated}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@264b898[name=documentIndexField,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@22930462[class org.workflow4people.DocumentType,documentIndexField,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6204cfa9[true]}] -->
                            <td valign="top" class="name"><g:message code="documentType.documentIndexField.label" default="Document Index Field" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${documentTypeInstance.documentIndexField}" var="d">
                                    <li><g:link controller="documentIndexField" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@29dd9285[name=form,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@11be6f3c[class org.workflow4people.DocumentType,form,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6d78d53d[true]}] -->
                            <td valign="top" class="name"><g:message code="documentType.form.label" default="Form" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${documentTypeInstance.form}" var="f">
                                    <li><g:link controller="form" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${documentTypeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,documentTypeInstance:documentTypeInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
