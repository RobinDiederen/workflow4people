
<%@ page import="org.workflow4people.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
        <title><g:message code="document.insert.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton">&laquo;&nbsp;<g:link class="awesome small blue button" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,documentInstance:documentInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${documentInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${documentInstance?.id}" />
                <g:hiddenField name="version" value="${documentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentType"><g:message code="document.documentType.label" default="Document Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentType', 'errors')}">
                                    <g:select name="documentType.id" from="${org.workflow4people.DocumentType.list()}" optionKey="id" value="${documentInstance?.documentType?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentStatus"><g:message code="document.documentStatus.label" default="Document Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentStatus', 'errors')}">
                                    <g:textField name="documentStatus" value="${documentInstance?.documentStatus}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentKey"><g:message code="document.documentKey.label" default="Document Key" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentKey', 'errors')}">
                                    <g:textField name="documentKey" value="${documentInstance?.documentKey}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentDescription"><g:message code="document.documentDescription.label" default="Document Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentDescription', 'errors')}">
                                    <g:textField name="documentDescription" value="${documentInstance?.documentDescription}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateCreated"><g:message code="document.dateCreated.label" default="Date Created" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'dateCreated', 'errors')}">
                                    <input class="datepicker" type="text" name="dateCreated" value="${formatDate(date:documentInstance?.dateCreated,format:"yyyy-MM-dd'T'HH:mm:ss")}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastUpdated"><g:message code="document.lastUpdated.label" default="Last Updated" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'lastUpdated', 'errors')}">
                                    <input class="datepicker" type="text" name="lastUpdated" value="${formatDate(date:documentInstance?.lastUpdated,format:"yyyy-MM-dd'T'HH:mm:ss")}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="completionDate"><g:message code="document.completionDate.label" default="Completion Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'completionDate', 'errors')}">
                                    <input class="datepicker" type="text" name="completionDate" value="${formatDate(date:documentInstance?.completionDate,format:"yyyy-MM-dd'T'HH:mm:ss")}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="processingDays"><g:message code="document.processingDays.label" default="Processing Days" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'processingDays', 'errors')}">
                                    <g:textField name="processingDays" value="${fieldValue(bean: documentInstance, field: 'processingDays')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="document.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'user', 'errors')}">
                                    <g:textField name="user" value="${documentInstance?.user}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="groupId"><g:message code="document.groupId.label" default="Group Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'groupId', 'errors')}">
                                    <g:textField name="groupId" value="${documentInstance?.groupId}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cmisFolderObjectId"><g:message code="document.cmisFolderObjectId.label" default="Cmis Folder Object Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'cmisFolderObjectId', 'errors')}">
                                    <g:textField name="cmisFolderObjectId" value="${documentInstance?.cmisFolderObjectId}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cmisFolderUrl"><g:message code="document.cmisFolderUrl.label" default="Cmis Folder Url" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'cmisFolderUrl', 'errors')}">
                                    <g:textField name="cmisFolderUrl" value="${documentInstance?.cmisFolderUrl}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="xmlDocument"><g:message code="document.xmlDocument.label" default="Xml Document" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'xmlDocument', 'errors')}">
                                    <g:textArea name="xmlDocument" cols="40" rows="5" value="${documentInstance?.xmlDocument}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="form"><g:message code="document.form.label" default="Form" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'form', 'errors')}">
                                    <g:select class="multiselect" name="form" from="${org.workflow4people.Form.list()}" multiple="yes" optionKey="id"  value="${documentInstance?.form}" />

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
