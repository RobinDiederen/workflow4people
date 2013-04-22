package org.workflow4people.activemq.command

import org.open_t.dialog.command.Command

class ActiveMQMessageCommand extends Command {
		def getId() {
		return "${brokerName}_${queueName}_${JMSMessageID}"
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
	
	static listConfig=new org.workflow4people.ListConfig(name:'activeMQMessage',controller: 'activeMQMessage',actions:['dialog':'show']).configure {
		column name:'JMSMessageID',sortable:true				
	}
}
