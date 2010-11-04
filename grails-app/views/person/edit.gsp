
<%@ page import="org.workflow4people.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="person.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="person.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,personInstance:personInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${personInstance}">
            <div class="errors">
                <g:renderErrors bean="${personInstance}" as="list" />
            </div>
            </g:hasErrors>
                <g:hiddenField name="id" value="${personInstance?.id}" />
                <g:hiddenField name="version" value="${personInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="username"><g:message code="person.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: personInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${personInstance?.username}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.username.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="userRealName"><g:message code="person.userRealName.label" default="User Real Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: personInstance, field: 'userRealName', 'errors')}">
                                    <g:textField name="userRealName" value="${personInstance?.userRealName}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.userRealName.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="familyName"><g:message code="person.familyName.label" default="Family Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: personInstance, field: 'familyName', 'errors')}">
                                    <g:textField name="familyName" value="${personInstance?.familyName}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.familyName.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="givenName"><g:message code="person.givenName.label" default="Given Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: personInstance, field: 'givenName', 'errors')}">
                                    <g:textField name="givenName" value="${personInstance?.givenName}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.givenName.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="person.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: personInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${personInstance?.email}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.email.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="emailShow"><g:message code="person.emailShow.label" default="Email Show" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'emailShow', 'errors')}">
                                    <g:checkBox name="emailShow" value="${personInstance?.emailShow}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.emailShow.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="enabled"><g:message code="person.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${personInstance?.enabled}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.enabled.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="passwd"><g:message code="person.passwd.label" default="Passwd" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: personInstance, field: 'passwd', 'errors')}">
                                    <g:passwordField name="passwd" value="${personInstance?.passwd}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.passwd.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="authorities"><g:message code="person.authorities.label" default="Authorities" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'authorities', 'errors')}">
                                    <g:select class="multiselect" name="authorities" from="${org.workflow4people.Authority.list(sort:'authority')}" multiple="yes" optionKey="id" value="${personInstance?.authorities}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'person.authorities.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="person.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${personInstance?.description}" />

                                                                        
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                        
                        
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
                    <g:hiddenField name="q" value="${params.q}" />
                        
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>                    
                </div>
            </g:form>
        </div>
    </body>
</html>
