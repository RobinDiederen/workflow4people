
<%@ page import="org.workflow4people.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,documentInstance:documentInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1913c652[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="document.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@61413e5a[name=documentType,type=class org.workflow4people.DocumentType,persistent=true,optional=false,association=true,bidirectional=false,association-type=one-to-one] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@264b898[class org.workflow4people.Document,documentType,class org.workflow4people.DocumentType,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@22930462[false]}] -->
                            <td valign="top" class="name"><g:message code="document.documentType.label" default="Document Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="documentType" action="show" id="${documentInstance?.documentType?.id}">${documentInstance?.documentType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@11be6f3c[name=documentStatus,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6d78d53d[class org.workflow4people.Document,documentStatus,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@17f7cff1[true]}] -->
                            <td valign="top" class="name"><g:message code="document.documentStatus.label" default="Document Status" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "documentStatus")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@e74e382[name=documentKey,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1c047338[class org.workflow4people.Document,documentKey,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@68286fe6[true]}] -->
                            <td valign="top" class="name"><g:message code="document.documentKey.label" default="Document Key" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "documentKey")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@36ca9a76[name=documentDescription,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2f62d514[class org.workflow4people.Document,documentDescription,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@1932c5a[true]}] -->
                            <td valign="top" class="name"><g:message code="document.documentDescription.label" default="Document Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "documentDescription")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6544c984[name=dateCreated,type=class java.util.Date,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@70a2d0d[class org.workflow4people.Document,dateCreated,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@2d13b417[true]}] -->
                            <td valign="top" class="name"><g:message code="document.dateCreated.label" default="Date Created" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentInstance?.dateCreated}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6894691f[name=lastUpdated,type=class java.util.Date,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@6781a7dc[class org.workflow4people.Document,lastUpdated,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@7133919a[true]}] -->
                            <td valign="top" class="name"><g:message code="document.lastUpdated.label" default="Last Updated" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentInstance?.lastUpdated}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@709c4f85[name=completionDate,type=class java.util.Date,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2628de85[class org.workflow4people.Document,completionDate,class java.util.Date,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@45290155[true]}] -->
                            <td valign="top" class="name"><g:message code="document.completionDate.label" default="Completion Date" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentInstance?.completionDate}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@71696ec[name=processingDays,type=double,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@5c0e6396[class org.workflow4people.Document,processingDays,double,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@34ac3c11[false]}] -->
                            <td valign="top" class="name"><g:message code="document.processingDays.label" default="Processing Days" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "processingDays")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@179b9b1b[name=user,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@68e415b8[class org.workflow4people.Document,user,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@564e18d4[true]}] -->
                            <td valign="top" class="name"><g:message code="document.user.label" default="User" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "user")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@21403290[name=groupId,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@7db79cfd[class org.workflow4people.Document,groupId,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@21a3e686[true]}] -->
                            <td valign="top" class="name"><g:message code="document.groupId.label" default="Group Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "groupId")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@f7378ab[name=cmisFolderObjectId,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@65f72a79[class org.workflow4people.Document,cmisFolderObjectId,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4605a23b[true]}] -->
                            <td valign="top" class="name"><g:message code="document.cmisFolderObjectId.label" default="Cmis Folder Object Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "cmisFolderObjectId")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1bddf367[name=cmisFolderUrl,type=class java.lang.String,persistent=true,optional=true,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@896fd7c[class org.workflow4people.Document,cmisFolderUrl,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@70dbdc4b[true]}] -->
                            <td valign="top" class="name"><g:message code="document.cmisFolderUrl.label" default="Cmis Folder Url" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "cmisFolderUrl")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@725bf9cf[name=xmlDocument,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@746dbfb0[class org.workflow4people.Document,xmlDocument,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@5143f787[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@452fe9bf[false]}] -->
                            <td valign="top" class="name"><g:message code="document.xmlDocument.label" default="Xml Document" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "xmlDocument")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4594a0ad[name=form,type=interface java.util.Set,persistent=true,optional=true,association=true,bidirectional=false,association-type=one-to-many] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@20c0e18b[class org.workflow4people.Document,form,interface java.util.Set,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@57177d79[true]}] -->
                            <td valign="top" class="name"><g:message code="document.form.label" default="Form" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${documentInstance.form}" var="f">
                                    <li><g:link controller="form" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${documentInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,documentInstance:documentInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="document.documentIndex.label" default="Document Index" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="documentIndex" action="create" params="['document.id': documentInstance?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="${documentInstance.documentIndex}" var="d">
                                <tr>
                                <td>${d?.encodeAsHTML()}</td>
                                
                                	<td><g:link class="awesome small blue button" controller="documentIndex" action="show" id="${d.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="documentIndex" action="edit" id="${d.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="documentIndex" action="delete" id="${d.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
