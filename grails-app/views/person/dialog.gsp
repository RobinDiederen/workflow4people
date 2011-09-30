<wf:form title="User" width="615px" object="${personInstance}">
	<wf:table>		                            
		<wf:textField object="${personInstance}" propertyName="id" mode="show" />
		<wf:checkBox object="${personInstance}" propertyName="enabled" mode="edit" />                                                        
		<wf:textField object="${personInstance}" propertyName="username" mode="edit" class="wide"/>
		<wf:textField object="${personInstance}" propertyName="userRealName" mode="edit" class="wide"/>
		<wf:textField object="${personInstance}" propertyName="givenName" mode="edit" class="wide"/>
		<wf:textField object="${personInstance}" propertyName="familyName" mode="edit" class="wide"/>
		<wf:textField object="${personInstance}" propertyName="email" mode="edit" class="wide"/>
		<wf:checkBox object="${personInstance}" propertyName="emailShow" mode="edit" />
		<wf:textField object="${personInstance}" propertyName="passwd" mode="edit" class="wide"/>
		<wf:select multiple="true" class="altselect" optionKey="id" object="${personInstance}" from="${org.workflow4people.Authority.list(sort:'authority')}" propertyName="authorities" mode="edit"/>
		<wf:textArea object="${personInstance}" propertyName="description" mode="edit" />		
	</wf:table>		
</wf:form>
