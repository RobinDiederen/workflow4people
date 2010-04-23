

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="fieldType.show" default="Show FieldType" /></title>
    </head>
    <body>
        
        <div class="body">            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            
            <div class="nav">          
            	<span class="menuButton"><g:link class="list" action="list"><g:message code="fieldType.list" default="FieldType List" /></g:link></span>
            	<span class="menuButton"><g:link class="create" action="create"><g:message code="fieldType.new" default="New FieldType" /></g:link></span>
            	<span class="menuButton"><g:link class="create" action="copy" id="${params.id}"><g:message code="fieldType.copy" default="Copy FieldType" /></g:link></span>
        	</div>
            <g:form>
                <g:hiddenField name="id" value="${fieldTypeInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.defaultValue" default="Default Value" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "defaultValue")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.label" default="Label" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "label")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.help" default="Help" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "help")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.alert" default="Alert" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "alert")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.schemaSnippet" default="Schema Snippet" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "schemaSnippet")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.xmlSnippet" default="Xml Snippet" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "xmlSnippet")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.formSnippet" default="Form Snippet" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "formSnippet")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.readonlyFormSnippet" default="Readonly Form Snippet" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "readonlyFormSnippet")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.modelSnippet" default="Model Snippet" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "modelSnippet")}</td>
                                
                            </tr>
                            
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.fieldLength" default="Field Length" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "fieldLength")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="fieldType.runtimeEditableList" default="Runtime Editable List" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.runtimeEditableList}" /></td>
                                
                            </tr>
                            
                            
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
                
                <div class="itemlist list">                    
                   <table>
                    <tbody>
                    	<tr><th colspan="5">List items</th></tr>
                    	<tr><th>#</th><th>Label</th><th>Value</th><th>
                    	<g:link title="Insert item at top of list" controller="fieldTypeItem" params="['fieldType.id': fieldTypeInstance?.id]" action="create">&oplus;</g:link>                    	
                    	</th></tr>
                    	<g:each in="${FieldTypeItem.findAllByFieldType(fieldTypeInstance,[sort:'itemPosition',order:'asc'])}" var="fieldTypeItemInstance" >                                                            
                    	<tr><td>
                    		<g:link title="Show item" controller="fieldTypeItem" params="['id': fieldTypeItemInstance?.id]" action="show">${fieldTypeItemInstance.itemPosition}</g:link>
                    	</td>
                    	<td>${fieldTypeItemInstance.label}</td><td>${fieldTypeItemInstance.value}</td>
                    	<td>
                    		<g:link title="Edit item" controller="fieldTypeItem" params="['id': fieldTypeItemInstance?.id]" action="edit">&Xi;</g:link>
                    		<g:link title="Insert new item after this item" controller="fieldTypeItem" params="['fieldType.id': fieldTypeInstance?.id,'itemPosition':fieldTypeItemInstance.itemPosition]" action="insert">&oplus;</g:link>
                    	</td></tr>
                    	</g:each>                    	
                    	</tbody>                    
                    </table>
                    </div>
            </g:form>
        </div>
    </body>
</html>
