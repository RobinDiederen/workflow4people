
<%@ page import="org.workflow4people.DocumentType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentType.label', default: 'DocumentType')}" />
        <title><g:message code="documentType.insert.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton">&laquo;&nbsp;<g:link class="awesome small blue button" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,documentTypeInstance:documentTypeInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${documentTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${documentTypeInstance?.id}" />
                <g:hiddenField name="version" value="${documentTypeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="documentType.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${documentTypeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="documentType.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${documentTypeInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descriptionTemplate"><g:message code="documentType.descriptionTemplate.label" default="Description Template" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'descriptionTemplate', 'errors')}">
                                    <g:textField name="descriptionTemplate" value="${documentTypeInstance?.descriptionTemplate}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateCreated"><g:message code="documentType.dateCreated.label" default="Date Created" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'dateCreated', 'errors')}">
                                    ${documentTypeInstance.dateCreated}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastUpdated"><g:message code="documentType.lastUpdated.label" default="Last Updated" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'lastUpdated', 'errors')}">
                                    ${documentTypeInstance.lastUpdated}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fieldList"><g:message code="documentType.fieldList.label" default="Field List" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'fieldList', 'errors')}">
                                    <g:select name="fieldList.id" from="${org.workflow4people.FieldList.list()}" optionKey="id" value="${documentTypeInstance?.fieldList?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="viewForm"><g:message code="documentType.viewForm.label" default="View Form" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'viewForm', 'errors')}">
                                    <g:select name="viewForm.id" from="${org.workflow4people.Form.list()}" optionKey="id" value="${documentTypeInstance?.viewForm?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentIndexField"><g:message code="documentType.documentIndexField.label" default="Document Index Field" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentTypeInstance, field: 'documentIndexField', 'errors')}">
                                    <g:select class="multiselect" name="documentIndexField" from="${org.workflow4people.DocumentIndexField.list(sort:'name')}" multiple="yes" optionKey="id" value="${documentTypeInstance?.documentIndexField}" />
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
