<wf:form title="Role" >
	<wf:table>		                            
		<wf:textField object="${roleInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${roleInstance}" propertyName="name" mode="edit" />
		<wf:textField object="${roleInstance}" propertyName="title" mode="edit" />
		<wf:textArea object="${roleInstance}" propertyName="description" mode="edit" />		
		<wf:select mode="edit" object="${roleInstance}" propertyName="roleAction" class="multiselect" from="${org.workflow4people.Action.list(sort:'name')}" multiple="true" optionKey="id" />
	</wf:table>		
</wf:form>