<dialog:form title="Role" width="615px" object="${roleInstance}">
	<dialog:table>		                            
		<dialog:textField object="${roleInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${roleInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${roleInstance}" propertyName="title" mode="edit" />
		<dialog:textArea object="${roleInstance}" propertyName="description" mode="edit" />		
<%--		<dialog:select mode="edit" object="${roleInstance}" propertyName="roleAction" class="multiselect" from="${org.workflow4people.Action.list(sort:'name')}" multiple="true" optionKey="id"  vertical="true" style="width:540px; height:200px;"/>--%>
		<dialog:select mode="edit" object="${roleInstance}" propertyName="roleAction" class="altselect" from="${org.workflow4people.Action.list(sort:'name')}" multiple="true" optionKey="id" />
	</dialog:table>		
</dialog:form>
