
<%@ page import="org.workflow4people.MinerQuery" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'minerQuery.label', default: 'MinerQuery')}" />
        <title><g:message code="minerQuery.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    
                     	<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="minerQuery.list.label" args="[entityName]" /></g:link></span>                		                        
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
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
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="minerQuery.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: minerQueryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${minerQueryInstance?.name}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.name.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="title"><g:message code="minerQuery.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: minerQueryInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${minerQueryInstance?.title}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.title.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="minerQuery.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: minerQueryInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${minerQueryInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.description.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="explanationMessage"><g:message code="minerQuery.explanationMessage.label" default="Explanation Message" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: minerQueryInstance, field: 'explanationMessage', 'errors')}">
                                    <g:textArea name="explanationMessage" cols="40" rows="5" value="${minerQueryInstance?.explanationMessage}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.explanationMessage.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="query"><g:message code="minerQuery.query.label" default="Query" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: minerQueryInstance, field: 'query', 'errors')}">
                                    <g:textArea name="query" cols="40" rows="5" value="${minerQueryInstance?.query}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.query.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="drilldownQuery"><g:message code="minerQuery.drilldownQuery.label" default="Drilldown Query" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: minerQueryInstance, field: 'drilldownQuery', 'errors')}">
                                    <g:textArea name="drilldownQuery" cols="40" rows="5" value="${minerQueryInstance?.drilldownQuery}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.drilldownQuery.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="drilldownCountQuery"><g:message code="minerQuery.drilldownCountQuery.label" default="Drilldown Count Query" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: minerQueryInstance, field: 'drilldownCountQuery', 'errors')}">
                                    <g:textArea name="drilldownCountQuery" cols="40" rows="5" value="${minerQueryInstance?.drilldownCountQuery}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.drilldownCountQuery.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="calculateTotals"><g:message code="minerQuery.calculateTotals.label" default="Calculate Totals" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: minerQueryInstance, field: 'calculateTotals', 'errors')}">
                                    <g:checkBox name="calculateTotals" value="${minerQueryInstance?.calculateTotals}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'minerQuery.calculateTotals.help',default:'x')}" href="" >?</a>
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
