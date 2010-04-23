
<%@ page import="org.workflow4people.DocumentIndex" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndex.label', default: 'DocumentIndex')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="document" action="show" id="${documentIndexInstance?.document?.id}">&laquo;&nbsp;Back to Document ${documentIndexInstance?.document?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,documentIndexInstance:documentIndexInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${documentIndexInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentIndexInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${documentIndexInstance?.id}" />
                <g:hiddenField name="version" value="${documentIndexInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="documentIndex.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${documentIndexInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="value"><g:message code="documentIndex.value.label" default="Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentIndexInstance, field: 'value', 'errors')}">
                                    <g:textField name="value" value="${documentIndexInstance?.value}" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                        
                           	<g:hiddenField name="document.id" value="${documentIndexInstance?.document?.id}" />
                            
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="insertsave" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
