<dialog:form title="Day part" object="${dayPartInstance}">
	<dialog:table>		                            
		<dialog:textField object="${dayPartInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${dayPartInstance}" propertyName="position" mode="edit" />                                                    
		<dialog:select object="${dayPartInstance}" propertyName="dayName" mode="edit" />
		<dialog:textField object="${dayPartInstance}" propertyName="fromTime" mode="edit" />
		<dialog:textField object="${dayPartInstance}" propertyName="toTime" mode="edit" />                        		        	    		
	</dialog:table>		
</dialog:form>
