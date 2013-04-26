<%@page import="org.workflow4people.activiti.command.VariableCommand"%>
<dialog:form title="Activiti Process instance" object="${processInstance}" height="500px">
	<dialog:tabs names="Details,Variables" object="${processInstance}">		
		<dialog:tab name="Details" object="${processInstance}">		                            
	        <dialog:textField object="${processInstance}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${processInstance}" propertyName="processDefinitionId" mode="show" />							        
		</dialog:tab>
		<dialog:tab name="Variables" object="${processInstance}">
			<dialog:detailTable xlistConfig="${VariableCommand.listConfig}" property="processInstance" object="${processInstance}" controllerName="activitiVariable" domainClass="${VariableCommand}" xrowreordering="false"/>								
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>
