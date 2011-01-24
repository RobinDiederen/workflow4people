
<%@ page import="org.workflow4people.FieldList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldList.label', default: 'FieldList')}" />
        <title><g:message code="fieldList.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    
                     	<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="fieldList.list.label" args="[entityName]" /></g:link></span>                		                        
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldListInstance:fieldListInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${fieldListInstance}">
            <div class="errors">
                <g:renderErrors bean="${fieldListInstance}" as="list" />
            </div>
            </g:hasErrors>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="parent"><g:message code="fieldList.parent.label" default="Parent" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldListInstance, field: 'parent', 'errors')}">
                                    <g:select name="parent.id" from="${org.workflow4people.Field.list()}" optionKey="id" value="${fieldListInstance?.parent?.id}" noSelection="['null': '']" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.parent.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="fieldList.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldListInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldListInstance?.name}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.name.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="namespace"><g:message code="fieldList.namespace.label" default="Namespace" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldListInstance, field: 'namespace', 'errors')}">
                                    <g:select name="namespace.id" from="${org.workflow4people.Namespace.list()}" optionKey="id" value="${fieldListInstance?.namespace?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.namespace.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="baseType"><g:message code="fieldList.baseType.label" default="Base Type" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldListInstance, field: 'baseType', 'errors')}">
                                    <g:select name="baseType.id" from="${org.workflow4people.BaseType.list()}" optionKey="id" value="${fieldListInstance?.baseType?.id}"  />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.baseType.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="label"><g:message code="fieldList.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldListInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldListInstance?.label}" />

                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldList.label.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="fieldList.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldListInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${fieldListInstance?.description}" />

                                    
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
