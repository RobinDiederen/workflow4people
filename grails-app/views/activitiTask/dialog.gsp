<%@page import="org.workflow4people.activiti.command.VariableCommand"%>
<dialog:form title="Activiti Task" object="${taskCommand}" height="520px">
	<g:hiddenField  value="${taskCommand.taskId}" name="taskId" />
	<dialog:tabs names="Details,Variables,Dates" object="${taskCommand}">		
		<dialog:tab name="Details" object="${taskCommand}">		                            
	        <dialog:textField object="${taskCommand}" propertyName="id" mode="show" />                            
	        <dialog:textField object="${taskCommand}" propertyName="name" mode="edit" />
			<dialog:textArea object="${taskCommand}" propertyName="description" mode="edit" />
			<dialog:textField object="${taskCommand}" propertyName="assignee" mode="edit" />
			<dialog:textField object="${taskCommand}" propertyName="priority" mode="edit" />
		</dialog:tab>
		<dialog:tab name="Variables" object="${taskCommand}">
			<dialog:detailTable newButton="false" property="taskCommand" object="${taskCommand}" xlistConfig="${variableListConfig}" controllerName="activitiVariable" domainClass="${VariableCommand}" rowreordering="false"/>
		</dialog:tab>		

		<dialog:tab name="Dates" object="${taskCommand}">		                            
			<dialog:date object="${taskCommand}" propertyName="createTime" mode="show" />
			<dialog:date object="${taskCommand}" propertyName="dueDate" mode="edit" />
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
