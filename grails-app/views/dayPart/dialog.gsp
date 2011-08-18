<wf:form title="Day part" object="${dayPartInstance}">
	<wf:table>		                            
		<wf:textField object="${dayPartInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${dayPartInstance}" propertyName="position" mode="edit" />                                                    
		<wf:select object="${dayPartInstance}" propertyName="dayName" mode="edit" />
		<wf:textField object="${dayPartInstance}" propertyName="fromTime" mode="edit" />
		<wf:textField object="${dayPartInstance}" propertyName="toTime" mode="edit" />                        		        	    		
	</wf:table>		
</wf:form>
