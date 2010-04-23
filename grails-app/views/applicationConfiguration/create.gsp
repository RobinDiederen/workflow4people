
<%@ page import="org.workflow4people.ApplicationConfiguration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationConfiguration.label', default: 'ApplicationConfiguration')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                     	<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>                		                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,applicationConfigurationInstance:applicationConfigurationInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${applicationConfigurationInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationConfigurationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="configKey"><g:message code="applicationConfiguration.configKey.label" default="Config Key" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationConfigurationInstance, field: 'configKey', 'errors')}">
                                    <g:textField name="configKey" value="${applicationConfigurationInstance?.configKey}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="configValue"><g:message code="applicationConfiguration.configValue.label" default="Config Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationConfigurationInstance, field: 'configValue', 'errors')}">
                                    <g:textField name="configValue" value="${applicationConfigurationInstance?.configValue}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                            
                    
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
