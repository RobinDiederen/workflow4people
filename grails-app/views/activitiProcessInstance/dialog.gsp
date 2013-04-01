<%@page import="org.workflow4people.activiti.command.ProcessVariableCommand"%>
<dialog:form title="Activiti Process instance" object="${processInstance}" height="500px">
	<dialog:tabs names="Details,Variables" object="${processInstance}">		
		<dialog:tab name="Details" object="${processInstance}">		                            
	        <dialog:textField object="${processInstance}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${processInstance}" propertyName="processDefinitionId" mode="show" />							        
		</dialog:tab>
		<dialog:tab name="Variables" object="${processInstance}">
			<dialog:detailTable xlistConfig="${ProcessVariableCommand.listConfig}" property="processInstance" object="${processInstance}" controllerName="activitiProcessVariable" domainClass="${ProcessVariableCommand}" rowreordering="false"/>								
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>
