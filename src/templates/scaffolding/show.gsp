<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <div class="nav">
            	<%  excludedProps = Event.allEvents.toList() << 'version'
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        def hasManyToOne=false
                        props.each { p -> 
                        cp = domainClass.constrainedProperties[p.name]                        
                        %>
                        
                            
                            <%  if (p.manyToOne ) { 
                                hasManyToOne=true
                            %>
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">&laquo;&nbsp;Back to ${p.naturalName} \${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></span>
                            
                            <%  }  %>                        
                    <%  } 
                    if (!hasManyToOne) {
                    %>
                		<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>
            			<span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="default.new.label" args="[entityName]" />&nbsp;+</g:link></span>                        
                    <%
                    }
                    
                    %>
              	<g:if test="\${navTemplate}" >
            		<g:render template="\${navTemplate}" model="[entityName:entityName,${propertyName}:${propertyName}]"/>
            	</g:if>
        	</div>
           
            <g:if test="\${flash.message}">
                        <div class="message">
            <g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}"/>
            </div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    <%  excludedProps = Event.allEvents.toList() << 'version'
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> 
                        cp = domainClass.constrainedProperties[p.name]
                        %>
                        <tr class="prop">
                         <% if (!(p.oneToMany && p.bidirectional)&&p.isPersistent()&&p.type!=java.lang.Object) { %>
                            <!-- p=${p} cp=${cp} -->
                            <td valign="top" class="name"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></td>
                         
                            <%  if (p.isEnum()) { %>
                            <td valign="top" class="value">\${${propertyName}?.${p.name}?.encodeAsHTML()}</td>
                            <%  } else if (p.manyToMany) { %>
	                             <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            <%  } else if (p.oneToOne) { %>
                           	<td valign="top" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>
                            <%  } else if (p.manyToOne||(p.oneToMany && p.bidirectional)) { %>
                            <!-- manyToOne and oneToMany are shown again -->
  							<td valign="top" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>                            


                            <%  } else if (p.oneToMany&&!p.bidirectional) { %>
                              <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            <%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <td valign="top" class="value"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></td>
                            <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                            <td valign="top" class="value">
                            <% def dateFormat=cp.format?cp.format:"yyyy-MM-dd'T'HH:mm:ss" %>
                            <g:formatDate format="${dateFormat}" date="\${${propertyName}?.${p.name}}" /></td>
                            <%  } else { %>
                            <td valign="top" class="value">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                            <%  } %>
						<% } %>
                        </tr>
                    <%  } %>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <g:if test="\${buttonsTemplate}" >
            			<g:render template="\${buttonsTemplate}" model="[entityName:entityName,${propertyName}:${propertyName}]"/>
            	</g:if>
                </g:form>
            </div>
            
            
            <%  excludedProps = Event.allEvents.toList() << 'version'
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> 
                        cp = domainClass.constrainedProperties[p.name]
                        %>
                        
                            
                            <%  if (p.oneToMany && p.bidirectional) { %>
                            <div class="list">
                            <table>
                            <tbody>
                            	<tr><th colspan="2"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th></tr>
                            	<tr><td><b>Name</b></td><td><g:link class="awesome small blue button" controller="${p.referencedDomainClass.propertyName}" action="create" params="['${p.referencedPropertyName}.id': ${propertyName}?.id]">new&nbsp;&raquo</g:link></td></tr>
                                <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                <tr>
                                <td>\${${p.name[0]}?.encodeAsHTML()}</td>
                                <% if ("insert"==cp.widget) { %>
                                	<td><g:link class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="edit" id="\${${p.name[0]}.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="${p.referencedDomainClass.propertyName}" action="insert" params="['${p.domainClass.propertyName}.id': ${propertyName}?.id,'${p.referencedDomainClass?.propertyName}.id':${p.name[0]}.id]">insert&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="${p.referencedDomainClass?.propertyName}" action="delete" id="\${${p.name[0]}.id}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                <% } else { %>
                                	<td><g:link class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">show&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="edit" id="\${${p.name[0]}.id}">edit&nbsp;&raquo;</g:link>&nbsp;<g:link class="awesome small red button" controller="${p.referencedDomainClass?.propertyName}" action="delete" id="\${${p.name[0]}.id}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
                                <% } %>
                                </tr>
                                </g:each>
                            
                            </tbody>
                            </table>
                            </div>
                            <%  }  %>                        
                    <%  } %>
            
            
            
            
            
            
        </div>
    </body>
</html>
