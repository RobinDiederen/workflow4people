<wf:form title="Holiday" >
	<wf:table>		                            
		<wf:textField object="${holidayInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${holidayInstance}" propertyName="title" mode="edit" />
		<wf:date object="${holidayInstance}" propertyName="fromDate" mode="edit" />
		<wf:date object="${holidayInstance}" propertyName="toDate" mode="edit" />
	</wf:table>		
</wf:form>
