<wf:form title="Feature" >
	<wf:table>		                            
		<wf:textField object="${featureInstance}" propertyName="id" mode="show" />                                                        
		<wf:textField object="${featureInstance}" propertyName="name" mode="edit" />
		<wf:textField object="${featureInstance}" propertyName="title" mode="edit" />
		<wf:textArea object="${featureInstance}" propertyName="description" mode="edit" />
		<wf:detailTable property="feature" object="${featureInstance}" domainClass="${org.workflow4people.FeaturePermission}" />	    		
				
	</wf:table>		
</wf:form>
