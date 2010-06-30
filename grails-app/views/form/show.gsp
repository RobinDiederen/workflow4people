
<%@ page import="org.workflow4people.Form" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
        <title><g:message code="form.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="workflowDefinition" action="show" id="${formInstance?.workflow?.id}">&laquo;&nbsp; ${formInstance?.workflow?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,formInstance:formInstance]"/>
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
                         
                            
                            <td valign="top" class="name"><g:message code="form.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${formInstance.name}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${formInstance.title}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${formInstance.description}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.explanationMessage.label" default="Explanation Message" /></td>
                         
                            
                            <td valign="top" class="value">${formInstance.explanationMessage}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.confirmationMessage.label" default="Confirmation Message" /></td>
                         
                            
                            <td valign="top" class="value">${formInstance.confirmationMessage}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.template.label" default="Template" /></td>
                         
                            
                            <td valign="top" class="value">${formInstance.template}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.formAction.label" default="Form Action" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="action" action="show" id="${formInstance?.formAction?.id}">${formInstance?.formAction?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="form.workflow.label" default="Workflow" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="workflowDefinition" action="show" id="${formInstance?.workflow?.id}">${formInstance?.workflow?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${formInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,formInstance:formInstance]"/>
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
                            
                            	<tr><th colspan="2"><g:message code="form.formItem.label" default="Form Item" /></th></tr>
                            	<tr><td><b><g:message code="formItem.list.name.label" /></b></td><td>
                            	
                            	
                            	
                            	</td></tr>
                            	 
                            		<tbody  class="sortable" id="formItem">
                            	
                            	
                                
                                <g:each in="${org.workflow4people.FormItem.findAllByForm(formInstance,[sort:'position',order:'asc'])}" var="f">
                                
                                <tr id="position-${f.id}">
                                <td>${f?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'formItem.list.show.help')}" class="awesome small blue button" controller="formItem" action="show" id="${f.id}"><g:message code="formItem.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'formItem.list.edit.help')}" class="awesome small blue button" controller="formItem" action="edit" id="${f.id}"><g:message code="formItem.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'formItem.list.delete.help')}" class="awesome small red button" controller="formItem" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'formItem.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
