
<%@ page import="org.workflow4people.Field" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'field.label', default: 'Field')}" />
        <title><g:message code="field.edit.title" /></title>
    </head>
    <body>
        
        <div class="body">
                    <g:form method="post" >
        
                    <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">&laquo;&nbsp; ${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button" controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">&laquo;&nbsp; ${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                    
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
                <g:hiddenField name="id" value="${fieldInstance?.id}" />
                <g:hiddenField name="version" value="${fieldInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fieldPosition"><g:message code="field.fieldPosition.label" default="Field Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'fieldPosition', 'errors')}">
                                    <g:textField name="fieldPosition" value="${fieldValue(bean: fieldInstance, field: 'fieldPosition')}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.fieldPosition.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="field.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldInstance?.name}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.name.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fieldType"><g:message code="field.fieldType.label" default="Field Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'fieldType', 'errors')}">
                                    <g:select name="fieldType.id" from="${org.workflow4people.FieldType.list()}" optionKey="id" value="${fieldInstance?.fieldType?.id}"  />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.fieldType.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="childFieldList"><g:message code="field.childFieldList.label" default="Child Field List" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'childFieldList', 'errors')}">
                                    <g:select name="childFieldList.id" from="${org.workflow4people.FieldList.list()}" optionKey="id" value="${fieldInstance?.childFieldList?.id}" noSelection="['null': '']" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.childFieldList.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="field.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${fieldInstance?.description}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.description.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="defaultValue"><g:message code="field.defaultValue.label" default="Default Value" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldInstance, field: 'defaultValue', 'errors')}">
                                    <g:textField name="defaultValue" value="${fieldInstance?.defaultValue}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.defaultValue.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop wide">
                                <td valign="top" class="name">
                                  <label for="label"><g:message code="field.label.label" default="Label" /></label>
                                </td>
                                <td valign="top" class="value wide ${hasErrors(bean: fieldInstance, field: 'label', 'errors')}">
                                    <g:textField name="label" value="${fieldInstance?.label}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.label.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="help"><g:message code="field.help.label" default="Help" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'help', 'errors')}">
                                    <g:textArea name="help" cols="40" rows="5" value="${fieldInstance?.help}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.help.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="alert"><g:message code="field.alert.label" default="Alert" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'alert', 'errors')}">
                                    <g:textArea name="alert" cols="40" rows="5" value="${fieldInstance?.alert}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.alert.help',default:'x')}" href="" >?</a>                                    
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
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contentText"><g:message code="field.contentText.label" default="Content Text" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'contentText', 'errors')}">
                                    <g:textArea name="contentText" cols="40" rows="5" value="${fieldInstance?.contentText}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.contentText.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="minOccurs"><g:message code="field.minOccurs.label" default="Min Occurs" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'minOccurs', 'errors')}">
                                    <g:textField name="minOccurs" value="${fieldInstance?.minOccurs}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.minOccurs.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="maxOccurs"><g:message code="field.maxOccurs.label" default="Max Occurs" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'maxOccurs', 'errors')}">
                                    <g:textField name="maxOccurs" value="${fieldInstance?.maxOccurs}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.maxOccurs.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nillable"><g:message code="field.nillable.label" default="Nillable" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'nillable', 'errors')}">
                                    <g:checkBox name="nillable" value="${fieldInstance?.nillable}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.nillable.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dependencyExpression"><g:message code="field.dependencyExpression.label" default="Dependency Expression" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'dependencyExpression', 'errors')}">
                                    <g:textArea name="dependencyExpression" cols="40" rows="5" value="${fieldInstance?.dependencyExpression}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.dependencyExpression.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="readonly"><g:message code="field.readonly.label" default="Readonly" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: fieldInstance, field: 'readonly', 'errors')}">
                                    <g:checkBox name="readonly" value="${fieldInstance?.readonly}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.readonly.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                        
                            <tr class="prop extrawide">
                                <td valign="top" class="name">
                                  <label for="xpath"><g:message code="field.xpath.label" default="Xpath" /></label>
                                </td>
                                <td valign="top" class="value extrawide ${hasErrors(bean: fieldInstance, field: 'xpath', 'errors')}">
                                    <g:textField name="xpath" value="${fieldInstance?.xpath}" />
                                    <a tabindex="9999" class="awesome small blue help button" title="${message(code:'field.xpath.help',default:'x')}" href="" >?</a>                                    
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                        
                           	<g:hiddenField name="fieldList.id" value="${fieldInstance?.fieldList?.id}" />
                            
                        
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
