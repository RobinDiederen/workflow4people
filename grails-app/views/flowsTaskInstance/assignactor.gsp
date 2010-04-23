<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Assign actor for task ${params.taskInstanceId}</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>            
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="assignactorsave" method="post" >
            <input type="hidden" name="taskInstanceId" value="${params.taskInstanceId}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="actorId">Actor Id:</label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" id="actorId" name="actorId" value="${params.actorId}"/>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Assign" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
