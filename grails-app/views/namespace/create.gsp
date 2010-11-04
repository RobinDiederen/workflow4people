
<%@ page import="org.workflow4people.Namespace" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'namespace.label', default: 'Namespace')}" />
        <title><g:message code="namespace.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    
                     	<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="namespace.list.label" args="[entityName]" /></g:link></span>                		                        
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
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
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="prefix"><g:message code="namespace.prefix.label" default="Prefix" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: namespaceInstance, field: 'prefix', 'errors')}">
                                    <g:textField name="prefix" value="${namespaceInstance?.prefix}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'namespace.prefix.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                    <label for="uri"><g:message code="namespace.uri.label" default="Uri" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: namespaceInstance, field: 'uri', 'errors')}">
                                    <g:textField name="uri" value="${namespaceInstance?.uri}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'namespace.uri.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="filename"><g:message code="namespace.filename.label" default="Filename" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: namespaceInstance, field: 'filename', 'errors')}">
                                    <g:textField name="filename" value="${namespaceInstance?.filename}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'namespace.filename.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="generateXSDFile"><g:message code="namespace.generateXSDFile.label" default="Generate XSDF ile" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: namespaceInstance, field: 'generateXSDFile', 'errors')}">
                                    <g:checkBox name="generateXSDFile" value="${namespaceInstance?.generateXSDFile}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'namespace.generateXSDFile.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="includeSchema"><g:message code="namespace.includeSchema.label" default="Include Schema" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: namespaceInstance, field: 'includeSchema', 'errors')}">
                                    <g:textField name="includeSchema" value="${namespaceInstance?.includeSchema}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'namespace.includeSchema.help',default:'x')}" href="" >?</a>
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
