
<%@ page import="org.workflow4people.FieldType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldType.label', default: 'FieldType')}" />
        <title><g:message code="fieldType.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                                    		
                		<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="fieldType.list.label" args="[entityName]" /></g:link></span>
            			                        
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
			<g:if test="${navTemplate}" >
            	<g:render template="${navTemplate}" model="[entityName:entityName,fieldTypeInstance:fieldTypeInstance]"/>
            </g:if>
        </div>  
            <g:if test="${flash.message}">
            <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${fieldTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${fieldTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
                <g:hiddenField name="id" value="${fieldTypeInstance?.id}" />
                <g:hiddenField name="version" value="${fieldTypeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="fieldType.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldTypeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldTypeInstance?.name}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="namespace"><g:message code="fieldType.namespace.label" default="Namespace" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'namespace', 'errors')}">
                                    <g:select name="namespace.id" from="${org.workflow4people.Namespace.list()}" optionKey="id" value="${fieldTypeInstance?.namespace?.id}" noSelection="['null': '']" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.namespace.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="baseType"><g:message code="fieldType.baseType.label" default="Base Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'baseType', 'errors')}">
                                    <g:select name="baseType.id" from="${org.workflow4people.BaseType.list()}" optionKey="id" value="${fieldTypeInstance?.baseType?.id}" noSelection="['null': '']" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.baseType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="baseSchemaType"><g:message code="fieldType.baseSchemaType.label" default="Base Schema Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'baseSchemaType', 'errors')}">
                                    <g:textField name="baseSchemaType" value="${fieldTypeInstance?.baseSchemaType}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.baseSchemaType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="fieldType.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${fieldTypeInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="defaultValue"><g:message code="fieldType.defaultValue.label" default="Default Value" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldTypeInstance, field: 'defaultValue', 'errors')}">
                                    <g:textField name="defaultValue" value="${fieldTypeInstance?.defaultValue}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.defaultValue.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="label"><g:message code="fieldType.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldTypeInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldTypeInstance?.label}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.label.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="help"><g:message code="fieldType.help.label" default="Help" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'help', 'errors')}">
                                    <g:textArea name="help" cols="40" rows="5" value="${fieldTypeInstance?.help}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.help.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="alert"><g:message code="fieldType.alert.label" default="Alert" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'alert', 'errors')}">
                                    <g:textArea name="alert" cols="40" rows="5" value="${fieldTypeInstance?.alert}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.alert.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="runtimeEditableList"><g:message code="fieldType.runtimeEditableList.label" default="Runtime Editable List" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'runtimeEditableList', 'errors')}">
                                    <g:checkBox name="runtimeEditableList" value="${fieldTypeInstance?.runtimeEditableList}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.runtimeEditableList.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="generateSchemaType"><g:message code="fieldType.generateSchemaType.label" default="Generate Schema Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'generateSchemaType', 'errors')}">
                                    <g:checkBox name="generateSchemaType" value="${fieldTypeInstance?.generateSchemaType}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.generateSchemaType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="restrictions"><g:message code="fieldType.restrictions.label" default="Restrictions" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'restrictions', 'errors')}">
                                    <g:checkBox name="restrictions" value="${fieldTypeInstance?.restrictions}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.restrictions.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="length"><g:message code="fieldType.length.label" default="Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'length', 'errors')}">
                                    <g:textField name="length" value="${fieldTypeInstance?.length}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.length.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="minLength"><g:message code="fieldType.minLength.label" default="Min Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'minLength', 'errors')}">
                                    <g:textField name="minLength" value="${fieldTypeInstance?.minLength}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.minLength.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="maxLength"><g:message code="fieldType.maxLength.label" default="Max Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'maxLength', 'errors')}">
                                    <g:textField name="maxLength" value="${fieldTypeInstance?.maxLength}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.maxLength.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="pattern"><g:message code="fieldType.pattern.label" default="Pattern" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldTypeInstance, field: 'pattern', 'errors')}">
                                    <g:textField name="pattern" value="${fieldTypeInstance?.pattern}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.pattern.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="minInclusive"><g:message code="fieldType.minInclusive.label" default="Min Inclusive" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'minInclusive', 'errors')}">
                                    <g:textField name="minInclusive" value="${fieldTypeInstance?.minInclusive}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.minInclusive.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="maxInclusive"><g:message code="fieldType.maxInclusive.label" default="Max Inclusive" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'maxInclusive', 'errors')}">
                                    <g:textField name="maxInclusive" value="${fieldTypeInstance?.maxInclusive}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.maxInclusive.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="minExclusive"><g:message code="fieldType.minExclusive.label" default="Min Exclusive" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'minExclusive', 'errors')}">
                                    <g:textField name="minExclusive" value="${fieldTypeInstance?.minExclusive}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.minExclusive.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="maxExclusive"><g:message code="fieldType.maxExclusive.label" default="Max Exclusive" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldTypeInstance, field: 'maxExclusive', 'errors')}">
                                    <g:textField name="maxExclusive" value="${fieldTypeInstance?.maxExclusive}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'fieldType.maxExclusive.help',default:'x')}" href="" >?</a>                                    
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
