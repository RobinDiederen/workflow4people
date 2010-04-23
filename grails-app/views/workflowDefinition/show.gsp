
<%@ page import="org.workflow4people.WorkflowDefinition" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'workflowDefinition.label', default: 'WorkflowDefinition')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,workflowDefinitionInstance:workflowDefinitionInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@36ca9a76[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowDefinitionInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2f62d514[name=publish,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1932c5a[class org.workflow4people.WorkflowDefinition,publish,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6544c984[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.publish.label" default="Publish" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${workflowDefinitionInstance?.publish}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6894691f[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6781a7dc[class org.workflow4people.WorkflowDefinition,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7133919a[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowDefinitionInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@709c4f85[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2628de85[class org.workflow4people.WorkflowDefinition,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@45290155[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowDefinitionInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@71696ec[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5c0e6396[class org.workflow4people.WorkflowDefinition,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@34ac3c11[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@179b9b1b[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: workflowDefinitionInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7db79cfd[name=dateCreated,type=class java.util.Date,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@21a3e686[class org.workflow4people.WorkflowDefinition,dateCreated,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@f7378ab[true]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.dateCreated.label" default="Date Created" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${workflowDefinitionInstance?.dateCreated}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1bddf367[name=lastUpdated,type=class java.util.Date,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@896fd7c[class org.workflow4people.WorkflowDefinition,lastUpdated,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@70dbdc4b[true]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.lastUpdated.label" default="Last Updated" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${workflowDefinitionInstance?.lastUpdated}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@725bf9cf[name=fieldList,type=class org.workflow4people.FieldList,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@746dbfb0[class org.workflow4people.WorkflowDefinition,fieldList,class org.workflow4people.FieldList,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5143f787[false]}] -->
                            <td valign="top" class="name"><g:message code="workflowDefinition.fieldList.label" default="Field List" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="fieldList" action="show" id="${workflowDefinitionInstance?.fieldList?.id}">${workflowDefinitionInstance?.fieldList?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${workflowDefinitionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,workflowDefinitionInstance:workflowDefinitionInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="workflowDefinition.form.label" default="Form" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="form" action="create" params="['workflow.id': workflowDefinitionInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${workflowDefinitionInstance.form}" var="f">
                                <tr>
                                <td>${f?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="form" action="show" id="${f.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="form" action="edit" id="${f.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="form" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="workflowDefinition.workflowPermission.label" default="Workflow Permission" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="workflowPermission" action="create" params="['workflow.id': workflowDefinitionInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${workflowDefinitionInstance.workflowPermission}" var="w">
                                <tr>
                                <td>${w?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="workflowPermission" action="show" id="${w.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="workflowPermission" action="edit" id="${w.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="workflowPermission" action="delete" id="${w.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
