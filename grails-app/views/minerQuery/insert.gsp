
<%@ page import="org.workflow4people.MinerQuery" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'minerQuery.label', default: 'MinerQuery')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton">&laquo;&nbsp;<g:link class="awesome small blue button" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,minerQueryInstance:minerQueryInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${minerQueryInstance}">
            <div class="errors">
                <g:renderErrors bean="${minerQueryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${minerQueryInstance?.id}" />
                <g:hiddenField name="version" value="${minerQueryInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="minerQuery.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${minerQueryInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="minerQuery.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${minerQueryInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="minerQuery.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${minerQueryInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="explanationMessage"><g:message code="minerQuery.explanationMessage.label" default="Explanation Message" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'explanationMessage', 'errors')}">
                                    <g:textArea name="explanationMessage" cols="40" rows="5" value="${minerQueryInstance?.explanationMessage}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="query"><g:message code="minerQuery.query.label" default="Query" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'query', 'errors')}">
                                    <g:textArea name="query" cols="40" rows="5" value="${minerQueryInstance?.query}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="drilldownQuery"><g:message code="minerQuery.drilldownQuery.label" default="Drilldown Query" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'drilldownQuery', 'errors')}">
                                    <g:textArea name="drilldownQuery" cols="40" rows="5" value="${minerQueryInstance?.drilldownQuery}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="drilldownCountQuery"><g:message code="minerQuery.drilldownCountQuery.label" default="Drilldown Count Query" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'drilldownCountQuery', 'errors')}">
                                    <g:textArea name="drilldownCountQuery" cols="40" rows="5" value="${minerQueryInstance?.drilldownCountQuery}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="calculateTotals"><g:message code="minerQuery.calculateTotals.label" default="Calculate Totals" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: minerQueryInstance, field: 'calculateTotals', 'errors')}">
                                    <g:checkBox name="calculateTotals" value="${minerQueryInstance?.calculateTotals}" />
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
