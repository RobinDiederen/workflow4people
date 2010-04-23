
<%@ page import="org.workflow4people.DocumentIndex" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentIndex.label', default: 'DocumentIndex')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="document" action="show" id="${documentIndexInstance?.document?.id}">&laquo;&nbsp;Back to Document ${documentIndexInstance?.document?.encodeAsHTML()}</g:link></span>
                            
                                                    
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,documentIndexInstance:documentIndexInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@39165e21[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="documentIndex.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@167a6e84[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@3feda7a3[class org.workflow4people.DocumentIndex,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@b98df1f[false]}] -->
                            <td valign="top" class="name"><g:message code="documentIndex.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6160722b[name=value,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2e796ff[class org.workflow4people.DocumentIndex,value,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@326a40d6[true]}] -->
                            <td valign="top" class="name"><g:message code="documentIndex.value.label" default="Value" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentIndexInstance, field: "value")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5dc6bb75[name=document,type=class org.workflow4people.Document,persistent=true,optional=false,association=true,bidirectional=true,association-type=many-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@223d2e6c[class org.workflow4people.DocumentIndex,document,class org.workflow4people.Document,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@5eb2c603[false]}] -->
                            <td valign="top" class="name"><g:message code="documentIndex.document.label" default="Document" /></td>
                         
                            
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="document" action="show" id="${documentIndexInstance?.document?.id}">${documentIndexInstance?.document?.encodeAsHTML()}</g:link></td>                            


                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${documentIndexInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,documentIndexInstance:documentIndexInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
