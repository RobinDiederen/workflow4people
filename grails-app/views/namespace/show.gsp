
<%@ page import="org.workflow4people.Namespace" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'namespace.label', default: 'Namespace')}" />
        <title><g:message code="namespace.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="namespace.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,namespaceInstance:namespaceInstance]"/>
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
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: namespaceInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.prefix.label" default="Prefix" /></td>
                         
                            
                            <td valign="top" class="value wide">${namespaceInstance.prefix}</td>
                            
						
                        </tr>
                    
                        <tr class="prop extrawide">
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.uri.label" default="Uri" /></td>
                         
                            
                            <td valign="top" class="value extrawide">${namespaceInstance.uri}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.filename.label" default="Filename" /></td>
                         
                            
                            <td valign="top" class="value wide">${namespaceInstance.filename}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.generateXSDFile.label" default="Generate XSDF ile" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${namespaceInstance?.generateXSDFile}" /></td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.includeSchema.label" default="Include Schema" /></td>
                         
                            
                            <td valign="top" class="value">${namespaceInstance.includeSchema}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            
                            <td valign="top" class="name"><g:message code="namespace.importSchema.label" default="Import Schema" /></td>
                         
                            
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${namespaceInstance.importSchema}" var="i">
                                    <li><g:link controller="namespace" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${namespaceInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,namespaceInstance:namespaceInstance]"/>
            	</g:if>
            </div>
                    <g:hiddenField name="offset" value="${params.offset}" />
                    <g:hiddenField name="sort" value="${params.sort}" />
                    <g:hiddenField name="order" value="${params.order}" />
                    <g:hiddenField name="navigatedFrom" value="show" />
                    <g:hiddenField name="q" value="${params.q}" />
            
            
                </g:form>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
