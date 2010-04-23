<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
                            <span class="menuButton"><g:link class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">&laquo;&nbsp;Back to ${p.naturalName} \${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></span>
                            
                            <%  }  %>                        
                    <%  } 
                    if (!hasManyToOne) {
                    %>
                     	<span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="default.list.label" args="[entityName]" /></g:link></span>                		                        
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
            <g:form action="save" method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <div class="dialog">
                    <table>
                        <tbody>
                        <%  excludedProps = Event.allEvents.toList() << 'version' << 'id'
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
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
                        <%  }   }   } %>
                        </tbody>
                    </table>
                    <%  excludedProps = Event.allEvents.toList() << 'version' << 'id'
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                cp = domainClass.constrainedProperties[p.name]
                                display = (cp ? cp.display : false)                                        
                                if (p.manyToOne&&p.bidirectional&&!display) { 
                                //println "p=${p}"
                                //println "otherside=${p.otherSide}"
                                //println "hasOne=${p.hasOne}"
                                //println "owningSide=${p.owningSide}"
                                //println "otherOwningSide=${p.otherSide.owningSide}"
                                
                                %>
                                
                           	<g:hiddenField name="${p.name}.id" value="\${${propertyName}?.${p.name}?.id}" />
                            
                        <%  }                           
                        } %>        
                    
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="awesome small blue button" value="\${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
