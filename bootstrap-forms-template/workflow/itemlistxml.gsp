<items>			
	<g:each in="${org.workflow4people.FieldTypeItem.findAllByFieldType(fieldTypeInstance,[sort:'itemPosition',order:'asc'])}" var="item" >
	<item>
		<name>${item.label}</name>
		<value>${item.value}</value>			
	</item>									
	</g:each>				
		

</items>