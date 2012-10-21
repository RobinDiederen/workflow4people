<dialog:form title="User" width="615px" object="${personInstance}">
	<dialog:table>		                            
		<dialog:textField object="${personInstance}" propertyName="id" mode="show" />
		<dialog:checkBox object="${personInstance}" propertyName="enabled" mode="edit" />                                                        
		<dialog:textField object="${personInstance}" propertyName="username" mode="edit" class="wide"/>
		<dialog:textField object="${personInstance}" propertyName="userRealName" mode="edit" class="wide"/>
		<dialog:textField object="${personInstance}" propertyName="givenName" mode="edit" class="wide"/>
		<dialog:textField object="${personInstance}" propertyName="familyName" mode="edit" class="wide"/>
		<dialog:textField object="${personInstance}" propertyName="email" mode="edit" class="wide"/>
		<dialog:checkBox object="${personInstance}" propertyName="emailShow" mode="edit" />
		<dialog:textField object="${personInstance}" propertyName="passwd" mode="edit" class="wide"/>
		<dialog:select multiple="true" class="altselect" optionKey="id" object="${personInstance}" from="${org.workflow4people.Authority.list(sort:'authority')}" propertyName="authorities" mode="edit"/>
		<dialog:textArea object="${personInstance}" propertyName="description" mode="edit" />		
	</dialog:table>		
</dialog:form>
