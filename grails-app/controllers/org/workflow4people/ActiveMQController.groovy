package org.workflow4people
import javax.management.remote.JMXConnectorFactory
import javax.management.remote.JMXServiceURL
import javax.management.remote.*


import org.apache.activemq.broker.jmx.*
import javax.management.*
import org.apache.activemq.broker.jmx.*
import javax.management.*
import javax.jms.*

import grails.converters.JSON

class ActiveMQController {
	
	def activeMQService

    def index = { }
	
	def test = {
		JMXServiceURL url = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi");
		JMXConnector connector = JMXConnectorFactory.connect(url, null);
		connector.connect();
		MBeanServerConnection connection =connector.getMBeanServerConnection();
		println connection.properties
		//println connection.properties
		ObjectName name = new ObjectName("org.apache.activemq:BrokerName=wfpBroker,Type=Broker");
		
		println "Topics:"
		//ObjectName queryName = new ObjectName("org.apache.activemq:*");
		ObjectName queryName = new ObjectName("org.apache.activemq:BrokerName=wfpBroker,Type=Topic,*");
		connection.queryMBeans(queryName, null).each { topic ->
			println topic.name
		}
		println "============================"
		
		println "Queues:"
		//ObjectName queryName = new ObjectName("org.apache.activemq:*");
		ObjectName queueQueryName = new ObjectName("org.apache.activemq:BrokerName=wfpBroker,Type=Queue,*");
		connection.queryMBeans(queueQueryName, null).each { queue ->
			println queue.name
		}
		println "============================"
		
		
		
		BrokerViewMBean mbean =(BrokerViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, name, BrokerViewMBean.class, true);
		
		println mbean.class.name
		
		println "Queues:"
		def queues= mbean.getQueues()
		def queueMap=[:]
		queues.each { queueName ->
			println queueName
			println "QUEUE CLASS: ${queueName.class.name}"
		
			QueueViewMBean queue=(QueueViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, queueName, QueueViewMBean.class,true);
			println queue.name
			println queue.properties
			queueMap["${queue.name}"]=queue.properties
			
			//println QueueViewMBean.name
		  //def queue=MBeanServerInvocationHandler.newProxyInstance(connection, queueName, null,true);
		
		
		//  println queue.getName()
		}
		
		
		
		def res=[hello:"there",totalMessageCount:mbean.totalMessageCount,queues:queueMap]
		render res as JSON
	}
	
	def test2 = {
		activeMQService.init()
		def ddsQueue=activeMQService.getQueue("ddsBroker","wfp.engine.jbpm4")
		println "DDS queue size: ${ddsQueue.getQueueSize()}"
		println ddsQueue.browse()
		def res=[queueSize:ddsQueue.getQueueSize(),browse:ddsQueue.browse()]
		render res as JSON
	}
	
	
	
}
