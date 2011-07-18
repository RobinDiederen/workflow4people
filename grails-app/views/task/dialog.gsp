<wf:form title="Task">
	<wf:table>		                            

	        <wf:textField object="${taskInstance}" propertyName="id" mode="show" />
	        <wf:textField object="${taskInstance}" propertyName="externalId" mode="edit" />
	        <wf:textField object="${taskInstance}" propertyName="externalWorkflowId" mode="edit" />
	        <wf:domainObject object="${taskInstance}" propertyName="workflow" mode="show" />
	        
	        <wf:textField object="${taskInstance}" propertyName="description" mode="edit" class="extrawide"/>
			<%--
			<wf:textField object="${taskInstance}" propertyName="transitions" mode="edit" class="extrawide"/>
			
			<wf:textField object="${taskInstance}" propertyName="outcome" mode="edit" />
			--%>
			<wf:select object="${taskInstance}" propertyName="outcome" mode="edit" from="${taskInstance.transitions.split(',')}" />
				                     
			<wf:domainObject object="${taskInstance}" propertyName="form" mode="edit" />
			
			
	        <wf:textField object="${taskInstance}" propertyName="priority" mode="edit" />
	        <wf:textField object="${taskInstance}" propertyName="cssClass" mode="edit" />
	        
			<wf:date object="${taskInstance}" propertyName="dateCreated" mode="show" />
			<wf:date object="${taskInstance}" propertyName="lastUpdated" mode="show" />
			<wf:date object="${taskInstance}" propertyName="dueDate" mode="show" />			
			<wf:date object="${taskInstance}" propertyName="completionDate" mode="show" />
			
			<wf:checkBox object="${taskInstance}" propertyName="noMessage" mode="edit" />
			<%--
			<wf:select multiple="true" class="multiselect" optionKey="id" object="${taskInstance}" from="${org.workflow4people.Authority.list(sort:'authority')}" propertyName="candidateGroups" mode="edit" />
			<wf:select multiple="true" class="multiselect" optionKey="id" object="${taskInstance}" from="${org.workflow4people.Person.list(sort:'username')}" propertyName="candidateUsers" mode="edit" />
			--%>
		</wf:table>
	
</wf:form>
