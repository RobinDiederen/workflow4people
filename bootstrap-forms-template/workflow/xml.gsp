<?xml version="1.0" encoding="UTF-8"?>	
<${workflowDefinitionInstance.documentType.fieldType.name} ${workflowDefinitionInstance.documentType.fieldType.namespace.prefixDeclarations} xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="${workflowDefinitionInstance.documentType.fieldType.namespace.uri}" xsi:schemaLocation="${workflowDefinitionInstance.documentType.fieldType.namespace.uri} ${workflowDefinitionInstance.name}.xsd">
		
<g:each in="${org.workflow4people.Field.findAllByParent(workflowDefinitionInstance.documentType.fieldType.listParent,[order:'asc',sort:'fieldPosition'])}" var="element">
	<w:snippet var="${element}" name="xml" />
</g:each>									
				
		
</${workflowDefinitionInstance.documentType.fieldType.name}>