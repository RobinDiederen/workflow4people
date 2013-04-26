<%@page import="org.workflow4people.activiti.command.VariableCommand"%>
<dialog:form title="Activiti variable" object="${variableCommand}">
	<dialog:table>		                            
				                            
        <dialog:textField object="${variableCommand}" propertyName="id" mode="show" />
        <dialog:select object="${variableCommand}" propertyName="variableClassName" from="${['java.lang.Boolean','java.lang.Byte','java.lang.Character','java.lang.Date','java.lang.Double','java.lang.Float','java.lang.Integer','java.lang.Long','java.lang.Short','java.lang.String']}"   mode="edit"/>
        <dialog:textField object="${variableCommand}" propertyName="name" mode="edit" />
        <dialog:textField object="${variableCommand}" propertyName="value" mode="edit" />
		<dialog:textField type="hidden" object="${variableCommand}" propertyName="parentId" mode="edit" />
		<dialog:textField type="hidden" object="${variableCommand}" propertyName="parentType" mode="edit" />



	
				
</dialog:table>
</dialog:form>
