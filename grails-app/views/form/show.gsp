
<%@ page import="org.workflow4people.Form" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="workflowDefinition" action="show" id="${formInstance?.workflow?.id}">&laquo;&nbsp;Back to Workflow ${formInstance?.workflow?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@50ec2522[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="form.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3f7a04af[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@63c99db7[class org.workflow4people.Form,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@49918c8f[false]}] -->
                            <td valign="top" class="name"><g:message code="form.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@789ff411[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4d50c5f5[class org.workflow4people.Form,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@71f47f7a[false]}] -->
                            <td valign="top" class="name"><g:message code="form.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6add5d08[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6b06ef07[class org.workflow4people.Form,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@1436eb76[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@219c9a58[false]}] -->
                            <td valign="top" class="name"><g:message code="form.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@23bfa3a2[name=explanationMessage,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7a8ff303[class org.workflow4people.Form,explanationMessage,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@9b88d2[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6333934d[false]}] -->
                            <td valign="top" class="name"><g:message code="form.explanationMessage.label" default="Explanation Message" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "explanationMessage")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@34afa071[name=confirmationMessage,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@764e75bc[class org.workflow4people.Form,confirmationMessage,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@1913c652[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@61413e5a[false]}] -->
                            <td valign="top" class="name"><g:message code="form.confirmationMessage.label" default="Confirmation Message" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "confirmationMessage")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6204cfa9[name=template,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@29dd9285[class org.workflow4people.Form,template,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@11be6f3c[false]}] -->
                            <td valign="top" class="name"><g:message code="form.template.label" default="Template" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: formInstance, field: "template")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6d78d53d[name=fieldList,type=class org.workflow4people.FieldList,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@17f7cff1[class org.workflow4people.Form,fieldList,class org.workflow4people.FieldList,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@e74e382[false]}] -->
                            <td valign="top" class="name"><g:message code="form.fieldList.label" default="Field List" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="fieldList" action="show" id="${formInstance?.fieldList?.id}">${formInstance?.fieldList?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1c047338[name=formAction,type=class org.workflow4people.Action,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@68286fe6[class org.workflow4people.Form,formAction,class org.workflow4people.Action,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@36ca9a76[false]}] -->
                            <td valign="top" class="name"><g:message code="form.formAction.label" default="Form Action" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="action" action="show" id="${formInstance?.formAction?.id}">${formInstance?.formAction?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2f62d514[name=workflow,type=class org.workflow4people.WorkflowDefinition,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1932c5a[class org.workflow4people.Form,workflow,class org.workflow4people.WorkflowDefinition,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6544c984[false]}] -->
                            <td valign="top" class="name"><g:message code="form.workflow.label" default="Workflow" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="workflowDefinition" action="show" id="${formInstance?.workflow?.id}">${formInstance?.workflow?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${formInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,formInstance:formInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="form.formItem.label" default="Form Item" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="formItem" action="create" params="['form.id': formInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${formInstance.formItem}" var="f">
                                <tr>
                                <td>${f?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="formItem" action="show" id="${f.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="formItem" action="edit" id="${f.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="formItem" action="insert" params="['form.id': formInstance?.id,'formItem.id':f.id]">insert&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="formItem" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
