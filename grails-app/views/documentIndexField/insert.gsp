
<%@ page import="org.workflow4people.DocumentIndexField" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndexField.label', default: 'DocumentIndexField')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton">&laquo;&nbsp;<g:link class="awesome small blue button" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
            <g:hasErrors bean="${documentIndexFieldInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentIndexFieldInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${documentIndexFieldInstance?.id}" />
                <g:hiddenField name="version" value="${documentIndexFieldInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="documentIndexField.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${documentIndexFieldInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="documentIndexField.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${documentIndexFieldInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="documentIndexField.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${documentIndexFieldInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="xpath"><g:message code="documentIndexField.xpath.label" default="Xpath" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'xpath', 'errors')}">
                                    <g:textField name="xpath" value="${documentIndexFieldInstance?.xpath}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="publish"><g:message code="documentIndexField.publish.label" default="Publish" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'publish', 'errors')}">
                                    <g:checkBox name="publish" value="${documentIndexFieldInstance?.publish}" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="insertsave" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
