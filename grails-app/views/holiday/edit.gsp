
<%@ page import="org.workflow4people.Holiday" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,holidayInstance:holidayInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${holidayInstance}">
            <div class="errors">
                <g:renderErrors bean="${holidayInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${holidayInstance?.id}" />
                <g:hiddenField name="version" value="${holidayInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="holiday.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: holidayInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${holidayInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fromDate"><g:message code="holiday.fromDate.label" default="From Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: holidayInstance, field: 'fromDate', 'errors')}">
                                    <input class="datepicker" type="text" name="fromDate" value="${formatDate(date:holidayInstance?.fromDate,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="toDate"><g:message code="holiday.toDate.label" default="To Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: holidayInstance, field: 'toDate', 'errors')}">
                                    <input class="datepicker" type="text" name="toDate" value="${formatDate(date:holidayInstance?.toDate,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
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
