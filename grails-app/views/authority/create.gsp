
<%@ page import="org.workflow4people.Authority" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
        <title><g:message code="authority.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    
                     	<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="authority.list.label" args="[entityName]" /></g:link></span>                		                        
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,authorityInstance:authorityInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${authorityInstance}">
            <div class="errors">
                <g:renderErrors bean="${authorityInstance}" as="list" />
            </div>
            </g:hasErrors>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="authority"><g:message code="authority.authority.label" default="Authority" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: authorityInstance, field: 'authority', 'errors')}">
                                    <g:textField name="authority" value="${authorityInstance?.authority}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'authority.authority.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="authority.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: authorityInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${authorityInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'authority.description.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="authorityType"><g:message code="authority.authorityType.label" default="Authority Type" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: authorityInstance, field: 'authorityType', 'errors')}">
                                    <g:textField name="authorityType" value="${authorityInstance?.authorityType}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'authority.authorityType.help',default:'x')}" href="" >?</a>
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
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
