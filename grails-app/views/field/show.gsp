
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
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">&laquo;&nbsp;Back to Child Field List ${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">&laquo;&nbsp;Back to Field List ${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                  <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>    
                    
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@b3864d9[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="field.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@2364e850[name=fieldPosition,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@35cfee57[class org.workflow4people.Field,fieldPosition,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6628ad5a[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldPosition.label" default="Field Position" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "fieldPosition")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@788d241b[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7a3da671[class org.workflow4people.Field,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@657a8369[false]}] -->
                            <td valign="top" class="name"><g:message code="field.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4e49968b[name=fieldType,type=class org.workflow4people.FieldType,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@413aa7d4[class org.workflow4people.Field,fieldType,class org.workflow4people.FieldType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@71e070c0[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldType.label" default="Field Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="fieldType" action="show" id="${fieldInstance?.fieldType?.id}">${fieldInstance?.fieldType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@460a87a8[name=childFieldList,type=class org.workflow4people.FieldList,persistent=true,optional=true,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5d504a84[class org.workflow4people.Field,childFieldList,class org.workflow4people.FieldList,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@424c4ff8[true]}] -->
                            <td valign="top" class="name"><g:message code="field.childFieldList.label" default="Child Field List" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value null"><g:link controller="fieldList" action="show" id="${fieldInstance?.childFieldList?.id}">${fieldInstance?.childFieldList?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@201644c9[name=fieldList,type=class org.workflow4people.FieldList,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@15fdf894[class org.workflow4people.Field,fieldList,class org.workflow4people.FieldList,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@54cac7d3[false]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldList.label" default="Field List" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value null"><g:link controller="fieldList" action="show" id="${fieldInstance?.fieldList?.id}">${fieldInstance?.fieldList?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4d051922[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@9b52eaf[class org.workflow4people.Field,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@560be823[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@27b57df7[false]}] -->
                            <td valign="top" class="name"><g:message code="field.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@630bd3f1[name=defaultValue,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1d87a604[class org.workflow4people.Field,defaultValue,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@34a45fc1[true]}] -->
                            <td valign="top" class="name"><g:message code="field.defaultValue.label" default="Default Value" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "defaultValue")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@138a92e7[name=label,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6eb285b6[class org.workflow4people.Field,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@a68a881[false]}] -->
                            <td valign="top" class="name"><g:message code="field.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5d0eb27d[name=help,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6fe85c45[class org.workflow4people.Field,help,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1ef69[true], size=org.codehaus.groovy.grails.validation.SizeConstraint@7f0cd67f[0..50000]}] -->
                            <td valign="top" class="name"><g:message code="field.help.label" default="Help" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "help")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@23d66d03[name=alert,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@528ef256[class org.workflow4people.Field,alert,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@26c81672[true], size=org.codehaus.groovy.grails.validation.SizeConstraint@1a39aa42[0..50000]}] -->
                            <td valign="top" class="name"><g:message code="field.alert.label" default="Alert" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "alert")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@377b55e6[name=fieldLength,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2448b7f[class org.workflow4people.Field,fieldLength,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@62224002[true]}] -->
                            <td valign="top" class="name"><g:message code="field.fieldLength.label" default="Field Length" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "fieldLength")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7d9e1b2f[name=contentText,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@170aeb17[class org.workflow4people.Field,contentText,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4dd03ed2[true], size=org.codehaus.groovy.grails.validation.SizeConstraint@22cc74e7[0..50000]}] -->
                            <td valign="top" class="name"><g:message code="field.contentText.label" default="Content Text" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "contentText")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@294692c9[name=minOccurs,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@584edf4a[class org.workflow4people.Field,minOccurs,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2225a091[true]}] -->
                            <td valign="top" class="name"><g:message code="field.minOccurs.label" default="Min Occurs" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "minOccurs")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5450a11a[name=maxOccurs,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7980dd34[class org.workflow4people.Field,maxOccurs,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7b3abf3d[true]}] -->
                            <td valign="top" class="name"><g:message code="field.maxOccurs.label" default="Max Occurs" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "maxOccurs")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5f00fa88[name=nillable,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@39402772[class org.workflow4people.Field,nillable,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@22ddcabb[false]}] -->
                            <td valign="top" class="name"><g:message code="field.nillable.label" default="Nillable" /></td>
                         
                            
                            <td valign="top" class="value null"><g:formatBoolean boolean="${fieldInstance?.nillable}" /></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@383bdcbc[name=dependsOn,type=class org.workflow4people.Field,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6218d77b[class org.workflow4people.Field,dependsOn,class org.workflow4people.Field,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4ceafe8d[true]}] -->
                            <td valign="top" class="name"><g:message code="field.dependsOn.label" default="Depends On" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="field" action="show" id="${fieldInstance?.dependsOn?.id}">${fieldInstance?.dependsOn?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@57ee026e[name=dependencyType,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@4ae1b0db[class org.workflow4people.Field,dependencyType,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@27222045[true], inList=org.codehaus.groovy.grails.validation.InListConstraint@3174a615[[true, false, empty, nonempty, exist, nonexist, gt, lt, eq, ne]]}] -->
                            <td valign="top" class="name"><g:message code="field.dependencyType.label" default="Dependency Type" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "dependencyType")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6143c610[name=dependencyParameter,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@28807653[class org.workflow4people.Field,dependencyParameter,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@9d857eb[true]}] -->
                            <td valign="top" class="name"><g:message code="field.dependencyParameter.label" default="Dependency Parameter" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "dependencyParameter")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5a740a59[name=customDependencyExpression,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@78538773[class org.workflow4people.Field,customDependencyExpression,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@33e1ccbc[true], size=org.codehaus.groovy.grails.validation.SizeConstraint@2d486540[0..50000]}] -->
                            <td valign="top" class="name"><g:message code="field.customDependencyExpression.label" default="Custom Dependency Expression" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "customDependencyExpression")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6bef63f9[name=readonly,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@318ca7cb[class org.workflow4people.Field,readonly,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@95c19d7[false]}] -->
                            <td valign="top" class="name"><g:message code="field.readonly.label" default="Readonly" /></td>
                         
                            
                            <td valign="top" class="value null"><g:formatBoolean boolean="${fieldInstance?.readonly}" /></td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7da4770d[name=securitylevelRead,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@388436ec[class org.workflow4people.Field,securitylevelRead,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7031dcf0[false]}] -->
                            <td valign="top" class="name"><g:message code="field.securitylevelRead.label" default="Securitylevel Read" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "securitylevelRead")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@59a04a1b[name=securitylevelReadWrite,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2a616095[class org.workflow4people.Field,securitylevelReadWrite,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5f0bebef[false]}] -->
                            <td valign="top" class="name"><g:message code="field.securitylevelReadWrite.label" default="Securitylevel Read Write" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "securitylevelReadWrite")}</td>
                            
						
                        </tr>
                    
                        <tr class=" nullprop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@7aec8a9[name=xpath,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@63f7d32f[class org.workflow4people.Field,xpath,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2349e5ef[true]}] -->
                            <td valign="top" class="name"><g:message code="field.xpath.label" default="Xpath" /></td>
                         
                            
                            <td valign="top" class="value null">${fieldValue(bean: fieldInstance, field: "xpath")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${fieldInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldInstance:fieldInstance]"/>
            	</g:if>
            </div>
                </g:form>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
