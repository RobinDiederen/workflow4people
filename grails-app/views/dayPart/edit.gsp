
<%@ page import="org.workflow4people.DayPart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dayPart.label', default: 'DayPart')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
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
            <g:form method="post" >
                <g:hiddenField name="id" value="${dayPartInstance?.id}" />
                <g:hiddenField name="version" value="${dayPartInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dayName"><g:message code="dayPart.dayName.label" default="Day Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: dayPartInstance, field: 'dayName', 'errors')}">
                                    <g:select name="dayName" from="${dayPartInstance.constraints.dayName.inList}" value="${dayPartInstance?.dayName}" valueMessagePrefix="dayPart.dayName"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fromTime"><g:message code="dayPart.fromTime.label" default="From Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: dayPartInstance, field: 'fromTime', 'errors')}">
                                    <g:textField name="fromTime" value="${dayPartInstance?.fromTime}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="toTime"><g:message code="dayPart.toTime.label" default="To Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: dayPartInstance, field: 'toTime', 'errors')}">
                                    <g:textField name="toTime" value="${dayPartInstance?.toTime}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="position"><g:message code="dayPart.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: dayPartInstance, field: 'position', 'errors')}">
                                    <g:textField name="position" value="${fieldValue(bean: dayPartInstance, field: 'position')}" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
