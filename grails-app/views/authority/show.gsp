
<%@ page import="org.workflow4people.Authority" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,authorityInstance:authorityInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@ab5423f[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="authority.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: authorityInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5f47cab0[name=authority,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@624c19ae[class org.workflow4people.Authority,authority,class java.lang.String,{blank=org.codehaus.groovy.grails.validation.BlankConstraint@722a20ec[false], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2bd7a082[false]}] -->
                            <td valign="top" class="name"><g:message code="authority.authority.label" default="Authority" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: authorityInstance, field: "authority")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@596acd4a[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@72cbe322[class org.workflow4people.Authority,description,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@27ad080f[false]}] -->
                            <td valign="top" class="name"><g:message code="authority.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: authorityInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@63c99db7[name=authorityType,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@49918c8f[class org.workflow4people.Authority,authorityType,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@72a32604[false]}] -->
                            <td valign="top" class="name"><g:message code="authority.authorityType.label" default="Authority Type" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: authorityInstance, field: "authorityType")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4d50c5f5[name=people,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=true,association-type=many-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@71f47f7a[class org.workflow4people.Authority,people,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6add5d08[true]}] -->
                            <td valign="top" class="name"><g:message code="authority.people.label" default="People" /></td>
                         
                            
	                             <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${authorityInstance.people}" var="p">
                                    <li><g:link controller="person" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${authorityInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,authorityInstance:authorityInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
