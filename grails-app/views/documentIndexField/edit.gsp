
<%@ page import="org.workflow4people.DocumentIndexField" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndexField.label', default: 'DocumentIndexField')}" />
        <title><g:message code="documentIndexField.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="documentIndexField.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
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
                <g:hiddenField name="id" value="${documentIndexFieldInstance?.id}" />
                <g:hiddenField name="version" value="${documentIndexFieldInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="documentIndexField.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentIndexFieldInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${documentIndexFieldInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'documentIndexField.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="documentIndexField.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentIndexFieldInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${documentIndexFieldInstance?.title}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'documentIndexField.title.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="documentIndexField.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${documentIndexFieldInstance?.description}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'documentIndexField.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="xpath"><g:message code="documentIndexField.xpath.label" default="Xpath" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentIndexFieldInstance, field: 'xpath', 'errors')}">
                                    <g:textField name="xpath" value="${documentIndexFieldInstance?.xpath}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'documentIndexField.xpath.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="publish"><g:message code="documentIndexField.publish.label" default="Publish" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexFieldInstance, field: 'publish', 'errors')}">
                                    <g:checkBox name="publish" value="${documentIndexFieldInstance?.publish}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'documentIndexField.publish.help',default:'x')}" href="" >?</a>                                    
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
