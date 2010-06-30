<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="${domainClass.propertyName}.insert.title" /></title>
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
                            <span class="menuButton"><g:link class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">&laquo;&nbsp; ${p.naturalName} \${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></span>
                            
                            <%  }  %>                        
                    <%  } 
                    if (!hasManyToOne) {
                    %>
                		<span class="menuButton">&laquo;&nbsp;<g:link class="awesome small blue button" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                <g:hiddenField name="version" value="\${${propertyName}?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        <%  excludedProps = Event.allEvents.toList() << 'version' << 'id'
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                cp = domainClass.constrainedProperties[p.name]
                                display = (cp ? cp.display : true)
								// was if (p.manyToOne||(p.oneToMany&&p.bidirectional)) display=false
								if ((p.oneToMany&&p.bidirectional)|!p.isPersistent()|p.type==java.lang.Object)display=false								       

                                if (display) { %>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
                                </td>
                                <td valign="top" class="value \${hasErrors(bean: ${propertyName}, field: '${p.name}', 'errors')}">
                                    ${renderEditor(p)}
                                </td>
                            </tr>
                        <%  }                           
                        } %>                        
                        </tbody>
                    </table>
                        <%  excludedProps = Event.allEvents.toList() << 'version' << 'id'
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                cp = domainClass.constrainedProperties[p.name]
                                display = (cp ? cp.display : true)                                        
                                 
                                if (p.manyToOne&&p.bidirectional&&!display)  
                                {                                 
                                
                                %>
                           	<g:hiddenField name="${p.name}.id" value="\${${propertyName}?.${p.name}?.id}" />
                            
                        <%  }                           
                        } %>                    
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="awesome small blue button" action="insertsave" value="\${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="awesome small red button" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
