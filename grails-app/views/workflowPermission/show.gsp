
<%@ page import="org.workflow4people.WorkflowPermission" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowPermission.label', default: 'WorkflowPermission')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="workflowDefinition" action="show" id="${workflowPermissionInstance?.workflow?.id}">&laquo;&nbsp;Back to Workflow ${workflowPermissionInstance?.workflow?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,workflowPermissionInstance:workflowPermissionInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5ea64282[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="workflowPermission.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowPermissionInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2103b97[name=authority,type=class org.workflow4people.Authority,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@77b8378f[class org.workflow4people.WorkflowPermission,authority,class org.workflow4people.Authority,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5f47cab0[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowPermission.authority.label" default="Authority" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="authority" action="show" id="${workflowPermissionInstance?.authority?.id}">${workflowPermissionInstance?.authority?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@624c19ae[name=role,type=class org.workflow4people.Role,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@722a20ec[class org.workflow4people.WorkflowPermission,role,class org.workflow4people.Role,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2bd7a082[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowPermission.role.label" default="Role" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="role" action="show" id="${workflowPermissionInstance?.role?.id}">${workflowPermissionInstance?.role?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@596acd4a[name=remark,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@72cbe322[class org.workflow4people.WorkflowPermission,remark,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@27ad080f[true]}] -->
                            <td valign="top" class="name"><g:message code="workflowPermission.remark.label" default="Remark" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowPermissionInstance, field: "remark")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@50ec2522[name=workflow,type=class org.workflow4people.WorkflowDefinition,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3f7a04af[class org.workflow4people.WorkflowPermission,workflow,class org.workflow4people.WorkflowDefinition,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@63c99db7[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowPermission.workflow.label" default="Workflow" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="workflowDefinition" action="show" id="${workflowPermissionInstance?.workflow?.id}">${workflowPermissionInstance?.workflow?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${workflowPermissionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,workflowPermissionInstance:workflowPermissionInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
