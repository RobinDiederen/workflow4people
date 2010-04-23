<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="wf4pVariable.create" default="Create/edit group" /></title>
    </head>
    <body>
        
        <div class="body">            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            
            
            <div class="nav">&nbsp;</div>
            
            <g:form action="save" method="post" >            
                <div class="dialog">
                    <table>
                        <tbody>                       
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="wf4pGroup.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="name" value="${group?.name}" />
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Save')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
