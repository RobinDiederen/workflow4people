
<%@ page import="org.workflow4people.Feature" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feature.label', default: 'Feature')}" />
        <title><g:message code="feature.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link params="${filteredParams ? filteredParams : ''}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="feature.list.label" args="[entityName]" /></g:link></span>
                    
				    
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  
                  
                  
                  <span class="button"><g:actionSubmit params="${filteredParams ? filteredParams : ''}" class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                      
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,featureInstance:featureInstance]"/>
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
                         
                            
                            <td valign="top" class="name"><g:message code="feature.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: featureInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="feature.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value wide">${featureInstance.name}</td>
                            
						
                        </tr>
                    
                        <tr class="prop wide">
                         
                            
                            <td valign="top" class="name"><g:message code="feature.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value wide">${featureInstance.title}</td>
                            
						
                        </tr>
                    
                        <tr class="prop extrawide">
                         
                            
                            <td valign="top" class="name"><g:message code="feature.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value extrawide">${featureInstance.description}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="${featureInstance?.id}" />
                      
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	
                  
                  	
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	                     
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,featureInstance:featureInstance]"/>
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
                            
                            	<tr><th colspan="2"><g:message code="feature.featurePermission.label" default="Feature Permission" /></th></tr>
                            	<tr><td><b><g:message code="featurePermission.list.name.label" /></b></td><td>
                            	
                            	
                            	<g:link title ="${message(code: 'featurePermission.list.create.help')}" class="awesome small blue button" controller="featurePermission" action="create" params="['feature.id': featureInstance?.id]"><g:message code="featurePermission.list.new.label" />&nbsp;&raquo;</g:link>
                            	
                            	
                            	</td></tr>
                            	
                           			<tbody  id="featurePermission">                            	
                            	
                            	
                                
                                <g:each in="${org.workflow4people.FeaturePermission.findAllByFeature(featureInstance,[sort:'authority',order:'asc'])}" var="f">
                                
                                <tr id="position-${f.id}">
                                <td>${f?.encodeAsHTML()}</td>
                                	<td>
                                	
                                	<g:link title ="${message(code: 'featurePermission.list.show.help')}" class="awesome small blue button" controller="featurePermission" action="show" id="${f.id}"><g:message code="featurePermission.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	<g:link title ="${message(code: 'featurePermission.list.edit.help')}" class="awesome small blue button" controller="featurePermission" action="edit" id="${f.id}"><g:message code="featurePermission.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	
                                	
                                	
                                	<g:link title ="${message(code: 'featurePermission.list.delete.help')}" class="awesome small red button" controller="featurePermission" action="delete" id="${f.id}" onclick="return confirm('${message(code: 'featurePermission.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                	
                           
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
