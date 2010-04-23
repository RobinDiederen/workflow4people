
<%@ page import="org.workflow4people.MinerQuery" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'minerQuery.label', default: 'MinerQuery')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    
              	<g:if test="${navTemplate}" >
            		<g:render template="${navTemplate}" model="[entityName:entityName,minerQueryInstance:minerQueryInstance]"/>
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
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@29dd9285[name=id,type=class java.lang.Long,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=null -->
                            <td valign="top" class="name"><g:message code="minerQuery.id.label" default="Id" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "id")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6d78d53d[name=name,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@17f7cff1[class org.workflow4people.MinerQuery,name,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@e74e382[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.name.label" default="Name" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "name")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1c047338[name=title,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@68286fe6[class org.workflow4people.MinerQuery,title,class java.lang.String,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@36ca9a76[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.title.label" default="Title" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "title")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6544c984[name=description,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@70a2d0d[class org.workflow4people.MinerQuery,description,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@2d13b417[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@6894691f[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.description.label" default="Description" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "description")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@709c4f85[name=explanationMessage,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@2628de85[class org.workflow4people.MinerQuery,explanationMessage,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@45290155[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@71696ec[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.explanationMessage.label" default="Explanation Message" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "explanationMessage")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5c0e6396[name=query,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@34ac3c11[class org.workflow4people.MinerQuery,query,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@179b9b1b[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@68e415b8[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.query.label" default="Query" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "query")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@564e18d4[name=drilldownQuery,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@21403290[class org.workflow4people.MinerQuery,drilldownQuery,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@7db79cfd[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@21a3e686[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.drilldownQuery.label" default="Drilldown Query" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "drilldownQuery")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@4605a23b[name=drilldownCountQuery,type=class java.lang.String,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@1bddf367[class org.workflow4people.MinerQuery,drilldownCountQuery,class java.lang.String,{size=org.codehaus.groovy.grails.validation.SizeConstraint@896fd7c[0..50000], nullable=org.codehaus.groovy.grails.validation.NullableConstraint@70dbdc4b[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.drilldownCountQuery.label" default="Drilldown Count Query" /></td>
                         
                            
                            <td valign="top" class="value">${fieldValue(bean: minerQueryInstance, field: "drilldownCountQuery")}</td>
                            
						
                        </tr>
                    
                        <tr class="prop">
                         
                            <!-- p=org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@5143f787[name=calculateTotals,type=boolean,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>] cp=org.codehaus.groovy.grails.validation.ConstrainedProperty@452fe9bf[class org.workflow4people.MinerQuery,calculateTotals,boolean,{nullable=org.codehaus.groovy.grails.validation.NullableConstraint@4c9b1e15[false]}] -->
                            <td valign="top" class="name"><g:message code="minerQuery.calculateTotals.label" default="Calculate Totals" /></td>
                         
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${minerQueryInstance?.calculateTotals}" /></td>
                            
						
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${minerQueryInstance?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="${buttonsTemplate}" >
            			<g:render template="${buttonsTemplate}" model="[entityName:entityName,minerQueryInstance:minerQueryInstance]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
                        
                            
                                                    
                    
            
            
            
            
            
            
        </div>
    </body>
</html>
