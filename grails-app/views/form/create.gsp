
<%@ page import="org.workflow4people.Form" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
        <title><g:message code="form.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="workflowDefinition" action="show" id="${formInstance?.workflow?.id}">&laquo;&nbsp; ${formInstance?.workflow?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,formInstance:formInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${formInstance}">
            <div class="errors">
                <g:renderErrors bean="${formInstance}" as="list" />
            </div>
            </g:hasErrors>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="form.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${formInstance?.name}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.name.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="title"><g:message code="form.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${formInstance?.title}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.title.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="form.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: formInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${formInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.description.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="explanationMessage"><g:message code="form.explanationMessage.label" default="Explanation Message" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: formInstance, field: 'explanationMessage', 'errors')}">
                                    <g:textArea name="explanationMessage" cols="40" rows="5" value="${formInstance?.explanationMessage}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.explanationMessage.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="confirmationMessage"><g:message code="form.confirmationMessage.label" default="Confirmation Message" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: formInstance, field: 'confirmationMessage', 'errors')}">
                                    <g:textArea name="confirmationMessage" cols="40" rows="5" value="${formInstance?.confirmationMessage}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.confirmationMessage.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="template"><g:message code="form.template.label" default="Template" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: formInstance, field: 'template', 'errors')}">
                                    <g:textField name="template" value="${formInstance?.template}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.template.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="formAction"><g:message code="form.formAction.label" default="Form Action" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: formInstance, field: 'formAction', 'errors')}">
                                    <g:select name="formAction.id" from="${org.workflow4people.Action.list()}" optionKey="id" value="${formInstance?.formAction?.id}"  />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'form.formAction.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                                                    
                           	<g:hiddenField name="workflow.id" value="${formInstance?.workflow?.id}" />                            
                                
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
					<g:hiddenField name="q" value="${params.q}" />
                    
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
