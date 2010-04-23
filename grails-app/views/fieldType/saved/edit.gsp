

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="fieldType.edit" default="Edit FieldType" /></title>
    </head>
    <body>

        <div class="body">            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${fieldTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${fieldTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <div class="nav">            	
            	<span class="menuButton"><g:link class="list" action="list"><g:message code="fieldType.list" default="FieldType List" /></g:link></span>
            	<span class="menuButton"><g:link class="create" action="create"><g:message code="fieldType.new" default="New FieldType" /></g:link></span>
            </div>
            <g:form method="post" >
                <g:hiddenField name="id" value="${fieldTypeInstance?.id}" />
                <g:hiddenField name="version" value="${fieldTypeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="fieldType.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: fieldTypeInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="fieldType.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" rows="5" cols="40" value="${fieldValue(bean: fieldTypeInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="defaultValue"><g:message code="fieldType.defaultValue" default="Default Value" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'defaultValue', 'errors')}">
                                    <g:textField name="defaultValue" value="${fieldValue(bean: fieldTypeInstance, field: 'defaultValue')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="label"><g:message code="fieldType.label" default="Label" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldTypeInstance.label}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="help"><g:message code="fieldType.help" default="Help" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'help', 'errors')}">
                                    <g:textArea name="help" rows="5" cols="40" value="${fieldTypeInstance.help}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alert"><g:message code="fieldType.alert" default="Alert" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'alert', 'errors')}">
                                    <g:textArea name="alert" rows="5" cols="40" value="${fieldTypeInstance.alert}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="schemaSnippet"><g:message code="fieldType.schemaSnippet" default="Schema Snippet" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'schemaSnippet', 'errors')}">
                                    <g:textArea name="schemaSnippet" rows="5" cols="40" value="${fieldTypeInstance.schemaSnippet}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="xmlSnippet"><g:message code="fieldType.xmlSnippet" default="Xml Snippet" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'xmlSnippet', 'errors')}">
                                    <g:textArea name="xmlSnippet" rows="5" cols="40" value="${fieldTypeInstance.xmlSnippet}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="formSnippet"><g:message code="fieldType.formSnippet" default="Form Snippet" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'formSnippet', 'errors')}">
                                    <g:textArea name="formSnippet" rows="5" cols="40" value="${fieldTypeInstance.formSnippet}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="readonlyFormSnippet"><g:message code="fieldType.readonlyFormSnippet" default="Readonly Form Snippet" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'readonlyFormSnippet', 'errors')}">
                                    <g:textArea name="readonlyFormSnippet" rows="5" cols="40" value="${fieldTypeInstance.readonlyFormSnippet}" />

                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="modelSnippet"><g:message code="fieldType.modelSnippet" default="Model Snippet" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'modelSnippet', 'errors')}">
                                    <g:textArea name="modelSnippet" rows="5" cols="40" value="${fieldTypeInstance.modelSnippet}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldLength"><g:message code="fieldType.fieldLength" default="Field Length" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'fieldLength', 'errors')}">
                                    <g:textField name="fieldLength" value="${fieldValue(bean: fieldTypeInstance, field: 'fieldLength')}" />

                                </td>
                            </tr>
                            
							<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="runtimeEditableList"><g:message code="fieldType.runtimeEditableList" default="Runtime Editable List" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'runtimeEditableList', 'errors')}">
                                    <g:checkBox name="repeatField" value="${fieldTypeInstance?.runtimeEditableList}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
