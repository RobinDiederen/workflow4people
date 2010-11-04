
<%@ page import="org.workflow4people.Namespace" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'namespace.label', default: 'Namespace')}" />
        <title><g:message code="namespace.insert.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton">&laquo;&nbsp;<g:link class="awesome small blue button" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,namespaceInstance:namespaceInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${namespaceInstance}">
            <div class="errors">
                <g:renderErrors bean="${namespaceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${namespaceInstance?.id}" />
                <g:hiddenField name="version" value="${namespaceInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="prefix"><g:message code="namespace.prefix.label" default="Prefix" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: namespaceInstance, field: 'prefix', 'errors')}">
                                    <g:textField name="prefix" value="${namespaceInstance?.prefix}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="uri"><g:message code="namespace.uri.label" default="Uri" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: namespaceInstance, field: 'uri', 'errors')}">
                                    <g:textField name="uri" value="${namespaceInstance?.uri}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="filename"><g:message code="namespace.filename.label" default="Filename" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: namespaceInstance, field: 'filename', 'errors')}">
                                    <g:textField name="filename" value="${namespaceInstance?.filename}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="generateXSDFile"><g:message code="namespace.generateXSDFile.label" default="Generate XSDF ile" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: namespaceInstance, field: 'generateXSDFile', 'errors')}">
                                    <g:checkBox name="generateXSDFile" value="${namespaceInstance?.generateXSDFile}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="includeSchema"><g:message code="namespace.includeSchema.label" default="Include Schema" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: namespaceInstance, field: 'includeSchema', 'errors')}">
                                    <g:textField name="includeSchema" value="${namespaceInstance?.includeSchema}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="importSchema"><g:message code="namespace.importSchema.label" default="Import Schema" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: namespaceInstance, field: 'importSchema', 'errors')}">
                                    <g:select class="multiselect" name="importSchema" from="${org.workflow4people.Namespace.list(sort:'prefix')}" multiple="yes" optionKey="id" value="${namespaceInstance?.importSchema}" />

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
