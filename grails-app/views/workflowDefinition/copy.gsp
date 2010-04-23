
<%@ page import="org.workflow4people.WorkflowDefinition" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="workflowDefinition.edit" default="Edit WorkflowDefinition" /></title>
    </head>
    <body>

        <div class="body">            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${workflowDefinitionInstance}">
            <div class="errors">
                <g:renderErrors bean="${workflowDefinitionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <div class="nav">            	
            	<span class="menuButton"><g:link class="list" action="list"><g:message code="workflowDefinition.list" default="WorkflowDefinition List" /></g:link></span>
            	<span class="menuButton"><g:link class="create" action="create"><g:message code="workflowDefinition.new" default="New WorkflowDefinition" /></g:link></span>
            </div>
            <g:form method="post" >
                <g:hiddenField name="id" value="${workflowDefinitionInstance?.id}" />
                <g:hiddenField name="version" value="${workflowDefinitionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="publish"><g:message code="workflowDefinition.publish" default="Publish" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'publish', 'errors')}">
                                    <g:checkBox name="publish" value="${workflowDefinitionInstance?.publish}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="workflowDefinition.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: workflowDefinitionInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title"><g:message code="workflowDefinition.title" default="Title" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${fieldValue(bean: workflowDefinitionInstance, field: 'title')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="workflowDefinition.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" rows="5" cols="40" value="${workflowDefinitionInstance.description}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="workflowDefinition.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${workflowDefinitionInstance?.dateCreated}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="workflowDefinition.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${workflowDefinitionInstance?.lastUpdated}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldList"><g:message code="workflowDefinition.fieldList" default="Field List" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'fieldList', 'errors')}">
                                    <g:select name="fieldList.id" from="${org.workflow4people.FieldList.list()}" optionKey="id" value="${workflowDefinitionInstance?.fieldList?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="form"><g:message code="workflowDefinition.form" default="Form" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'form', 'errors')}">
                                    
<ul>
<g:each in="${workflowDefinitionInstance?.form}" var="formInstance">
    <li><g:link controller="form" action="show" id="${formInstance.id}">${formInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="form" params="['workflowDefinition.id': workflowDefinitionInstance?.id]" action="create"><g:message code="form.new" default="New Form" /></g:link>


                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="workflowPermission"><g:message code="workflowDefinition.workflowPermission" default="Workflow Permission" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'workflowPermission', 'errors')}">
                                    
<ul>
<g:each in="${workflowDefinitionInstance?.workflowPermission}" var="workflowPermissionInstance">
    <li><g:link controller="workflowPermission" action="show" id="${workflowPermissionInstance.id}">${workflowPermissionInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="workflowPermission" params="['workflowDefinition.id': workflowDefinitionInstance?.id]" action="create"><g:message code="workflowPermission.new" default="New WorkflowPermission" /></g:link>


                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="createcopy" value="${message(code: 'createcopy', 'default': 'Create copy')}" /></span>                    
                </div>
            </g:form>
        </div>
    </body>
</html>
