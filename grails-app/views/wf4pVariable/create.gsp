

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="wf4pVariable.create" default="Create/edit variable" /></title>
    </head>
    <body>
        
        <div class="body">            
            
            <div class="navbar">
			<div class="navbar-inner">			
				<ul class="nav">	        	
            <li><g:link class="small awesome blue button" action="show" controller="wf4pProcessInstance" id="${params.processInstanceId}" >&laquo; Process instance ${params.processInstanceId}</g:link></li>
            </ul>
            </div>
            </div>
            
            
            <g:form action="save" method="post" >
            <input type="hidden" name="processInstanceId" value="${params.processInstanceId}" />
                <div class="dialog">
                    <table class="table-bordered">
                        <tbody>                       
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="wf4pVariable.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="variableName" value="${variableName}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="wf4pVariable.value" default="Value" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="variableValue" value="${variableValue}" />
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fieldList"><g:message code="wf4pVariable.className" default="Class name" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="variableClassName" from="${['java.lang.Boolean','java.lang.Byte','java.lang.Character','java.lang.Date','java.lang.Double','java.lang.Float','java.lang.Integer','java.lang.Long','java.lang.Short','java.lang.String']}" value="${variableClassName}"  />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span><g:submitButton name="create" class="save btn" value="${message(code: 'create', 'default': 'Save')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
