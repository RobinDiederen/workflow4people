<%@page import="org.workflow4people.activiti.command.ProcessVariableCommand"%>
<dialog:form title="Activiti Process variable" object="${processVariable}">
	<dialog:table>		                            
				                            
        <dialog:textField object="${processVariable}" propertyName="id" mode="show" />
        <dialog:select object="${processVariable}" propertyName="variableClassName" from="${['java.lang.Boolean','java.lang.Byte','java.lang.Character','java.lang.Date','java.lang.Double','java.lang.Float','java.lang.Integer','java.lang.Long','java.lang.Short','java.lang.String']}"   mode="edit"/>
        <dialog:textField object="${processVariable}" propertyName="name" mode="edit" />
        <dialog:textField object="${processVariable}" propertyName="value" mode="edit" />
				
</dialog:table>
</dialog:form>
