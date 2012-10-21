<dialog:form title="Feature" object="${featureInstance}">
	<dialog:table>		                            
		<dialog:textField object="${featureInstance}" propertyName="id" mode="show" />                                                        
		<dialog:textField object="${featureInstance}" propertyName="name" mode="edit" />
		<dialog:textField object="${featureInstance}" propertyName="title" mode="edit" />
		<dialog:textArea object="${featureInstance}" propertyName="description" mode="edit" />
		<dialog:detailTable property="feature" object="${featureInstance}" domainClass="${org.workflow4people.FeaturePermission}" />	    		
				
	</dialog:table>		
</dialog:form>
