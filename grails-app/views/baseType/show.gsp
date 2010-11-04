
<%@ page import="org.workflow4people.BaseType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'baseType.label', default: 'BaseType')}" />
        <title><g:message code="baseType.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="baseType.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,baseTypeInstance:baseTypeInstance]"/>
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
                         
                            
                            <td valign="top" class="name"><g:message code="baseType.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: baseTypeInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="baseType.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value wide">${baseTypeInstance.name}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="baseType.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value wide">${baseTypeInstance.description}</td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${baseTypeInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,baseTypeInstance:baseTypeInstance]"/>
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
