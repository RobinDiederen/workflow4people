<dialog:form title="Holiday" object="${holidayInstance}">
	<dialog:table>		                            
		<dialog:textField object="${holidayInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${holidayInstance}" propertyName="title" mode="edit" />
		<dialog:date object="${holidayInstance}" propertyName="fromDate" mode="edit" />
		<dialog:date object="${holidayInstance}" propertyName="toDate" mode="edit" />
	</dialog:table>		
</dialog:form>
