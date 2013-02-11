<%@page import="org.workflow4people.Document"%>
<%@page import="org.workflow4people.DocumentHistory"%>
<%@page import="org.workflow4people.DocumentPermission"%>
<dialog:form title="Document" width="900px;" height="670px;" object="${documentInstance}">
	<dialog:tabs names="Details,XML,Index,CMIS,Permissions,History" object="${documentInstance}">		
		<dialog:tab name="Details" object="${documentInstance}">		     
			<dialog:textField object="${documentInstance}" propertyName="id" mode="show" />
			<dialog:textField object="${documentInstance}" propertyName="name" mode="edit"  class="extrawide"/>
			<dialog:textField object="${documentInstance}" propertyName="versionLabel" mode="edit" />
	        <dialog:domainObject object="${documentInstance}" propertyName="documentType" mode="edit" />
	        <%--
			<dialog:domainObject object="${documentInstance}" propertyName="documentStatus" mode="show" />
			<dialog:textField object="${documentInstance}" propertyName="documentKey" mode="show" />
			--%>
			<dialog:textField object="${documentInstance}" propertyName="documentDescription" mode="edit" class="extrawide"/>
			
			<dialog:date object="${documentInstance}" propertyName="dateCreated" mode="show" />
			<dialog:date object="${documentInstance}" propertyName="lastUpdated" mode="show" />
			<dialog:date object="${documentInstance}" propertyName="completionDate" mode="show" />
			
			<dialog:textField object="${documentInstance}" propertyName="processingDays" mode="edit" />
						
	        <dialog:textField object="${documentInstance}" propertyName="user" mode="edit" />
			<dialog:textField object="${documentInstance}" propertyName="groupId" mode="edit" />
					    
		</dialog:tab>		
		<dialog:tab name="XML" object="${documentInstance}">
	        <dialog:xml noLabel="true" noHelp="true" object="${documentInstance}" propertyName="xmlDocument" mode="edit" class="xmldoc codemirror"  codeMirrorMode="text/html" />
		</dialog:tab>
		<dialog:tab name="Index" object="${documentInstance}">
			<dialog:detailTable property="document" object="${documentInstance}" domainClass="${org.workflow4people.DocumentIndex}" />	    		
		</dialog:tab>
		<dialog:tab name="CMIS" object="${documentInstance}">
			<dialog:textField object="${documentInstance}" propertyName="cmisFolderObjectId" mode="edit" class="extrawide"/>
			<dialog:textField object="${documentInstance}" propertyName="cmisFolderUrl" mode="edit" class="extrawide"/>
	        <dialog:textField object="${documentInstance}" propertyName="cmisPath" mode="edit" class="extrawide"/>	    
		</dialog:tab>
		
		<dialog:tab name="Permissions" object="${documentInstance}">
			<dialog:checkBox object="${documentInstance}" propertyName="inheritPermissions" mode="edit" />					
			<dialog:detailTable property="document" object="${documentInstance}" domainClass="${DocumentPermission}" newButton="true"/>			
		</dialog:tab>
		
		<dialog:tab name="History" object="${documentInstance}">			
			<dialog:detailTable property="document" object="${documentInstance}" domainClass="${DocumentHistory}" newButton="false"/>			
		</dialog:tab>
				
	</dialog:tabs>
</dialog:form>
