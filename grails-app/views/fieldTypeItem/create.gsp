
<%@ page import="org.workflow4people.FieldTypeItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldTypeItem.label', default: 'FieldTypeItem')}" />
        <title><g:message code="fieldTypeItem.create.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form action="save" method="post" >
        
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldType" action="show" id="${fieldTypeItemInstance?.fieldType?.id}">&laquo;&nbsp; ${fieldTypeItemInstance?.fieldType?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldTypeItemInstance:fieldTypeItemInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${fieldTypeItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${fieldTypeItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="itemPosition"><g:message code="fieldTypeItem.itemPosition.label" default="Item Position" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldTypeItemInstance, field: 'itemPosition', 'errors')}">
                                    <g:textField name="itemPosition" value="${fieldValue(bean: fieldTypeItemInstance, field: 'itemPosition')}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldTypeItem.itemPosition.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="label"><g:message code="fieldTypeItem.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldTypeItemInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldTypeItemInstance?.label}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldTypeItem.label.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                    <label for="value"><g:message code="fieldTypeItem.value.label" default="Value" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldTypeItemInstance, field: 'value', 'errors')}">
                                    <g:textField name="value" value="${fieldTypeItemInstance?.value}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldTypeItem.value.help',default:'x')}" href="" >?</a>
                                </td>
                            </tr>
                        
                            <tr class="prop null">
                                <td valign="top" class="name">
                                    <label for="fieldType"><g:message code="fieldTypeItem.fieldType.label" default="Field Type" /></label>
                                </td>
                                <td valign="top" class="value null ${hasErrors(bean: fieldTypeItemInstance, field: 'fieldType', 'errors')}">
                                    <g:select name="fieldType.id" from="${org.workflow4people.FieldType.list()}" optionKey="id" value="${fieldTypeItemInstance?.fieldType?.id}"  />
                                    
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
