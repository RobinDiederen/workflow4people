
<%@ page import="org.workflow4people.Field" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'field.label', default: 'Field')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">&laquo;&nbsp;Back to Child Field List ${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">&laquo;&nbsp;Back to Field List ${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldInstance:fieldInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2f62d514[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="field.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1932c5a[name=fieldPosition,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6544c984[class org.workflow4people.Field,fieldPosition,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@70a2d0d[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldPosition.label" default="Field Position" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "fieldPosition")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2d13b417[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6894691f[class org.workflow4people.Field,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6781a7dc[false]}] -->
                            <td valign="top" class="name"><g:message code="field.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7133919a[name=fieldType,type=class org.workflow4people.FieldType,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@709c4f85[class org.workflow4people.Field,fieldType,class org.workflow4people.FieldType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2628de85[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldType.label" default="Field Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="fieldType" action="show" id="${fieldInstance?.fieldType?.id}">${fieldInstance?.fieldType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@45290155[name=childFieldList,type=class org.workflow4people.FieldList,persistent=true,optional=true,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@71696ec[class org.workflow4people.Field,childFieldList,class org.workflow4people.FieldList,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5c0e6396[true]}] -->
                            <td valign="top" class="name"><g:message code="field.childFieldList.label" default="Child Field List" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@34ac3c11[name=fieldList,type=class org.workflow4people.FieldList,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@179b9b1b[class org.workflow4people.Field,fieldList,class org.workflow4people.FieldList,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@68e415b8[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldList.label" default="Field List" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@564e18d4[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@21403290[class org.workflow4people.Field,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@7db79cfd[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@21a3e686[false]}] -->
                            <td valign="top" class="name"><g:message code="field.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2116b32[name=defaultValue,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4594a0ad[class org.workflow4people.Field,defaultValue,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@20c0e18b[false]}] -->
                            <td valign="top" class="name"><g:message code="field.defaultValue.label" default="Default Value" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "defaultValue")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@57177d79[name=label,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@472ebf9a[class org.workflow4people.Field,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4e253bf8[false]}] -->
                            <td valign="top" class="name"><g:message code="field.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6e843edc[name=help,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2c3b1633[class org.workflow4people.Field,help,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@5b2e84f4[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4b1addf0[false]}] -->
                            <td valign="top" class="name"><g:message code="field.help.label" default="Help" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "help")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@16334cb9[name=alert,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1f21112[class org.workflow4people.Field,alert,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@3b3eb5bd[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@120da9ae[false]}] -->
                            <td valign="top" class="name"><g:message code="field.alert.label" default="Alert" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "alert")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@3efee7c4[name=contentText,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5122152b[class org.workflow4people.Field,contentText,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@149be3aa[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@67fb878[false]}] -->
                            <td valign="top" class="name"><g:message code="field.contentText.label" default="Content Text" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "contentText")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@34e51b72[name=minOccurs,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2d6cf47f[class org.workflow4people.Field,minOccurs,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4c27d525[true]}] -->
                            <td valign="top" class="name"><g:message code="field.minOccurs.label" default="Min Occurs" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "minOccurs")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@47f6b002[name=maxOccurs,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@149d7837[class org.workflow4people.Field,maxOccurs,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6e3f6d73[true]}] -->
                            <td valign="top" class="name"><g:message code="field.maxOccurs.label" default="Max Occurs" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "maxOccurs")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@62ad191[name=nillable,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@652489c0[class org.workflow4people.Field,nillable,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@41cfd020[false]}] -->
                            <td valign="top" class="name"><g:message code="field.nillable.label" default="Nillable" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldInstance?.nillable}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@61973732[name=dependsOn,type=class org.workflow4people.Field,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@ea8e5ac[class org.workflow4people.Field,dependsOn,class org.workflow4people.Field,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@727e86b8[true]}] -->
                            <td valign="top" class="name"><g:message code="field.dependsOn.label" default="Depends On" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="field" action="show" id="${fieldInstance?.dependsOn?.id}">${fieldInstance?.dependsOn?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@33cf0283[name=dependencyType,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5bae0107[class org.workflow4people.Field,dependencyType,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7cc5a196[true], inList=org.codehaus.groovy.grails.validation.InListConstraint@12f3bed9[[true, false, empty, nonempty, exist, nonexist, gt, lt, eq, ne]]}] -->
                            <td valign="top" class="name"><g:message code="field.dependencyType.label" default="Dependency Type" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "dependencyType")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4076a247[name=dependencyParameter,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2c980461[class org.workflow4people.Field,dependencyParameter,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@30479326[false]}] -->
                            <td valign="top" class="name"><g:message code="field.dependencyParameter.label" default="Dependency Parameter" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "dependencyParameter")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2b0dbc8d[name=customDependencyExpression,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@12d5e310[class org.workflow4people.Field,customDependencyExpression,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@182e3919[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2a6a4b6[false]}] -->
                            <td valign="top" class="name"><g:message code="field.customDependencyExpression.label" default="Custom Dependency Expression" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "customDependencyExpression")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@a87aa16[name=readonly,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@50af8fc0[class org.workflow4people.Field,readonly,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@3606afa2[false]}] -->
                            <td valign="top" class="name"><g:message code="field.readonly.label" default="Readonly" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fieldInstance?.readonly}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@70f4d063[name=securitylevelRead,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@589d4d84[class org.workflow4people.Field,securitylevelRead,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@3f4c428f[false]}] -->
                            <td valign="top" class="name"><g:message code="field.securitylevelRead.label" default="Securitylevel Read" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "securitylevelRead")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@27a5dac0[name=securitylevelReadWrite,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@79bc8795[class org.workflow4people.Field,securitylevelReadWrite,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@486985a3[false]}] -->
                            <td valign="top" class="name"><g:message code="field.securitylevelReadWrite.label" default="Securitylevel Read Write" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "securitylevelReadWrite")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7c4b579[name=xpath,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3661eeb[class org.workflow4people.Field,xpath,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2577d80b[false]}] -->
                            <td valign="top" class="name"><g:message code="field.xpath.label" default="Xpath" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "xpath")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5f08cd64[name=fieldLength,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3ae490fa[class org.workflow4people.Field,fieldLength,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@73ea2b4a[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldLength.label" default="Field Length" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "fieldLength")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${fieldInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldInstance:fieldInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
