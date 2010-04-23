
<%@ page import="org.workflow4people.FieldTypeItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fieldTypeItem.label', default: 'FieldTypeItem')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="fieldType" action="show" id="${fieldTypeItemInstance?.fieldType?.id}">&laquo;&nbsp;Back to Field Type ${fieldTypeItemInstance?.fieldType?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,fieldTypeItemInstance:fieldTypeItemInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@72a32604[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="fieldTypeItem.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeItemInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6add5d08[name=itemPosition,type=int,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6b06ef07[class org.workflow4people.FieldTypeItem,itemPosition,int,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1436eb76[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldTypeItem.itemPosition.label" default="Item Position" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeItemInstance, field: "itemPosition")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@219c9a58[name=label,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@305918a5[class org.workflow4people.FieldTypeItem,label,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2961116f[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldTypeItem.label.label" default="Label" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeItemInstance, field: "label")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@23bfa3a2[name=value,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7a8ff303[class org.workflow4people.FieldTypeItem,value,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@9b88d2[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldTypeItem.value.label" default="Value" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: fieldTypeItemInstance, field: "value")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@125797cf[name=fieldType,type=class org.workflow4people.FieldType,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@34afa071[class org.workflow4people.FieldTypeItem,fieldType,class org.workflow4people.FieldType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@764e75bc[false]}] -->
                            <td valign="top" class="name"><g:message code="fieldTypeItem.fieldType.label" default="Field Type" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="fieldType" action="show" id="${fieldTypeItemInstance?.fieldType?.id}">${fieldTypeItemInstance?.fieldType?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${fieldTypeItemInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,fieldTypeItemInstance:fieldTypeItemInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
