
<%@ page import="org.workflow4people.FieldTypeItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldTypeItem.label', default: 'FieldTypeItem')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldType" action="show" id="${fieldTypeItemInstance?.fieldType?.id}">&laquo;&nbsp;Back to Field Type ${fieldTypeItemInstance?.fieldType?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
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
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="itemPosition"><g:message code="fieldTypeItem.itemPosition.label" default="Item Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeItemInstance, field: 'itemPosition', 'errors')}">
                                    <g:textField name="itemPosition" value="${fieldValue(bean: fieldTypeItemInstance, field: 'itemPosition')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="label"><g:message code="fieldTypeItem.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeItemInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldTypeItemInstance?.label}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="value"><g:message code="fieldTypeItem.value.label" default="Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeItemInstance, field: 'value', 'errors')}">
                                    <g:textField name="value" value="${fieldTypeItemInstance?.value}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldType"><g:message code="fieldTypeItem.fieldType.label" default="Field Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeItemInstance, field: 'fieldType', 'errors')}">
                                    <g:select name="fieldType.id" from="${org.workflow4people.FieldType.list()}" optionKey="id" value="${fieldTypeItemInstance?.fieldType?.id}"  />
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
