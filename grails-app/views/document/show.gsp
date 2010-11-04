
<%@ page import="org.workflow4people.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
        <title><g:message code="document.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="document.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
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
                         
                            
                            <td valign="top" class="name"><g:message code="document.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.documentType.label" default="Document Type" /></td>
                         
                            
                           	<td valign="top" class="value"><g:link controller="documentType" action="show" id="${documentInstance?.documentType?.id}">${documentInstance?.documentType?.encodeAsHTML()}</g:link></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.documentStatus.label" default="Document Status" /></td>
                         
                            
                            <td valign="top" class="value">${documentInstance.documentStatus}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.documentKey.label" default="Document Key" /></td>
                         
                            
                            <td valign="top" class="value">${documentInstance.documentKey}</td>
                            
						
                        </tr>
                    
                        <tr class="prop extrawide">
                         
                            
                            <td valign="top" class="name"><g:message code="document.documentDescription.label" default="Document Description" /></td>
                         
                            
                            <td valign="top" class="value extrawide">${documentInstance.documentDescription}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.dateCreated.label" default="Date Created" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentInstance?.dateCreated}" /></td>
                            
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.lastUpdated.label" default="Last Updated" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentInstance?.lastUpdated}" /></td>
                            
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.completionDate.label" default="Completion Date" /></td>
                         
                            
                            <td valign="top" class="value">
                            
                            <g:formatDate format="yyyy-MM-dd'T'HH:mm:ss" date="${documentInstance?.completionDate}" /></td>
                            
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.processingDays.label" default="Processing Days" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "processingDays")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.user.label" default="User" /></td>
                         
                            
                            <td valign="top" class="value">${documentInstance.user}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.groupId.label" default="Group Id" /></td>
                         
                            
                            <td valign="top" class="value">${documentInstance.groupId}</td>
                            
						
                        </tr>
                    
                        <tr class="prop extrawide">
                         
                            
                            <td valign="top" class="name"><g:message code="document.cmisFolderObjectId.label" default="Cmis Folder Object Id" /></td>
                         
                            
                            <td valign="top" class="value extrawide">${documentInstance.cmisFolderObjectId}</td>
                            
						
                        </tr>
                    
                        <tr class="prop extrawide">
                         
                            
                            <td valign="top" class="name"><g:message code="document.cmisFolderUrl.label" default="Cmis Folder Url" /></td>
                         
                            
                            <td valign="top" class="value extrawide">${documentInstance.cmisFolderUrl}</td>
                            
						
                        </tr>
                    
                        <tr class="prop extrawide">
                         
                            
                            <td valign="top" class="name"><g:message code="document.xmlDocument.label" default="Xml Document" /></td>
                         
                            
                            <td valign="top" class="value extrawide">${documentInstance.xmlDocument}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="document.form.label" default="Form" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${documentInstance.form}" var="f">
                                    <li><g:link controller="form" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${documentInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,documentInstance:documentInstance]"/>
            	</g:if>
            </div>
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
                    <g:hiddenField name="navigatedFrom" value="show" />
                    <g:hiddenField name="q" value="${params.q}" />
            
            
                </g:form>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                            
                            <div class="list">
                            <table>
                            
                            	<tr><th colspan="2"><g:message code="document.documentIndex.label" default="Document Index" /></th></tr>
                            	<tr><td><b><g:message code="documentIndex.list.name.label" /></b></td><td>
                            	
                            	
                            	<g:link title ="${message(code: 'documentIndex.list.create.help')}" class="awesome small blue button" controller="documentIndex" action="create" params="['document.id': documentInstance?.id]"><g:message code="documentIndex.list.new.label" />&nbsp;&raquo;</g:link>
                            	
                            	
                            	</td></tr>
                            	
                           			<tbody  id="documentIndex">                            	
                            	
                            	
                                
                                <g:each in="${org.workflow4people.DocumentIndex.findAllByDocument(documentInstance,[sort:'id',order:'asc'])}" var="d">
                                
                                <tr id="position-${d.id}">
                                <td>${d?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'documentIndex.list.show.help')}" class="awesome small blue button" controller="documentIndex" action="show" id="${d.id}"><g:message code="documentIndex.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'documentIndex.list.edit.help')}" class="awesome small blue button" controller="documentIndex" action="edit" id="${d.id}"><g:message code="documentIndex.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'documentIndex.list.delete.help')}" class="awesome small red button" controller="documentIndex" action="delete" id="${d.id}" onclick="return confirm('${message(code: 'documentIndex.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
