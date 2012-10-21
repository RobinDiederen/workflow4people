<dialog:form title="Task" width="512px">
	<dialog:tabs names="Groups,Users,Assignee" object="${taskInstance}">		
		<dialog:tab name="Groups" object="${taskInstance}">	
			<dialog:select multiple="true" class="altselect" optionKey="id" object="${taskInstance}" from="${org.workflow4people.Authority.list(sort:'authority')}" propertyName="candidateGroups" mode="edit"/>
		</dialog:tab>
		<dialog:tab name="Users" object="${taskInstance}">
			<dialog:select multiple="true" class="altselect" optionKey="id" object="${taskInstance}" from="${org.workflow4people.Person.list(sort:'username')}" propertyName="candidateUsers" mode="edit"/>
		</dialog:tab>
		<dialog:tab name="Assignee" object="${taskInstance}">
			<dialog:domainObject object="${taskInstance}" propertyName="assignee" mode="edit" sort="id"/>
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
