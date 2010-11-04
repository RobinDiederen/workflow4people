
<%@ page import="org.workflow4people.FormItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'formItem.label', default: 'FormItem')}" />
        <title><g:message code="formItem.insert.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="form" action="show" id="${formItemInstance?.form?.id}">&laquo;&nbsp; Form ${formItemInstance?.form?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,formItemInstance:formItemInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${formItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${formItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${formItemInstance?.id}" />
                <g:hiddenField name="version" value="${formItemInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="position"><g:message code="formItem.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formItemInstance, field: 'position', 'errors')}">
                                    <g:textField name="position" value="${fieldValue(bean: formItemInstance, field: 'position')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="field"><g:message code="formItem.field.label" default="Field" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formItemInstance, field: 'field', 'errors')}">
                                    <g:select name="field.id" from="${org.workflow4people.Field.list()}" optionKey="id" value="${formItemInstance?.field?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="baseXpath"><g:message code="formItem.baseXpath.label" default="Base Xpath" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formItemInstance, field: 'baseXpath', 'errors')}">
                                    <g:textField name="baseXpath" value="${formItemInstance?.baseXpath}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="readonly"><g:message code="formItem.readonly.label" default="Readonly" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: formItemInstance, field: 'readonly', 'errors')}">
                                    <g:checkBox name="readonly" value="${formItemInstance?.readonly}" />

                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                        
                           	<g:hiddenField name="form.id" value="${formItemInstance?.form?.id}" />
                            
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="insertsave" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
