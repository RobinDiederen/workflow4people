<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="${domainClass.propertyName}.list.title" /></title>
    </head>
    <body>
        
        <div class="body">
        <div class="nav">
        <%
              def features = domainClass.getPropertyValue('scaffoldFeatures')
              if (!features?.contains("noCreate")) { %>
            <span class="menuButton"><g:link class="awesome small blue button" action="create"><g:message code="${domainClass.propertyName}.new.label"  /></g:link></span>
            <% } %>
         	<g:if test="\${searchTemplate}" >
        		<g:render template="\${searchTemplate}" model="[entityName:entityName,${propertyName}:${propertyName}]"/>
        	</g:if>
        </div>
            
            <g:if test="\${flash.message}">
            <div class="message">
            <g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}"/>
            </div>
            </g:if>
            
            <%            
              if (features?.contains("search")) { %>
              <div class="search">
                <g:form method="post" >
              <g:textField name="q" value="\${q}" />
              <g:actionSubmit class="awesome small blue button" action="search" value="\${message(code: 'default.list.search.label', default: 'Search!')}" />              
              
              </g:form>
              </div>
                <%
            	}
            %>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        <%  excludedProps = Event.allEvents.toList() << 'version'
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) && it.type != Set.class }
                            def pl = domainClass.getPropertyValue('listProperties')
                            if (pl) {
                            	props=[]
                            	pl.each { propName ->
                            		props+=domainClass.getPropertyByName(propName)
                            	}
                            } else {
                             	Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            	tmpProps=[]
                            	props.eachWithIndex { p, i ->
                            	if (i<6)                            	
                            		tmpProps+=p
                           		}
                            	props=tmpProps                            	
                            }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.eachWithIndex { p, i ->
                                
                                    if (p.isAssociation()) { %>
                            <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
                   	    <%      } else { %>
                            <g:sortableColumn params="\${filteredParams ? filteredParams : ''}" property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
                        <%  }   }    %>
                        <th class="action"><g:message default="Action" code="default.list.action.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        <tr class="\${(i % 2) == 0 ? 'odd' : 'even'}">
                        <%  props.eachWithIndex { p, i ->
                                cp = domainClass.constrainedProperties[p.name]
                                if (i == 0) { %>
                            <td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
                        <%      } else  {
                                    if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
                        <%          } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) {
                        				def dateFormat=cp?.format ? cp.format : "yyyy-MM-dd'T'HH:mm:ss"
                        			 %>
                            <td><g:formatDate date="\${${propertyName}.${p.name}}" format="${dateFormat}"/></td>
                        <%          } else { %>
                            <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                        <%  }   }   } %>
                        <td> 
                            <% if (!features?.contains("noShow")) { %>
                        		<g:link title ="\${message(default: 'Show this item',code: '${domainClass.propertyName}.list.show.help')}" params="\${filteredParams ? filteredParams : ''}" action="show" class="awesome small blue button" id="\${${propertyName}.id}"><g:message default="show" code="${domainClass.propertyName}.list.show.label" />&nbsp;&raquo;</g:link>&nbsp;
                        	<% } %>
                        	<% if (!features?.contains("noEdit")) { %>
                            	<g:link class="awesome small blue button" title="\${message(default: 'Modify this item',code: '${domainClass.propertyName}.list.edit.help')}" action="edit" params="\${filteredParams ? filteredParams : ''}" id="\${${propertyName}.id}"><g:message default="edit" code="${domainClass.propertyName}.list.edit.label"/>&nbsp;&raquo;</g:link>&nbsp;
                            <% } %>
                            <% if (!features?.contains("noDelete")) { %>
                            	<g:link title="\${message(default: 'Delete this item',code: '${domainClass.propertyName}.list.delete.help')}" class="awesome small red button" onclick="return confirm('\${message(code: '${domainClass.propertyName}.button.delete.confirm.message', default: 'Are you sure?')}');" action="delete" id="\${${propertyName}.id}" params="\${filteredParams ? filteredParams : ''}">&times;</g:link></td>
                            <% } %>                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <div class="paginateButtons">
            	<g:if test="\${q}" >
                <g:paginate total="\${${propertyName}Total}" action="search" params="[q:q]"/>
                </g:if>
                <g:else>
                <g:paginate total="\${${propertyName}Total}" action="list" />
                </g:else>
                
            </div>

        </div>
    </body>
</html>
