<wf:form title="Configuration item" >
	<wf:table>		                            
		<wf:textField object="${applicationConfigurationInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${applicationConfigurationInstance}" propertyName="configKey" mode="edit" class="wide"/>
		<wf:textField object="${applicationConfigurationInstance}" propertyName="configValue" mode="edit" class="extrawide"/>				
	</wf:table>		
</wf:form>