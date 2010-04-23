
<%@ page import="org.workflow4people.FieldType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldType.label', default: 'FieldType')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@61413e5a[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="fieldType.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@264b898[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@22930462[class org.workflow4people.FieldType,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6204cfa9[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@29dd9285[name=namespace,type=class org.workflow4people.Namespace,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@11be6f3c[class org.workflow4people.FieldType,namespace,class org.workflow4people.Namespace,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6d78d53d[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.namespace.label" default="Namespace" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="namespace" action="show" id="${fieldTypeInstance?.namespace?.id}">${fieldTypeInstance?.namespace?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@17f7cff1[name=baseType,type=class org.workflow4people.BaseType,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@e74e382[class org.workflow4people.FieldType,baseType,class org.workflow4people.BaseType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1c047338[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.baseType.label" default="Base Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="baseType" action="show" id="${fieldTypeInstance?.baseType?.id}">${fieldTypeInstance?.baseType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@68286fe6[name=baseSchemaType,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@36ca9a76[class org.workflow4people.FieldType,baseSchemaType,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2f62d514[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.baseSchemaType.label" default="Base Schema Type" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "baseSchemaType")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1932c5a[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6544c984[class org.workflow4people.FieldType,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@70a2d0d[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2d13b417[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7133919a[name=defaultValue,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@709c4f85[class org.workflow4people.FieldType,defaultValue,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2628de85[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.defaultValue.label" default="Default Value" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "defaultValue")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@45290155[name=label,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@71696ec[class org.workflow4people.FieldType,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5c0e6396[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@34ac3c11[name=help,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@179b9b1b[class org.workflow4people.FieldType,help,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@68e415b8[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@564e18d4[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.help.label" default="Help" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "help")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@21403290[name=alert,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7db79cfd[class org.workflow4people.FieldType,alert,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@21a3e686[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@f7378ab[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.alert.label" default="Alert" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "alert")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@65f72a79[name=runtimeEditableList,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4605a23b[class org.workflow4people.FieldType,runtimeEditableList,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1bddf367[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.runtimeEditableList.label" default="Runtime Editable List" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.runtimeEditableList}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@896fd7c[name=generateSchemaType,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@70dbdc4b[class org.workflow4people.FieldType,generateSchemaType,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@725bf9cf[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.generateSchemaType.label" default="Generate Schema Type" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.generateSchemaType}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@452fe9bf[name=restrictions,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4c9b1e15[class org.workflow4people.FieldType,restrictions,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5bd41bfd[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.restrictions.label" default="Restrictions" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldTypeInstance?.restrictions}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4279ae24[name=length,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4297df94[class org.workflow4people.FieldType,length,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@d78fb4[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.length.label" default="Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "length")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4594a0ad[name=minLength,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@20c0e18b[class org.workflow4people.FieldType,minLength,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@57177d79[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.minLength.label" default="Min Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "minLength")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6e843edc[name=maxLength,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2c3b1633[class org.workflow4people.FieldType,maxLength,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5b2e84f4[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.maxLength.label" default="Max Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "maxLength")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5b145e2e[name=pattern,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@16334cb9[class org.workflow4people.FieldType,pattern,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1f21112[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.pattern.label" default="Pattern" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "pattern")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3b3eb5bd[name=minInclusive,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@120da9ae[class org.workflow4people.FieldType,minInclusive,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@3efee7c4[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.minInclusive.label" default="Min Inclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "minInclusive")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5122152b[name=maxInclusive,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@149be3aa[class org.workflow4people.FieldType,maxInclusive,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@67fb878[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.maxInclusive.label" default="Max Inclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "maxInclusive")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2b27d19d[name=minExclusive,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4332b08d[class org.workflow4people.FieldType,minExclusive,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@34e51b72[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.minExclusive.label" default="Min Exclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "minExclusive")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2d6cf47f[name=maxExclusive,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4c27d525[class org.workflow4people.FieldType,maxExclusive,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4b1a9732[true]}] -->
                            <td valign="top" class="name"><g:message code="fieldType.maxExclusive.label" default="Max Exclusive" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeInstance, field: "maxExclusive")}</td>
                            
						
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
                    <g:hiddenField name="id" value="${fieldTypeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldTypeInstance:fieldTypeInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="fieldType.fieldTypeItem.label" default="Field Type Item" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="fieldTypeItem" action="create" params="['fieldType.id': fieldTypeInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${fieldTypeInstance.fieldTypeItem}" var="f">
                                <tr>
                                <td>${f?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="fieldTypeItem" action="show" id="${f.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="fieldTypeItem" action="edit" id="${f.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="fieldTypeItem" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
