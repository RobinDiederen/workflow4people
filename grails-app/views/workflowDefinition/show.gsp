
<%@ page import="org.workflow4people.WorkflowDefinition" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowDefinition.label', default: 'WorkflowDefinition')}" />
        <title><g:message code="workflowDefinition.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link  params="${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="workflowDefinition.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render contextPath="${pluginContextPath}" template="${navTemplate}" model="[entityName:entityName,workflowDefinitionInstance:workflowDefinitionInstance]"/>
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
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowDefinitionInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.publish.label" default="Publish" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${workflowDefinitionInstance?.publish}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${workflowDefinitionInstance.name}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${workflowDefinitionInstance.title}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${workflowDefinitionInstance.description}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.dateCreated.label" default="Date Created" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${workflowDefinitionInstance?.dateCreated}" /></td>
                            
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.lastUpdated.label" default="Last Updated" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${workflowDefinitionInstance?.lastUpdated}" /></td>
                            
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="workflowDefinition.documentType.label" default="Document Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="documentType" action="show" id="${workflowDefinitionInstance?.documentType?.id}">${workflowDefinitionInstance?.documentType?.encodeAsHTML()}</g:link></td>
                            
						
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
                    <g:hiddenField name="id" value="${workflowDefinitionInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,workflowDefinitionInstance:workflowDefinitionInstance]"/>
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
                            
                            	<tr><th colspan="2"><g:message code="workflowDefinition.form.label" default="Form" /></th></tr>
                            	<tr><td><b><g:message code="form.list.name.label" /></b></td><td>
                            	
                            	
                            	<g:link title ="${message(code: 'form.list.create.help')}" class="awesome small blue button" controller="form" action="create" params="['workflow.id': workflowDefinitionInstance?.id]"><g:message code="form.list.new.label" />&nbsp;&raquo;</g:link>
                            	
                            	
                            	</td></tr>
                            	
                           			<tbody  id="form">                            	
                            	
                            	
                                
                                <g:each in="${org.workflow4people.Form.findAllByWorkflow(workflowDefinitionInstance,[sort:'name',order:'asc'])}" var="f">
                                
                                <tr id="position-${f.id}">
                                <td>${f?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'form.list.show.help')}" class="awesome small blue button" controller="form" action="show" id="${f.id}"><g:message code="form.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'form.list.edit.help')}" class="awesome small blue button" controller="form" action="edit" id="${f.id}"><g:message code="form.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'form.list.delete.help')}" class="awesome small red button" controller="form" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'form.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            
                            	<tr><th colspan="2"><g:message code="workflowDefinition.workflowPermission.label" default="Workflow Permission" /></th></tr>
                            	<tr><td><b><g:message code="workflowPermission.list.name.label" /></b></td><td>
                            	
                            	
                            	<g:link title ="${message(code: 'workflowPermission.list.create.help')}" class="awesome small blue button" controller="workflowPermission" action="create" params="['workflow.id': workflowDefinitionInstance?.id]"><g:message code="workflowPermission.list.new.label" />&nbsp;&raquo;</g:link>
                            	
                            	
                            	</td></tr>
                            	
                           			<tbody  id="workflowPermission">                            	
                            	
                            	
                                
                                <g:each in="${org.workflow4people.WorkflowPermission.findAllByWorkflow(workflowDefinitionInstance,[sort:'authority',order:'asc'])}" var="w">
                                
                                <tr id="position-${w.id}">
                                <td>${w?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'workflowPermission.list.show.help')}" class="awesome small blue button" controller="workflowPermission" action="show" id="${w.id}"><g:message code="workflowPermission.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'workflowPermission.list.edit.help')}" class="awesome small blue button" controller="workflowPermission" action="edit" id="${w.id}"><g:message code="workflowPermission.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'workflowPermission.list.delete.help')}" class="awesome small red button" controller="workflowPermission" action="delete" id="${w.id}" onclick="return confirm('${message(code: 'workflowPermission.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
