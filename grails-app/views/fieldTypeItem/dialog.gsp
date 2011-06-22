<wf:form title="Field type item">
	<g:if test="${params.parentId}">
		<g:hiddenField name="fieldType.id" value="${params.parentId}"></g:hiddenField>
	</g:if>
	<wf:table>
    	<wf:textField object="${fieldTypeItemInstance}" propertyName="id" mode="show" />                                                      
    	<wf:textField object="${fieldTypeItemInstance}" propertyName="itemPosition" mode="edit" />
    	<wf:textField object="${fieldTypeItemInstance}" propertyName="label" mode="edit" />
    	<wf:textField object="${fieldTypeItemInstance}" propertyName="value" mode="edit" />
    </wf:table>
</wf:form>