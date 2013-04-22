package org.workflow4people.activemq.command

import org.open_t.dialog.command.Command

class ActiveMQBrokerCommand extends Command {
	static listProperties=['brokerName','queues','topics','totalEnqueueCount','totalDequeueCount']
	String brokerName
	String queues
	String topics
	int totalEnqueueCount
	int totalDequeueCount
	boolean persistent
	String brokerVersion
	String VMURL
	String brokerId
	String openWireURL
	int totalConsumerCount
	int totalProducerCount
	String dataDirectory
	int totalMessageCount
	boolean slave
	String uptime
	
	def getId() {
		return brokerName
	}

	static listConfig=new org.workflow4people.ListConfig(name:'activeMQBroker',controller: 'activeMQBroker',idName:'brokerName',actions:['dialog':'show']).configure {
		column name:'brokerName',sortable:true
		column name:'queues',sortable:false
		column name:'topics',sortable:false
		column name:'totalEnqueueCount',sortable:false
		column name:'totalDequeueCount',sortable:false
	}
}
