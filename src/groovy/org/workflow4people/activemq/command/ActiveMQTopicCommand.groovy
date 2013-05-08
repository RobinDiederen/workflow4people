package org.workflow4people.activemq.command

import org.open_t.dialog.command.Command
import org.open_t.dialog.*
class ActiveMQTopicCommand extends Command {
		def getId() {
		return "${brokerName}____Topic____${name}"
	}
	String brokerName
	String name
	
	int enqueueCount
	int dequeueCount
	
	
	int consumerCount
	int producerCount
	
	int queueSize
	
	
	static listConfig=new ListConfig(name:'activeMQTopic',controller: 'activeMQTopic',actions:['dialog':'show']).configure {
		column name:'name',sortable:true
		
		column name:'enqueueCount',sortable:false
		column name:'dequeueCount',sortable:false
		column name:'producerCount',sortable:false
		column name:'consumerCount',sortable:false
				
	}
}