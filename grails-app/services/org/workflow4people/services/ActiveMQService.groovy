package org.workflow4people.services

import javax.management.remote.JMXConnectorFactory
import javax.management.remote.JMXServiceURL
import javax.management.remote.*


import org.apache.activemq.broker.jmx.*
import javax.management.*
import org.apache.activemq.broker.jmx.*
import javax.jms.*




class ActiveMQService {
	MBeanServerConnection connection

    boolean transactional = false

    def init() {
		JMXServiceURL url = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi");
		JMXConnector connector = JMXConnectorFactory.connect(url, null);
		connector.connect();
		connection =connector.getMBeanServerConnection();
    }
	
	def getQueue(brokerName,queueName) {

		def objectName=new ObjectName("org.apache.activemq:BrokerName=${brokerName},Type=Queue,Destination=${queueName}");
		QueueViewMBean queue=(QueueViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, objectName, QueueViewMBean.class,true);
	}

	def getTopic(brokerName,topicName) {

		def objectName=new ObjectName("org.apache.activemq:BrokerName=${brokerName},Type=Topic,Destination=${topicName}");
		TopicViewMBean queue=(TopicViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, objectName, TopicViewMBean.class,true);
	}

	
}
