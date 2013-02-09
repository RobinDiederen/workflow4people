<%@page import="org.workflow4people.Document"%>
<%@page import="org.workflow4people.DocumentHistory"%>
<dialog:form title="History" object="${documentHistoryInstance}" width="800px" height="450px">
	<dialog:tabs names="History,Document" object="${documentHistoryInstance}">		
		<dialog:tab name="History" object="${documentHistoryInstance}">
			<dialog:textField object="${documentHistoryInstance}" propertyName="versionLabel" mode="show" />			
			<dialog:date object="${documentHistoryInstance}" propertyName="dateCreated" mode="show" />
			<dialog:textField object="${documentHistoryInstance}" propertyName="name" mode="show" class="wide"/>												
			<dialog:textField object="${documentHistoryInstance}" propertyName="createdBy" mode="show" class="wide"/>			
			<dialog:date object="${documentHistoryInstance}" propertyName="documentLastUpdated" mode="show" />
			<dialog:textField object="${documentHistoryInstance}" propertyName="lastUpdatedBy" mode="show" class="wide"/>								
		</dialog:tab>		
		<dialog:tab name="Document" object="${documentHistoryInstance}">			
			<dialog:xml noLabel="true" noHelp="true" object="${documentHistoryInstance}" propertyName="xmlDocument" mode="show" class="xmldoc xcodemirror" xcodeMirrorMode="text/html" />		
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>