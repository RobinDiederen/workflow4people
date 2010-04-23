
<%@ page import="org.workflow4people.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,personInstance:personInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@272f15b0[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="person.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@77e72cae[name=username,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6a269101[class org.workflow4people.Person,username,class java.lang.String,{blank=org.codehaus.groovy.grails.validation.BlankConstraint@9fa0f19[false], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7ff5376c[false]}] -->
                            <td valign="top" class="name"><g:message code="person.username.label" default="Username" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "username")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3c09d515[name=userRealName,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2984747e[class org.workflow4people.Person,userRealName,class java.lang.String,{blank=org.codehaus.groovy.grails.validation.BlankConstraint@36fc117d[false], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5ee041be[false]}] -->
                            <td valign="top" class="name"><g:message code="person.userRealName.label" default="User Real Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "userRealName")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@54fc519b[name=familyName,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@151c2b4[class org.workflow4people.Person,familyName,class java.lang.String,{blank=org.codehaus.groovy.grails.validation.BlankConstraint@1ec5b819[false], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@46b98117[false]}] -->
                            <td valign="top" class="name"><g:message code="person.familyName.label" default="Family Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "familyName")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3cca3147[name=givenName,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7e694b7e[class org.workflow4people.Person,givenName,class java.lang.String,{blank=org.codehaus.groovy.grails.validation.BlankConstraint@32db7e08[false], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@682f594d[false]}] -->
                            <td valign="top" class="name"><g:message code="person.givenName.label" default="Given Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "givenName")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@24e671a1[name=email,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@152e13f4[class org.workflow4people.Person,email,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4200309[false]}] -->
                            <td valign="top" class="name"><g:message code="person.email.label" default="Email" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "email")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@fb98c3e[name=emailShow,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5ea64282[class org.workflow4people.Person,emailShow,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@75589559[false]}] -->
                            <td valign="top" class="name"><g:message code="person.emailShow.label" default="Email Show" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${personInstance?.emailShow}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@ab5423f[name=enabled,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2103b97[class org.workflow4people.Person,enabled,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@77b8378f[false]}] -->
                            <td valign="top" class="name"><g:message code="person.enabled.label" default="Enabled" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${personInstance?.enabled}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5f47cab0[name=passwd,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@624c19ae[class org.workflow4people.Person,passwd,class java.lang.String,{blank=org.codehaus.groovy.grails.validation.BlankConstraint@722a20ec[false], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2bd7a082[false]}] -->
                            <td valign="top" class="name"><g:message code="person.passwd.label" default="Passwd" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "passwd")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@596acd4a[name=authorities,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=true,association-type=many-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@72cbe322[class org.workflow4people.Person,authorities,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@27ad080f[true]}] -->
                            <td valign="top" class="name"><g:message code="person.authorities.label" default="Authorities" /></td>
                         
                            
	                             <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${personInstance.authorities}" var="a">
                                    <li><g:link controller="authority" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@50ec2522[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3f7a04af[class org.workflow4people.Person,description,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@63c99db7[false]}] -->
                            <td valign="top" class="name"><g:message code="person.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: personInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${personInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,personInstance:personInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
