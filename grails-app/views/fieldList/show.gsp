
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
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
                  <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>    
                    
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@415ed7e7[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="fieldList.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldListInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@49fa269b[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@45fcb00e[class org.workflow4people.FieldList,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@508a8b07[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldListInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@37ada1e0[name=namespace,type=class org.workflow4people.Namespace,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@685e95ae[class org.workflow4people.FieldList,namespace,class org.workflow4people.Namespace,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@19b5080a[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.namespace.label" default="Namespace" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="namespace" action="show" id="${fieldListInstance?.namespace?.id}">${fieldListInstance?.namespace?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7e6d3209[name=baseType,type=class org.workflow4people.BaseType,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@32f02db7[class org.workflow4people.FieldList,baseType,class org.workflow4people.BaseType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@36496381[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.baseType.label" default="Base Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="baseType" action="show" id="${fieldListInstance?.baseType?.id}">${fieldListInstance?.baseType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@c23c5ff[name=label,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@9bee93[class org.workflow4people.FieldList,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7d4bf534[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldListInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5cf6930[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7402d14a[class org.workflow4people.FieldList,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@64fa8cc6[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7d304ef4[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldList.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldListInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
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
                </g:form>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            
                            	<tr><th colspan="2"><g:message code="fieldList.field.label" default="Field" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="field" action="create" params="['fieldList.id': fieldListInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                            	 
                            		<tbody  class="sortable" id="field">
                            	
                            	
                                
                                <g:each in="${org.workflow4people.Field.findAllByFieldList(fieldListInstance,[sort:'fieldPosition',order:'asc'])}" var="f">
                                
                                <tr id="position-${f.id}">
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
