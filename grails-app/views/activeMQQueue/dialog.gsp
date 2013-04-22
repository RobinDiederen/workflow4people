<%@page import="org.workflow4people.activemq.command.ActiveMQMessageCommand"%>

<dialog:form title="ActiveMQ Queue" object="${queueCommand}" height="540px" width="650px">
	<dialog:tabs names="Details,Messages" object="${queueCommand}">		
		<dialog:tab name="Details" object="${queueCommand}">		                            	                                   
	        <dialog:textField object="${queueCommand}" propertyName="brokerName" mode="show" />
	        <dialog:textField object="${queueCommand}" propertyName="name" mode="show" />
	        <dialog:textField object="${queueCommand}" propertyName="enqueueCount" mode="show" />
	        <dialog:textField object="${queueCommand}" propertyName="dequeueCount" mode="show" />
	        <dialog:textField object="${queueCommand}" propertyName="consumerCount" mode="show" />
	        <dialog:textField object="${queueCommand}" propertyName="producerCount" mode="show" />
	        	                
		</dialog:tab>
		<dialog:tab name="Messages" object="${queueCommand}">
			<dialog:detailTable newButton="false" property="test" object="${queueCommand}" controllerName="activeMQMessage" domainClass="${ActiveMQMessageCommand}" rowreordering="false"/>																		
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>
