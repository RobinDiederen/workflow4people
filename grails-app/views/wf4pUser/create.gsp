<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="wf4pVariable.create" default="Create/edit user" /></title>
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
                                    <label for="name"><g:message code="wf4pUser.id" default="Id" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="id" value="${user?.id}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="wf4pUser.givenName" default="Given name" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="givenName" value="${user?.givenName}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="wf4pUser.familyName" default="Family name" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="familyName" value="${user?.familyName}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="wf4pUser.businessEmail" default="Business e-mail" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="businessEmail" value="${user?.businessEmail}" />
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
