
<%@ page import="org.workflow4people.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
        <title><g:message code="document.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="document.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
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
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.documentType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentStatus"><g:message code="document.documentStatus.label" default="Document Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentStatus', 'errors')}">
                                    <g:textField name="documentStatus" value="${documentInstance?.documentStatus}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.documentStatus.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="documentKey"><g:message code="document.documentKey.label" default="Document Key" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'documentKey', 'errors')}">
                                    <g:textField name="documentKey" value="${documentInstance?.documentKey}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.documentKey.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="documentDescription"><g:message code="document.documentDescription.label" default="Document Description" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentInstance, field: 'documentDescription', 'errors')}">
                                    <g:textField name="documentDescription" value="${documentInstance?.documentDescription}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.documentDescription.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateCreated"><g:message code="document.dateCreated.label" default="Date Created" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'dateCreated', 'errors')}">
                                    <input class="datepicker" type="text" name="dateCreated" value="${formatDate(date:documentInstance?.dateCreated,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.dateCreated.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastUpdated"><g:message code="document.lastUpdated.label" default="Last Updated" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'lastUpdated', 'errors')}">
                                    <input class="datepicker" type="text" name="lastUpdated" value="${formatDate(date:documentInstance?.lastUpdated,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.lastUpdated.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="completionDate"><g:message code="document.completionDate.label" default="Completion Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'completionDate', 'errors')}">
                                    <input class="datepicker" type="text" name="completionDate" value="${formatDate(date:documentInstance?.completionDate,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.completionDate.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="processingDays"><g:message code="document.processingDays.label" default="Processing Days" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'processingDays', 'errors')}">
                                    <g:textField name="processingDays" value="${fieldValue(bean: documentInstance, field: 'processingDays')}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.processingDays.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="document.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'user', 'errors')}">
                                    <g:textField name="user" value="${documentInstance?.user}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.user.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="groupId"><g:message code="document.groupId.label" default="Group Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'groupId', 'errors')}">
                                    <g:textField name="groupId" value="${documentInstance?.groupId}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.groupId.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="cmisFolderObjectId"><g:message code="document.cmisFolderObjectId.label" default="Cmis Folder Object Id" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentInstance, field: 'cmisFolderObjectId', 'errors')}">
                                    <g:textField name="cmisFolderObjectId" value="${documentInstance?.cmisFolderObjectId}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.cmisFolderObjectId.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="cmisFolderUrl"><g:message code="document.cmisFolderUrl.label" default="Cmis Folder Url" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentInstance, field: 'cmisFolderUrl', 'errors')}">
                                    <g:textField name="cmisFolderUrl" value="${documentInstance?.cmisFolderUrl}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.cmisFolderUrl.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="xmlDocument"><g:message code="document.xmlDocument.label" default="Xml Document" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: documentInstance, field: 'xmlDocument', 'errors')}">
                                    <g:textArea name="xmlDocument" cols="40" rows="5" value="${documentInstance?.xmlDocument}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.xmlDocument.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="form"><g:message code="document.form.label" default="Form" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'form', 'errors')}">
                                    <g:select class="multiselect" name="form" from="${org.workflow4people.Form.list()}" multiple="yes" optionKey="id"  value="${documentInstance?.form}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'document.form.help',default:'x')}" href="" >?</a>                                    
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
