
<%@ page import="org.workflow4people.DayPart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dayPart.label', default: 'DayPart')}" />
        <title><g:message code="dayPart.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    
                     	<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="dayPart.list.label" args="[entityName]" /></g:link></span>                		                        
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,dayPartInstance:dayPartInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${dayPartInstance}">
            <div class="errors">
                <g:renderErrors bean="${dayPartInstance}" as="list" />
            </div>
            </g:hasErrors>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="position"><g:message code="dayPart.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: dayPartInstance, field: 'position', 'errors')}">
                                    <g:textField name="position" value="${fieldValue(bean: dayPartInstance, field: 'position')}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'dayPart.position.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="dayName"><g:message code="dayPart.dayName.label" default="Day Name" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: dayPartInstance, field: 'dayName', 'errors')}">
                                    <g:select name="dayName" from="${dayPartInstance.constraints.dayName.inList}" value="${dayPartInstance?.dayName}" valueMessagePrefix="dayPart.dayName.value"  />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'dayPart.dayName.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="fromTime"><g:message code="dayPart.fromTime.label" default="From Time" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: dayPartInstance, field: 'fromTime', 'errors')}">
                                    <g:textField name="fromTime" value="${dayPartInstance?.fromTime}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'dayPart.fromTime.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="toTime"><g:message code="dayPart.toTime.label" default="To Time" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: dayPartInstance, field: 'toTime', 'errors')}">
                                    <g:textField name="toTime" value="${dayPartInstance?.toTime}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'dayPart.toTime.help',default:'x')}" href="" >?</a>
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
