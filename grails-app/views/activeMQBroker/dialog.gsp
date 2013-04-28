<%@page import="org.workflow4people.activemq.command.ActiveMQQueueCommand"%>
<%@page import="org.workflow4people.activemq.command.ActiveMQTopicCommand"%>

<dialog:form title="ActiveMQ Broker" object="${brokerCommand}" height="540px" width="950px">
	<dialog:tabs names="Details,Queues,Topics,Statistics" object="${brokerCommand}">		
		<dialog:tab name="Details" object="${brokerCommand}">		                            	                                   
	        <dialog:textField object="${brokerCommand}" propertyName="brokerName" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="brokerId" mode="show" />
	        <dialog:checkBox object="${brokerCommand}" propertyName="persistent" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="VMURL" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="openWireURL" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="dataDirectory" mode="show" />	        
	        <dialog:checkBox object="${brokerCommand}" propertyName="slave" mode="show" />	                 
		</dialog:tab>
		<dialog:tab name="Queues" object="${brokerCommand}">
			<dialog:detailTable newButton="false" property="test" object="${brokerCommand}" controllerName="activeMQQueue" domainClass="${ActiveMQQueueCommand}" />																
		</dialog:tab>
		<dialog:tab name="Topics" object="${brokerCommand}">
			<dialog:detailTable newButton="false" property="test" object="${brokerCommand}" controllerName="activeMQTopic" domainClass="${ActiveMQTopicCommand}" />						
		</dialog:tab>
		<dialog:tab name="Statistics" object="${brokerCommand}">
			<dialog:textField object="${brokerCommand}" propertyName="totalEnqueueCount" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="totalDequeueCount" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="totalConsumerCount" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="totalProducerCount" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="totalMessageCount" mode="show" />
	        <dialog:textField object="${brokerCommand}" propertyName="uptime" mode="show" />	       						
		</dialog:tab>
	</dialog:tabs>
</dialog:form>
