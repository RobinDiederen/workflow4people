package org.workflow4people
import javax.management.remote.JMXConnectorFactory
import javax.management.remote.JMXServiceURL
import javax.management.remote.*


import org.apache.activemq.broker.jmx.*
import javax.management.*
import org.apache.activemq.broker.jmx.*
import org.apache.activemq.broker.jmx.BrokerView
import javax.management.*
import javax.jms.*

import grails.converters.JSON
import org.workflow4people.activemq.command.*


class ActiveMQController {
	
	def activeMQService
	def jmsService

    def index = { }
	
	def list() {
		[ request:request, listConfig:ActiveMQBrokerCommand.listConfig]
	}

	def jsonlist() {
	
		def brokers=activeMQService.brokers
		def totalRecords=brokers.size()
		
		// convert to list
		def datalist=brokers.collect { broker ->
			def queues=broker.queues.collect { it.getKeyProperty('Destination') }.join('<br>')
			def topics=broker.topics.collect { it.getKeyProperty('Destination') }.join('<br>')
			new ActiveMQBrokerCommand(brokerName:broker.brokerName,queues:queues,topics:topics,totalEnqueueCount:broker.totalEnqueueCount,totalDequeueCount:broker.totalDequeueCount)
		}
		
		switch(params.iSortCol_0) {
			case '0':
				//datalist=datalist.orderByProcessInstanceId()
			break
						
			case '1':
				datalist=datalist.sort { it.brokerName}
			break
			
		}
				
		switch (params.sSortDir_0) {
			case 'asc':
				//datalist=datalist
			break
			case 'desc':
				datalist=datalist.reverse()
			break
		}
		
		Integer firstResult=params.iDisplayStart?new Integer(params.iDisplayStart):0
		Integer maxResults=params.iDisplayLength?new Integer(params.iDisplayLength):10
		
		// pagination
		if (firstResult>totalRecords) { firstResult=totalRecords }
		if ((firstResult+maxResults)>totalRecords) {maxResults=totalRecords-firstResult}
		datalist=datalist[firstResult..maxResults-1]
		
		render ActiveMQBrokerCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}
	
	
	
	
	
	
	
	
	def test = {
		JMXServiceURL url = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi");
		JMXConnector connector = JMXConnectorFactory.connect(url, null);
		connector.connect();
		MBeanServerConnection connection =connector.getMBeanServerConnection();
		println connection.properties
		//println connection.properties
		
		
		
		println "Brokers:"
		ObjectName brokerQueryName = new ObjectName("org.apache.activemq:BrokerName=*,Type=Broker");
		connection.queryMBeans(brokerQueryName, null).each {  broker ->
			BrokerViewMBean mbean =(BrokerViewMBean) MBeanServerInvocationHandler.newProxyInstance(connection, broker.name, BrokerViewMBean.class, true);
			
			println broker.name
			println broker.class.name
			println mbean.properties			
		}
		println "============================"
		
		
		
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

		//activeMQService.init()
		def ddsQueue=activeMQService.getQueue("ddsBroker","wfp.engine.jbpm4")
		println "DDS queue size: ${ddsQueue.getQueueSize()}"
		println ddsQueue.browse()
		def res=[queueSize:ddsQueue.getQueueSize(),browse:ddsQueue.browse()]
		render res as JSON
	}
	
	def test3 = {
		//activeMQService.init()
		def brokers=activeMQService.brokers
		activeMQService.brokers.each { broker ->
			println broker.properties
		}
		
		def res=[brokers:brokers]
		render res as JSON
	}
	
	def create = {
		jmsService.send("testqueue",[messageType:"test",id:"lalala",name:"aap"])
		def res=[message:"Message sent to testqueue"]
		render res as JSON
	}
	
	
}
