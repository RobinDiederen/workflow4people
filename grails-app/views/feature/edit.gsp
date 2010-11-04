
<%@ page import="org.workflow4people.Feature" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feature.label', default: 'Feature')}" />
        <title><g:message code="feature.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="feature.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,featureInstance:featureInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${featureInstance}">
            <div class="errors">
                <g:renderErrors bean="${featureInstance}" as="list" />
            </div>
            </g:hasErrors>
                <g:hiddenField name="id" value="${featureInstance?.id}" />
                <g:hiddenField name="version" value="${featureInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="feature.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: featureInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${featureInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'feature.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="feature.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: featureInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${featureInstance?.title}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'feature.title.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="feature.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: featureInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${featureInstance?.description}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'feature.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="featurePermission"><g:message code="feature.featurePermission.label" default="Feature Permission" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: featureInstance, field: 'featurePermission', 'errors')}">
                                    
<ul>
<g:each in="${featureInstance?.featurePermission?}" var="f">
    <li><g:link controller="featurePermission" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="featurePermission" action="create" params="['feature.id': featureInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'featurePermission.label', default: 'FeaturePermission')])}</g:link>


                                                                        
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
