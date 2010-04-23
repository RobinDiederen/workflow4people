
<%@ page import="org.workflow4people.WorkflowDefinition" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowDefinition.label', default: 'WorkflowDefinition')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,workflowDefinitionInstance:workflowDefinitionInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${workflowDefinitionInstance}">
            <div class="errors">
                <g:renderErrors bean="${workflowDefinitionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${workflowDefinitionInstance?.id}" />
                <g:hiddenField name="version" value="${workflowDefinitionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="publish"><g:message code="workflowDefinition.publish.label" default="Publish" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'publish', 'errors')}">
                                    <g:checkBox name="publish" value="${workflowDefinitionInstance?.publish}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="workflowDefinition.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${workflowDefinitionInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="workflowDefinition.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${workflowDefinitionInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="workflowDefinition.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${workflowDefinitionInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateCreated"><g:message code="workflowDefinition.dateCreated.label" default="Date Created" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'dateCreated', 'errors')}">
                                    <input class="datepicker" type="text" name="dateCreated" value="${formatDate(date:workflowDefinitionInstance?.dateCreated,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastUpdated"><g:message code="workflowDefinition.lastUpdated.label" default="Last Updated" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'lastUpdated', 'errors')}">
                                    <input class="datepicker" type="text" name="lastUpdated" value="${formatDate(date:workflowDefinitionInstance?.lastUpdated,format:"yyyy-MM-dd'T'HH:mm:ss")}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fieldList"><g:message code="workflowDefinition.fieldList.label" default="Field List" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: workflowDefinitionInstance, field: 'fieldList', 'errors')}">
                                    <g:select name="fieldList.id" from="${org.workflow4people.FieldList.list()}" optionKey="id" value="${workflowDefinitionInstance?.fieldList?.id}"  />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                                            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
