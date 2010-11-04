
<%@ page import="org.workflow4people.FieldList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldList.label', default: 'FieldList')}" />
        <title><g:message code="fieldList.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="fieldList.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldListInstance:fieldListInstance]"/>
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
                         
                            
                            <td valign="top" class="name"><g:message code="fieldList.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldList.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value wide">${fieldListInstance.name}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldList.namespace.label" default="Namespace" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="namespace" action="show" id="${fieldListInstance?.namespace?.id}">${fieldListInstance?.namespace?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldList.baseType.label" default="Base Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="baseType" action="show" id="${fieldListInstance?.baseType?.id}">${fieldListInstance?.baseType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldList.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value wide">${fieldListInstance.label}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="fieldList.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldListInstance.description}</td>
                            
						
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
                    <g:hiddenField name="id" value="${fieldListInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldListInstance:fieldListInstance]"/>
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
                            
                            	<tr><th colspan="2"><g:message code="fieldList.field.label" default="Field" /></th></tr>
                            	<tr><td><b><g:message code="field.list.name.label" /></b></td><td>
                            	
                            	
                            	<g:link title ="${message(code: 'field.list.create.help')}" class="awesome small blue button" controller="field" action="create" params="['fieldList.id': fieldListInstance?.id]"><g:message code="field.list.new.label" />&nbsp;&raquo;</g:link>
                            	
                            	
                            	</td></tr>
                            	 
                            		<tbody  class="sortable" id="field">
                            	
                            	
                                
                                <g:each in="${org.workflow4people.Field.findAllByFieldList(fieldListInstance,[sort:'fieldPosition',order:'asc'])}" var="f">
                                
                                <tr id="position-${f.id}">
                                <td>${f?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'field.list.show.help')}" class="awesome small blue button" controller="field" action="show" id="${f.id}"><g:message code="field.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'field.list.edit.help')}" class="awesome small blue button" controller="field" action="edit" id="${f.id}"><g:message code="field.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'field.list.delete.help')}" class="awesome small red button" controller="field" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'field.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
