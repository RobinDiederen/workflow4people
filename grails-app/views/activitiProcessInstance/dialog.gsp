<%@page import="org.workflow4people.activiti.command.VariableCommand"%>
<dialog:form title="Activiti Process instance" object="${processInstanceCommand}" xheight="500px">
	<dialog:tabs names="Details,Variables" object="${processInstanceCommand}">		
		<dialog:tab name="Details" object="${processInstanceCommand}">		                            
	        <dialog:textField object="${processInstanceCommand}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${processInstanceCommand}" propertyName="processDefinitionId" mode="show" />
			<dialog:textField object="${processInstanceCommand}" propertyName="suspended" mode="show" />
			<dialog:textField object="${processInstanceCommand}" propertyName="ended" mode="show" />
		</dialog:tab>
		<dialog:tab name="Variables" object="${processInstanceCommand}">
			<dialog:detailTable newButton="false" property="processInstance" object="${processInstanceCommand}" controllerName="activitiVariable" domainClass="${VariableCommand}" />								
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>
