
<%@ page import="org.workflow4people.FieldType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldType.label', default: 'FieldType')}" />
        <title><g:message code="fieldType.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="fieldType.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldTypeInstance:fieldTypeInstance]"/>
            	</g:if>
        	</div>
           
            <g:if test="${flash.message}">
                        <div class="message">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
            </div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value wide">${fieldTypeInstance.name}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.namespace.label" default="Namespace" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="namespace" action="show" id="${fieldTypeInstance?.namespace?.id}">${fieldTypeInstance?.namespace?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.baseType.label" default="Base Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="baseType" action="show" id="${fieldTypeInstance?.baseType?.id}">${fieldTypeInstance?.baseType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.baseSchemaType.label" default="Base Schema Type" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.baseSchemaType}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.description}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.defaultValue.label" default="Default Value" /></td>
                         
                            
                            <td valign="top" class="value wide">${fieldTypeInstance.defaultValue}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value wide">${fieldTypeInstance.label}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.help.label" default="Help" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.help}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.alert.label" default="Alert" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.alert}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.runtimeEditableList.label" default="Runtime Editable List" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.runtimeEditableList}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.generateSchemaType.label" default="Generate Schema Type" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.generateSchemaType}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.restrictions.label" default="Restrictions" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.restrictions}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.length.label" default="Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.length}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.minLength.label" default="Min Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.minLength}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.maxLength.label" default="Max Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.maxLength}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.pattern.label" default="Pattern" /></td>
                         
                            
                            <td valign="top" class="value wide">${fieldTypeInstance.pattern}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.minInclusive.label" default="Min Inclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.minInclusive}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.maxInclusive.label" default="Max Inclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.maxInclusive}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.minExclusive.label" default="Min Exclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.minExclusive}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldType.maxExclusive.label" default="Max Exclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldTypeInstance.maxExclusive}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${fieldTypeInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldTypeInstance:fieldTypeInstance]"/>
            	</g:if>
            </div>
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
                    <g:hiddenField name="navigatedFrom" value="show" />
                    <g:hiddenField name="q" value="${params.q}" />
            
            
                </g:form>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            
                            	<tr><th colspan="2"><g:message code="fieldType.fieldTypeItem.label" default="Field Type Item" /></th></tr>
                            	<tr><td><b><g:message code="fieldTypeItem.list.name.label" /></b></td><td>
                            	
                            	
                            	<g:link title ="${message(code: 'fieldTypeItem.list.create.help')}" class="awesome small blue button" controller="fieldTypeItem" action="create" params="['fieldType.id': fieldTypeInstance?.id]"><g:message code="fieldTypeItem.list.new.label" />&nbsp;&raquo;</g:link>
                            	
                            	
                            	</td></tr>
                            	 
                            		<tbody  class="sortable" id="fieldTypeItem">
                            	
                            	
                                
                                <g:each in="${org.workflow4people.FieldTypeItem.findAllByFieldType(fieldTypeInstance,[sort:'itemPosition',order:'asc'])}" var="f">
                                
                                <tr id="position-${f.id}">
                                <td>${f?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'fieldTypeItem.list.show.help')}" class="awesome small blue button" controller="fieldTypeItem" action="show" id="${f.id}"><g:message code="fieldTypeItem.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'fieldTypeItem.list.edit.help')}" class="awesome small blue button" controller="fieldTypeItem" action="edit" id="${f.id}"><g:message code="fieldTypeItem.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'fieldTypeItem.list.delete.help')}" class="awesome small red button" controller="fieldTypeItem" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'fieldTypeItem.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
