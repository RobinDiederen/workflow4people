package org.workflow4people.services

import javax.management.remote.JMXConnectorFactory
import javax.management.remote.JMXServiceURL
import javax.management.remote.*
import java.lang.management.*


import org.apache.activemq.broker.jmx.*
import javax.management.*
import org.apache.activemq.broker.jmx.*
import javax.jms.*


import org.springframework.beans.factory.InitializingBean;

class ActiveMQService implements InitializingBean {
	MBeanServerConnection connection

    boolean transactional = false
	

    void afterPropertiesSet() {
		def pid = ManagementFactory.getRuntimeMXBean().getName().replaceAll("@.*","")
		com.sun.tools.attach.VirtualMachine vm = com.sun.tools.attach.VirtualMachine.attach(pid);
		String javaHome = vm.getSystemProperties().getProperty("java.home");
		String agentJar = javaHome + File.separator +  "lib" + File.separator + "management-agent.jar";
		vm.loadAgent(agentJar, "com.sun.management.jmxremote");
		String localConnectorAddress = vm.getAgentProperties().getProperty("com.sun.management.jmxremote.localConnectorAddress");
		if (localConnectorAddress == null) {
			// Check system properties
			localConnectorAddress = vm.getSystemProperties().getProperty("com.sun.management.jmxremote.localConnectorAddress");
		}
		vm.detach();
		
		
		
		//JMXServiceURL url = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi");
		JMXServiceURL url = new JMXServiceURL(localConnectorAddress);
		JMXConnector connector = JMXConnectorFactory.connect(url, null);
		connector.connect();
		connection =connector.getMBeanServerConnection();
    }
	
	def getBrokers() {
		ObjectName brokerQueryName = new ObjectName("org.apache.activemq:BrokerName=*,Type=Broker");
		connection.queryMBeans(brokerQueryName, null).collect {   
			BrokerViewMBean mbean =(BrokerViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, it.name, BrokerViewMBean.class, true);			
		}
	}
	
	def getBroker(brokerName) {
		ObjectName brokerQueryName = new ObjectName("org.apache.activemq:BrokerName=${brokerName},Type=Broker");		
		BrokerViewMBean mbean =(BrokerViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, brokerQueryName, BrokerViewMBean.class, true);
	}
	
	def getTopics(brokerName){		
		ObjectName queryName = new ObjectName("org.apache.activemq:BrokerName=${brokerName},Type=Topic,*");
		//connection.queryMBeans(queryName, null)
		connection.queryMBeans(queryName, null).collect {
			TopicViewMBean queue=(TopicViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, it.name, TopicViewMBean.class,true);
		}
	}
	
	def getQueues(brokerName){
		ObjectName queryName = new ObjectName("org.apache.activemq:BrokerName=${brokerName},Type=Queue,*");		
		connection.queryMBeans(queryName, null).collect {
			QueueViewMBean queue=(QueueViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, it.name, QueueViewMBean.class,true);
		}
		/*def broker=getBroker(brokerName)
		broker.queues.collect { getQueue(brokerName,it.getKeyProperty('Destination')) }
		*/
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
