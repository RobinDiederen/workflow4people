
<%@ page import="org.workflow4people.ApplicationConfiguration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationConfiguration.label', default: 'ApplicationConfiguration')}" />
        <title><g:message code="applicationConfiguration.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="applicationConfiguration.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
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
                <g:hiddenField name="id" value="${applicationConfigurationInstance?.id}" />
                <g:hiddenField name="version" value="${applicationConfigurationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="configKey"><g:message code="applicationConfiguration.configKey.label" default="Config Key" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: applicationConfigurationInstance, field: 'configKey', 'errors')}">
                                    <g:textField name="configKey" value="${applicationConfigurationInstance?.configKey}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'applicationConfiguration.configKey.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="configValue"><g:message code="applicationConfiguration.configValue.label" default="Config Value" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: applicationConfigurationInstance, field: 'configValue', 'errors')}">
                                    <g:textField name="configValue" value="${applicationConfigurationInstance?.configValue}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'applicationConfiguration.configValue.help',default:'x')}" href="" >?</a>                                    
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
