package org.workflow4people.activemq.command

import org.open_t.dialog.command.Command
import org.open_t.dialog.*
class ActiveMQMessageCommand extends Command {
		def getId() {
		return "${brokerName}____${queueName}____${JMSMessageID}"
	}
	
		/*
		 * [BooleanProperties, ByteProperties, ContentMap, DoubleProperties, FloatProperties, IntProperties, JMSCorrelationID, JMSDeliveryMode, JMSDestination, JMSExpiration, JMSMessageID, JMSPriority, JMSRedelivered, JMSReplyTo, JMSTimestamp, JMSType, JMSXGroupID, JMSXGroupSeq, LongProperties, OriginalDestination, PropertiesText, ShortProperties, StringProperties]
	
		 */
	String brokerName
	String queueName
	Map props
	String JMSMessageID
	String JMSCorrelationID
	String JMSDeliveryMode
	String JMSDestination
	String contentMap
	
	static listConfig=new ListConfig(name:'activeMQMessage',controller: 'activeMQMessage',actions:['dialog':'show']).configure {
		column name:'JMSMessageID',sortable:true				
	}
}
