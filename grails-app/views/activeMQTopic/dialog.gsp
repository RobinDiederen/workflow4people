<%@page import="org.workflow4people.activemq.command.ActiveMQQueueCommand"%>
<%@page import="org.workflow4people.activemq.command.ActiveMQTopicCommand"%>

<dialog:form title="ActiveMQ Topic" object="${topicCommand}" height="540px" width="650px">
	<dialog:tabs names="Details,Messages" object="${topicCommand}">		
		<dialog:tab name="Details" object="${topicCommand}">		                            	                                   
	        <dialog:textField object="${topicCommand}" propertyName="brokerName" mode="show" />
	        <dialog:textField object="${topicCommand}" propertyName="name" mode="show" />
	        <dialog:textField object="${topicCommand}" propertyName="enqueueCount" mode="show" />
	        <dialog:textField object="${topicCommand}" propertyName="dequeueCount" mode="show" />
	        <dialog:textField object="${topicCommand}" propertyName="consumerCount" mode="show" />
	        <dialog:textField object="${topicCommand}" propertyName="producerCount" mode="show" />
	        	                
		</dialog:tab>
		<dialog:tab name="Messages" object="${topicCommand}">
		<%--
			<dialog:detailTable property="test" object="${topicCommand}" controllerName="activeMQQueue" domainClass="${ActiveMQTopicCommand}" rowreordering="false"/>
			--%>																
		</dialog:tab>		
	</dialog:tabs>
</dialog:form>
