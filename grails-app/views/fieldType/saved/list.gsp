

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="fieldType.list" default="FieldType List" /></title>
    </head>
    <body>

        <div class="body">
            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="nav">
            	<span class="menuButton"><g:link class="create" action="create"><g:message code="fieldType.new" default="New FieldType" /></g:link></span>
            </div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="fieldType.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="fieldType.name" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="fieldType.description" />
                        
                   	    <g:sortableColumn property="defaultValue" title="Default Value" titleKey="fieldType.defaultValue" />
                        
                   	    <g:sortableColumn property="label" title="Label" titleKey="fieldType.label" />
                        
                   	    <g:sortableColumn property="help" title="Help" titleKey="fieldType.help" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fieldTypeInstanceList}" status="i" var="fieldTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${fieldTypeInstance.id}">${fieldValue(bean: fieldTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "defaultValue")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "label")}</td>
                        
                            <td>${fieldValue(bean: fieldTypeInstance, field: "help")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${fieldTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
