
<%@ page import="org.workflow4people.Action" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'action.label', default: 'Action')}" />
        <title><g:message code="action.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="action.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,actionInstance:actionInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${actionInstance}">
            <div class="errors">
                <g:renderErrors bean="${actionInstance}" as="list" />
            </div>
            </g:hasErrors>
                <g:hiddenField name="id" value="${actionInstance?.id}" />
                <g:hiddenField name="version" value="${actionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="action.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: actionInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${actionInstance?.name}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'action.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="action.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: actionInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${actionInstance?.title}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'action.title.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="action.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: actionInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${actionInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'action.description.help',default:'x')}" href="" >?</a>                                    
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
