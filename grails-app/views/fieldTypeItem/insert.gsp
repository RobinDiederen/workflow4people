
<%@ page import="org.workflow4people.FieldTypeItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldTypeItem.label', default: 'FieldTypeItem')}" />
        <title><g:message code="fieldTypeItem.insert.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldType" action="show" id="${fieldTypeItemInstance?.fieldType?.id}">&laquo;&nbsp; Field Type ${fieldTypeItemInstance?.fieldType?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
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
            <g:form method="post" >
                <g:hiddenField name="id" value="${fieldTypeItemInstance?.id}" />
                <g:hiddenField name="version" value="${fieldTypeItemInstance?.version}" />
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
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="insertsave" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
