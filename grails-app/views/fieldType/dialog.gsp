<wf:form title="Edit field type">
	<wf:table names="Details,Text,Advanced" object="${fieldInstance}">		                            
		<wf:textField object="${fieldTypeInstance}" propertyName="id" mode="show" />
		<wf:textField object="${fieldTypeInstance}" propertyName="name" mode="edit" />
		<wf:detailTable property="fieldType" object="${fieldTypeInstance}" domainClass="${org.workflow4people.FieldTypeItem}" />                                                       
	</wf:table>		
</wf:form>