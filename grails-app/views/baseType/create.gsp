
<%@ page import="org.workflow4people.BaseType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'baseType.label', default: 'BaseType')}" />
        <title><g:message code="baseType.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    
                     	<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="baseType.list.label" args="[entityName]" /></g:link></span>                		                        
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,baseTypeInstance:baseTypeInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${baseTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${baseTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="baseType.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: baseTypeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${baseTypeInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'baseType.name.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="baseType.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: baseTypeInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${baseTypeInstance?.description}" />

                                    
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
