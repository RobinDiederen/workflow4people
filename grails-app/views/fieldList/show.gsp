
<%@ page import="org.workflow4people.FieldList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldList.label', default: 'FieldList')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3f7a04af[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="fieldList.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@72a32604[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@35150b68[class org.workflow4people.FieldList,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@789ff411[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4d50c5f5[name=namespace,type=class org.workflow4people.Namespace,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@71f47f7a[class org.workflow4people.FieldList,namespace,class org.workflow4people.Namespace,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6add5d08[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.namespace.label" default="Namespace" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="namespace" action="show" id="${fieldListInstance?.namespace?.id}">${fieldListInstance?.namespace?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@219c9a58[name=baseType,type=class org.workflow4people.BaseType,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@305918a5[class org.workflow4people.FieldList,baseType,class org.workflow4people.BaseType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2961116f[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.baseType.label" default="Base Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="baseType" action="show" id="${fieldListInstance?.baseType?.id}">${fieldListInstance?.baseType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@23bfa3a2[name=label,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7a8ff303[class org.workflow4people.FieldList,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@9b88d2[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6333934d[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4f0bd71c[class org.workflow4people.FieldList,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@125797cf[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@34afa071[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "description")}</td>
                            
						
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
                <g:form>
                    <g:hiddenField name="id" value="${fieldListInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldListInstance:fieldListInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="fieldList.field.label" default="Field" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="field" action="create" params="['fieldList.id': fieldListInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${fieldListInstance.field}" var="f">
                                <tr>
                                <td>${f?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="field" action="show" id="${f.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="field" action="edit" id="${f.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="field" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
