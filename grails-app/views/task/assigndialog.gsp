<wf:form title="Task" width="512px">
	<wf:tabs names="Groups,Users,Assignee" object="${taskInstance}">		
		<wf:tab name="Groups" object="${taskInstance}">	
			<wf:select multiple="true" class="altselect" optionKey="id" object="${taskInstance}" from="${org.workflow4people.Authority.list(sort:'authority')}" propertyName="candidateGroups" mode="edit"/>
		</wf:tab>
		<wf:tab name="Users" object="${taskInstance}">
			<wf:select multiple="true" class="altselect" optionKey="id" object="${taskInstance}" from="${org.workflow4people.Person.list(sort:'username')}" propertyName="candidateUsers" mode="edit"/>
		</wf:tab>
		<wf:tab name="Assignee" object="${taskInstance}">
			<wf:domainObject object="${taskInstance}" propertyName="assignee" mode="edit" sort="id"/>
		</wf:tab>
	</wf:tabs>
</wf:form>
