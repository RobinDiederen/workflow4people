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
		render (view:'/dialog/list',model:[ request:request, listConfig:ActiveMQMessageCommand.listConfig])
	}

	def jsonlist() {
		def (brokerName,queueType,queueName)=params.objectId.split("____")
		def queue
		if (queueType=="Queue") {
			queue=activeMQService.getQueue(brokerName,queueName)
		} else {
			queue=activeMQService.getTopic(brokerName,queueName)
		}
		def messages=queue.browse()
		
		def datalist=[]
		
		datalist=messages.collect { message ->			
			def props = message.compositeType.keySet().collectEntries { key -> ["${key}": message."${key}"] }
			new ActiveMQMessageCommand(JMSMessageID:message.JMSMessageID,contentMap:message.ContentMap,JMSDestination:message.JMSDestination,props:props,brokerName:brokerName,queueName:queueName)				
		}
		render ActiveMQMessageCommand.listConfig.paginateList(datalist,params) as JSON		
	}	
	
	def dialog() {		
		def (brokerName,queueName,messageId)=params.id.split("____")
		def queue=activeMQService.getQueue(brokerName,queueName)
		def message=queue.getMessage(messageId)
		def props = message.compositeType.keySet().collectEntries { key -> ["${key}": message."${key}"] }
		def messageCommand=new ActiveMQMessageCommand(JMSMessageID:message.JMSMessageID,contentMap:message.ContentMap,JMSDestination:message.JMSDestination,props:props,brokerName:brokerName,queueName:queueName)
		[messageCommand:messageCommand]
	}
	
}
