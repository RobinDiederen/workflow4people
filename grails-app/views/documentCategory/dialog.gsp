<dialog:form title="Document Category" object="${documentCategoryInstance}">
	<dialog:table>		                            
		<dialog:textField object="${documentCategoryInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${documentCategoryInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${documentCategoryInstance}" propertyName="title" mode="edit" />
		<dialog:textArea object="${documentCategoryInstance}" propertyName="description" mode="edit" />				
	</dialog:table>		
</dialog:form>
