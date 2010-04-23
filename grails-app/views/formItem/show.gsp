
<%@ page import="org.workflow4people.FormItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formItem.label', default: 'FormItem')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="form" action="show" id="${formItemInstance?.form?.id}">&laquo;&nbsp;Back to Form ${formItemInstance?.form?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,formItemInstance:formItemInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6d78d53d[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="formItem.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formItemInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1c047338[name=position,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@68286fe6[class org.workflow4people.FormItem,position,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@36ca9a76[false]}] -->
                            <td valign="top" class="name"><g:message code="formItem.position.label" default="Position" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formItemInstance, field: "position")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2f62d514[name=field,type=class org.workflow4people.Field,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1932c5a[class org.workflow4people.FormItem,field,class org.workflow4people.Field,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6544c984[false]}] -->
                            <td valign="top" class="name"><g:message code="formItem.field.label" default="Field" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="field" action="show" id="${formItemInstance?.field?.id}">${formItemInstance?.field?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@70a2d0d[name=baseXpath,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2d13b417[class org.workflow4people.FormItem,baseXpath,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6894691f[true]}] -->
                            <td valign="top" class="name"><g:message code="formItem.baseXpath.label" default="Base Xpath" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formItemInstance, field: "baseXpath")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@709c4f85[name=readonly,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2628de85[class org.workflow4people.FormItem,readonly,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@45290155[false]}] -->
                            <td valign="top" class="name"><g:message code="formItem.readonly.label" default="Readonly" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${formItemInstance?.readonly}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@71696ec[name=form,type=class org.workflow4people.Form,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5c0e6396[class org.workflow4people.FormItem,form,class org.workflow4people.Form,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@34ac3c11[false]}] -->
                            <td valign="top" class="name"><g:message code="formItem.form.label" default="Form" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="form" action="show" id="${formItemInstance?.form?.id}">${formItemInstance?.form?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${formItemInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,formItemInstance:formItemInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
