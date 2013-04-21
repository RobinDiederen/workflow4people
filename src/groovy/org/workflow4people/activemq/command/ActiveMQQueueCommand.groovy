package org.workflow4people.activemq.command

import org.open_t.dialog.command.Command

class ActiveMQQueueCommand extends Command {
	def getId() {
		return "${brokerName}_${name}"
	}
	String brokerName
	String name
	
	int enqueueCount
	int dequeueCount
	
	
	int consumerCount
	int producerCount
	
	int queueSize
	
	
	static listConfig=new org.workflow4people.ListConfig(name:'activeMQQueue',controller: 'activeMQQueue').configure {
		column name:'name',sortable:true
		
		column name:'enqueueCount',sortable:false
		column name:'dequeueCount',sortable:false
		column name:'producerCount',sortable:false
		column name:'consumerCount',sortable:false
				
	}
}
