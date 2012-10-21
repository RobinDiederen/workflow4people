<dialog:form title="Configuration item" width="730px" object="${applicationConfigurationInstance}">
	<dialog:table>		                            
		<dialog:textField object="${applicationConfigurationInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${applicationConfigurationInstance}" propertyName="configKey" mode="edit" class="wide"/>
		<dialog:textField object="${applicationConfigurationInstance}" propertyName="configValue" mode="edit" class="extrawide"/>				
	</dialog:table>		
</dialog:form>
