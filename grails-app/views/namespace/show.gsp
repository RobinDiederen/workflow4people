
<%@ page import="org.workflow4people.Namespace" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'namespace.label', default: 'Namespace')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,namespaceInstance:namespaceInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@36fc117d[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="namespace.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: namespaceInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5ee041be[name=prefix,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@54fc519b[class org.workflow4people.Namespace,prefix,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@151c2b4[false]}] -->
                            <td valign="top" class="name"><g:message code="namespace.prefix.label" default="Prefix" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: namespaceInstance, field: "prefix")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3cca3147[name=uri,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7e694b7e[class org.workflow4people.Namespace,uri,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@32db7e08[false]}] -->
                            <td valign="top" class="name"><g:message code="namespace.uri.label" default="Uri" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: namespaceInstance, field: "uri")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@682f594d[name=filename,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7c9003aa[class org.workflow4people.Namespace,filename,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@52e0cdc9[false]}] -->
                            <td valign="top" class="name"><g:message code="namespace.filename.label" default="Filename" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: namespaceInstance, field: "filename")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@24e671a1[name=generateXSDFile,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@152e13f4[class org.workflow4people.Namespace,generateXSDFile,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4200309[false]}] -->
                            <td valign="top" class="name"><g:message code="namespace.generateXSDFile.label" default="Generate XSDF ile" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${namespaceInstance?.generateXSDFile}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@51a745fc[name=includeSchema,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3ce3cd45[class org.workflow4people.Namespace,includeSchema,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@fb98c3e[true]}] -->
                            <td valign="top" class="name"><g:message code="namespace.includeSchema.label" default="Include Schema" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: namespaceInstance, field: "includeSchema")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5ea64282[name=importSchema,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@75589559[class org.workflow4people.Namespace,importSchema,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@ab5423f[true]}] -->
                            <td valign="top" class="name"><g:message code="namespace.importSchema.label" default="Import Schema" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${namespaceInstance.importSchema}" var="i">
                                    <li><g:link controller="namespace" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${namespaceInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,namespaceInstance:namespaceInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
