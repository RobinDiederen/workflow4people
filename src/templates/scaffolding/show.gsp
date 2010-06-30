<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="${domainClass.propertyName}.show.title" /></title>
    </head>
    <body>

        <div class="body">
                        <g:form>
        
            <div class="nav">
            	<%      def features = domainClass.getPropertyValue('scaffoldFeatures')
            			excludedProps = Event.allEvents.toList() << 'version'
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        def hasManyToOne=false
                        props.each { p -> 
                        cp = domainClass.constrainedProperties[p.name]                        
                        %>
                        
                            
                            <%  if (p.manyToOne ) { 
                                hasManyToOne=true
                            %>
                            <span class="menuButton"><g:link class="awesome small blue button"  controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">&laquo;&nbsp; \${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></span>
                            
                            <%  }  %>                        
                    <%  } 
                    if (!hasManyToOne) {
                    %>
                		<span class="menuButton"><g:link  params="\${filteredParams}" class="awesome small blue button" action="list">&laquo;&nbsp;<g:message code="${domainClass.propertyName}.list.label" args="[entityName]" /></g:link></span>
                    <%
                    }
                    
                    %>
				  <% if (!features?.contains("noEdit")) { %>  
                  <span class="button"><g:actionSubmit params="\${filteredParams}" class="awesome small blue button"  action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  <% } %>
                  
                  <% if (!features?.contains("noDelete")) { %>
                  <span class="button"><g:actionSubmit params="\${filteredParams}" class="awesome small red button"  action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  <% } %>    
                    
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
                        def header = (cp ? cp.getMetaConstraintValue("header") : null)
                        def classValue = (cp ? " "+cp.getMetaConstraintValue("class") : "")
                        classValue = classValue!=" null" ? classValue : ""
                        if (header) { 
                        	%>
                           	<tr class="prop header${classValue}"><td class="header" colspan="2"><g:message code="${domainClass.propertyName}.${p.name}.header" default="${header}" /></td></tr>                               
                        	<%
                        }
                        %>
                        <tr class="prop${classValue}">
                         <% 
                         	def displayFieldFlag = (cp ? cp.display : false)
                         	if ((!(p.oneToMany && p.bidirectional)&&p.isPersistent()&&p.type!=java.lang.Object)|| displayFieldFlag) { %>
                            
                            <td valign="top" class="name"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></td>
                         
                            <%  if (p.isEnum()) { %>
                            <td valign="top" class="value">\${${propertyName}?.${p.name}?.encodeAsHTML()}</td>
                            <%  } else if (p.manyToMany) { %>
	                             <td valign="top" style="text-align: left;" class="value${classValue}">
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
  							<td valign="top" class="value${classValue}"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>                            


                            <%  } else if (p.oneToMany&&!p.bidirectional) { %>
                              <td valign="top" style="text-align: left;" class="value${classValue}">
                                <ul>
                                <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                           
                           
                            <%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <td valign="top" class="value${classValue}"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></td>
                            <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                            <td valign="top" class="value${classValue}">
                            <% def dateFormat=cp.format?cp.format:"yyyy-MM-dd'T'HH:mm:ss" %>
                            <g:formatDate format="${dateFormat}" date="\${${propertyName}?.${p.name}}" /></td>
                            
                            <%  } else if (p.type == String.class ) { %>
                            <td valign="top" class="value${classValue}">\${${propertyName}.${p.name}}</td>
                            <%  } else { %>
                            <td valign="top" class="value${classValue}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                            <%  } %>
						<% } %>
                        </tr>
                    <%  } %>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                    <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                    <% if (!features?.contains("noEdit")) { %>  
                    <span class="button"><g:actionSubmit class="awesome small blue button"  action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                  	<% } %>
                  
                  	<% if (!features?.contains("noDelete")) { %>
                    <span class="button"><g:actionSubmit class="awesome small red button"  action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                  	<% } %>                     
                    <g:if test="\${buttonsTemplate}" >
            			<g:render template="\${buttonsTemplate}" model="[entityName:entityName,${propertyName}:${propertyName}]"/>
            	</g:if>
            </div>
                    <g:hiddenField name="offset" value="\${params.offset}" />
                    <g:hiddenField name="sort" value="\${params.sort}" />
                    <g:hiddenField name="order" value="\${params.order}" />
                    <g:hiddenField name="navigatedFrom" value="show" />
                    <g:hiddenField name="q" value="\${params.q}" />
            
            
                </g:form>
            
            
            <%  excludedProps = Event.allEvents.toList() << 'version'
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> 
                        cp = domainClass.constrainedProperties[p.name]
                        def sortable = (cp ? cp.getMetaConstraintValue("sortable") : false)
                        def sort = (cp ? cp.getMetaConstraintValue("sort") : 'position')
                        def sortOrder = (cp ? cp.getMetaConstraintValue("sortOrder") : 'asc')
                        def showFlag = (cp ? cp.getMetaConstraintValue("show") : true)
                        def editFlag = (cp ? cp.getMetaConstraintValue("edit") : true)
                        def deleteFlag = (cp ? cp.getMetaConstraintValue("delete") : true)
                        def createFlag = (cp ? cp.getMetaConstraintValue("create") : true)
                        def insertFlag = (cp ? cp.getMetaConstraintValue("insert") : true)
                        %>
                        
                            
                            <%  if (p.oneToMany && p.bidirectional) { %>
                            <div class="list">
                            <table>
                            
                            	<tr><th colspan="2"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th></tr>
                            	<tr><td><b><g:message code="${p.referencedDomainClass.propertyName}.list.name.label" /></b></td><td>
                            	
                            	<% if (createFlag) { %>
                            	<g:link title ="\${message(code: '${p.referencedDomainClass.propertyName}.list.create.help')}" class="awesome small blue button" controller="${p.referencedDomainClass.propertyName}" action="create" params="['${p.referencedPropertyName}.id': ${propertyName}?.id]"><g:message code="${p.referencedDomainClass.propertyName}.list.new.label" />&nbsp;&raquo;</g:link>
                            	<% } %>
                            	
                            	</td></tr>
                            	<% if (sortable) { %> 
                            		<tbody  class="sortable" id="${p.name}">
                            	<%  } else { %>
                           			<tbody  id="${p.name}">                            	
                            	<% } %>
                            	
                                
                                <g:each in="\${${p.referencedDomainClass.fullName}.findAllBy${p.otherSide.name[0].toUpperCase()+p.otherSide.name.substring(1)}(${domainClass.propertyName}Instance,[sort:'${sort}',order:'${sortOrder}'])}" var="${p.name[0]}">
                                
                                <tr id="position-\${${p.name[0]}.id}">
                                <td>\${${p.name[0]}?.encodeAsHTML()}</td>
                                	<td>
                                	<% if (showFlag) { %>
                                	<g:link title ="\${message(code: '${p.referencedDomainClass.propertyName}.list.show.help')}" class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}"><g:message code="${p.referencedDomainClass?.propertyName}.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	<% } %>
                                	<% if (editFlag) { %>
                                	<g:link title ="\${message(code: '${p.referencedDomainClass.propertyName}.list.edit.help')}" class="awesome small blue button" controller="${p.referencedDomainClass?.propertyName}" action="edit" id="\${${p.name[0]}.id}"><g:message code="${p.referencedDomainClass?.propertyName}.list.edit.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	<% } %>
                                	<% if (insertFlag) { %>
                                	<g:link title ="\${message(code: '${p.referencedDomainClass.propertyName}.list.insert.help')}" class="awesome small blue button" controller="${p.referencedDomainClass.propertyName}" action="insert" params="['${p.domainClass.propertyName}.id': ${propertyName}?.id,'${p.referencedDomainClass?.propertyName}.id':${p.name[0]}.id]"><g:message code="${p.referencedDomainClass?.propertyName}.list.insert.label" />&nbsp;&raquo;</g:link>&nbsp;
                                	<% } %>
                                	<% if (deleteFlag) { %>
                                	<g:link title ="\${message(code: '${p.referencedDomainClass.propertyName}.list.delete.help')}" class="awesome small red button" controller="${p.referencedDomainClass?.propertyName}" action="delete" id="\${${p.name[0]}.id}" onclick="return confirm('\${message(code: '${p.referencedDomainClass?.propertyName}.button.delete.confirm.message', default: 'Are you sure?')}');">X</g:link></td>
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
