<dialog:form title="Field type item" object="${fieldTypeItemInstance}">
	<dialog:table>
    	<dialog:textField object="${fieldTypeItemInstance}" propertyName="id" mode="show" />                                                      
    	<dialog:textField object="${fieldTypeItemInstance}" propertyName="position" mode="edit" />
    	<dialog:textField object="${fieldTypeItemInstance}" propertyName="label" mode="edit" />
    	<dialog:textField object="${fieldTypeItemInstance}" propertyName="value" mode="edit" />
    </dialog:table>
</dialog:form>