package org.workflow4people
import java.lang.ref.ReferenceQueue.Null;

import javax.management.remote.*


import org.apache.activemq.broker.jmx.*
import javax.management.*
import org.apache.activemq.broker.jmx.*
import javax.management.*
import javax.jms.*

import grails.converters.JSON
import org.workflow4people.activemq.command.*

import grails.plugins.springsecurity.Secured
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])

class ActiveMQMessageController {
	
	def activeMQService
	def jmsService

    def index = { }
	
	def list() {
		[ request:request, listConfig:ActiveMQMessageCommand.listConfig]
	}

	def jsonlist() {
		def (brokerName,queueName)=params.objectId.split("_")
		def queue=activeMQService.getQueue(brokerName,queueName)
		def messages=queue.browse()
		
		
		def totalRecords=messages.size()
		def datalist=[]
		if (totalRecords>0) {
		
			// convert to list
			datalist=messages.collect { message ->			
				def props = message.compositeType.keySet().collectEntries { key -> ["${key}": message."${key}"] }
				def messageCommand=new ActiveMQMessageCommand(JMSMessageID:message.JMSMessageID,contentMap:message.ContentMap,JMSDestination:message.JMSDestination,props:props,brokerName:brokerName,queueName:queueName)
				//def props = message.compositeType.keySet().collectEntries { key -> ["${key}": message."${key}"] } 
				//println "PROPS: ${props}"
				//messageCommand.getFrom(props)
				//println props.containsKey('JMSDestination')
				return messageCommand
			}
			
			switch(params.iSortCol_0) {
				case '0':
					//datalist=datalist.orderByProcessInstanceId()
				break
							
				case '1':
					datalist=datalist.sort { it.name}
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
			
		}
	
		
		
		render ActiveMQMessageCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}	
	
	def dialog() {		
		def (brokerName,queueName,messageId)=params.id.split("_")
		def queue=activeMQService.getQueue(brokerName,queueName)
		def message=queue.getMessage(messageId)
		def props = message.compositeType.keySet().collectEntries { key -> ["${key}": message."${key}"] }
		println message['ContentMap'].class.name
		def messageCommand=new ActiveMQMessageCommand(JMSMessageID:message.JMSMessageID,contentMap:message.ContentMap,JMSDestination:message.JMSDestination,props:props,brokerName:brokerName,queueName:queueName)
		/*
		//println "BROWSE: ${queue.browse()}"
		
		println "BROWSE*:"
		queue.browse().each { cmsg -> 
			println "VALUES: ${cmsg.values()}"
			println cmsg.class.name
			println cmsg.compositeType.keySet()
			println "ContentMap: ${cmsg.get('ContentMap')}"
			println "BooleanProperties: ${cmsg.get('BooleanProperties')}"
			
			println "TIMESTAMP: ${cmsg['JMSTimestamp']}"
						
			
		}
		def queueCommand=new ActiveMQQueueCommand(brokerName:brokerName)
		queueCommand.getFrom(queue)
		*/		
		[messageCommand:messageCommand]
	}
	
}
