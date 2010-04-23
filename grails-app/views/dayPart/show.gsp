
<%@ page import="org.workflow4people.DayPart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dayPart.label', default: 'DayPart')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,dayPartInstance:dayPartInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@37aff6b1[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="dayPart.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: dayPartInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@19d4894c[name=dayName,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5081e9d3[class org.workflow4people.DayPart,dayName,class java.lang.String,{inList=org.codehaus.groovy.grails.validation.InListConstraint@11e44f0[[Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6a3fe922[false]}] -->
                            <td valign="top" class="name"><g:message code="dayPart.dayName.label" default="Day Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: dayPartInstance, field: "dayName")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@438e9e9[name=fromTime,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3484c229[class org.workflow4people.DayPart,fromTime,class java.lang.String,{matches=org.codehaus.groovy.grails.validation.MatchesConstraint@77e72cae[[0-9]{2}:[0-9]{2}], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6a269101[false]}] -->
                            <td valign="top" class="name"><g:message code="dayPart.fromTime.label" default="From Time" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: dayPartInstance, field: "fromTime")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@9fa0f19[name=toTime,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7ff5376c[class org.workflow4people.DayPart,toTime,class java.lang.String,{matches=org.codehaus.groovy.grails.validation.MatchesConstraint@3c09d515[[0-9]{2}:[0-9]{2}], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2984747e[false]}] -->
                            <td valign="top" class="name"><g:message code="dayPart.toTime.label" default="To Time" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: dayPartInstance, field: "toTime")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@54fc519b[name=position,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@151c2b4[class org.workflow4people.DayPart,position,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1ec5b819[false]}] -->
                            <td valign="top" class="name"><g:message code="dayPart.position.label" default="Position" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: dayPartInstance, field: "position")}</td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${dayPartInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,dayPartInstance:dayPartInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
