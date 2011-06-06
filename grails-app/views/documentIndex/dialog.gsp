<wf:form title="Document index" >
	<wf:table>		                            
		<wf:textField object="${documentIndexInstance}" propertyName="id" mode="show" />
		<wf:domainObject object="${documentIndexInstance}" propertyName="document" mode="show" />

		<wf:textField object="${documentIndexInstance}" propertyName="name" mode="edit" />
		<wf:textField object="${documentIndexInstance}" propertyName="value" mode="edit" />
	</wf:table>		
</wf:form>
