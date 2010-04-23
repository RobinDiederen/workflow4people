
<%@ page import="org.workflow4people.Holiday" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,holidayInstance:holidayInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@77e72cae[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="holiday.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: holidayInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@9fa0f19[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7ff5376c[class org.workflow4people.Holiday,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@3c09d515[false]}] -->
                            <td valign="top" class="name"><g:message code="holiday.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: holidayInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2984747e[name=fromDate,type=class java.util.Date,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@36fc117d[class org.workflow4people.Holiday,fromDate,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5ee041be[false]}] -->
                            <td valign="top" class="name"><g:message code="holiday.fromDate.label" default="From Date" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${holidayInstance?.fromDate}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@54fc519b[name=toDate,type=class java.util.Date,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@151c2b4[class org.workflow4people.Holiday,toDate,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1ec5b819[false]}] -->
                            <td valign="top" class="name"><g:message code="holiday.toDate.label" default="To Date" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${holidayInstance?.toDate}" /></td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${holidayInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,holidayInstance:holidayInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
