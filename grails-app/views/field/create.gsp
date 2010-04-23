
<%@ page import="org.workflow4people.Field" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'field.label', default: 'Field')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
			<div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">&laquo;&nbsp;Back to Child Field List ${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">&laquo;&nbsp;Back to Field List ${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldInstance:fieldInstance]"/>
            	</g:if>
        	</div>
        
            <g:if test="${flash.message}">
                    <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <g:hasErrors bean="${fieldInstance}">
            <div class="errors">
                <g:renderErrors bean="${fieldInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldPosition"><g:message code="field.fieldPosition.label" default="Field Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'fieldPosition', 'errors')}">
                                    <g:textField name="fieldPosition" value="${fieldValue(bean: fieldInstance, field: 'fieldPosition')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="field.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldType"><g:message code="field.fieldType.label" default="Field Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'fieldType', 'errors')}">
                                    <g:select name="fieldType.id" from="${org.workflow4people.FieldType.list()}" optionKey="id" value="${fieldInstance?.fieldType?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="childFieldList"><g:message code="field.childFieldList.label" default="Child Field List" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'childFieldList', 'errors')}">
                                    <g:select name="childFieldList.id" from="${org.workflow4people.FieldList.list()}" optionKey="id" value="${fieldInstance?.childFieldList?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="field.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${fieldInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="defaultValue"><g:message code="field.defaultValue.label" default="Default Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'defaultValue', 'errors')}">
                                    <g:textField name="defaultValue" value="${fieldInstance?.defaultValue}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="label"><g:message code="field.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldInstance?.label}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="help"><g:message code="field.help.label" default="Help" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'help', 'errors')}">
                                    <g:textArea name="help" cols="40" rows="5" value="${fieldInstance?.help}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alert"><g:message code="field.alert.label" default="Alert" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'alert', 'errors')}">
                                    <g:textArea name="alert" cols="40" rows="5" value="${fieldInstance?.alert}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contentText"><g:message code="field.contentText.label" default="Content Text" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'contentText', 'errors')}">
                                    <g:textArea name="contentText" cols="40" rows="5" value="${fieldInstance?.contentText}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="minOccurs"><g:message code="field.minOccurs.label" default="Min Occurs" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'minOccurs', 'errors')}">
                                    <g:textField name="minOccurs" value="${fieldInstance?.minOccurs}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maxOccurs"><g:message code="field.maxOccurs.label" default="Max Occurs" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'maxOccurs', 'errors')}">
                                    <g:textField name="maxOccurs" value="${fieldInstance?.maxOccurs}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nillable"><g:message code="field.nillable.label" default="Nillable" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'nillable', 'errors')}">
                                    <g:checkBox name="nillable" value="${fieldInstance?.nillable}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dependsOn"><g:message code="field.dependsOn.label" default="Depends On" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'dependsOn', 'errors')}">
                                    <g:select name="dependsOn.id" from="${org.workflow4people.Field.list()}" optionKey="id" value="${fieldInstance?.dependsOn?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dependencyType"><g:message code="field.dependencyType.label" default="Dependency Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'dependencyType', 'errors')}">
                                    <g:select name="dependencyType" from="${fieldInstance.constraints.dependencyType.inList}" value="${fieldInstance?.dependencyType}" valueMessagePrefix="field.dependencyType" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dependencyParameter"><g:message code="field.dependencyParameter.label" default="Dependency Parameter" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'dependencyParameter', 'errors')}">
                                    <g:textField name="dependencyParameter" value="${fieldInstance?.dependencyParameter}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customDependencyExpression"><g:message code="field.customDependencyExpression.label" default="Custom Dependency Expression" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'customDependencyExpression', 'errors')}">
                                    <g:textArea name="customDependencyExpression" cols="40" rows="5" value="${fieldInstance?.customDependencyExpression}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="readonly"><g:message code="field.readonly.label" default="Readonly" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'readonly', 'errors')}">
                                    <g:checkBox name="readonly" value="${fieldInstance?.readonly}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="securitylevelRead"><g:message code="field.securitylevelRead.label" default="Securitylevel Read" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'securitylevelRead', 'errors')}">
                                    <g:textField name="securitylevelRead" value="${fieldValue(bean: fieldInstance, field: 'securitylevelRead')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="securitylevelReadWrite"><g:message code="field.securitylevelReadWrite.label" default="Securitylevel Read Write" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'securitylevelReadWrite', 'errors')}">
                                    <g:textField name="securitylevelReadWrite" value="${fieldValue(bean: fieldInstance, field: 'securitylevelReadWrite')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="xpath"><g:message code="field.xpath.label" default="Xpath" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'xpath', 'errors')}">
                                    <g:textField name="xpath" value="${fieldInstance?.xpath}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldLength"><g:message code="field.fieldLength.label" default="Field Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'fieldLength', 'errors')}">
                                    <g:textField name="fieldLength" value="${fieldInstance?.fieldLength}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    
                                
                           	<g:hiddenField name="fieldList.id" value="${fieldInstance?.fieldList?.id}" />
                            
                                
                    
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
