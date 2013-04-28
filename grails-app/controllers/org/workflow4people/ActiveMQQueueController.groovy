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

class ActiveMQQueueController {
	
	def activeMQService
	def jmsService

    def index = { }
	
	def list() {
		render (view:'/dialog/list',model:[ request:request, listConfig:ActiveMQQueueCommand.listConfig])
	}

	def jsonlist() {
		def queues=activeMQService.getQueues(params.objectId)
		
		// convert to list
		def datalist=queues.collect { queue ->			
			def queueCommand=new ActiveMQQueueCommand(brokerName:params.objectId)
			queueCommand.getFrom(queue)
			return queueCommand			
		}
			
		render ActiveMQQueueCommand.listConfig.paginateList(datalist,params) as JSON
				
	}	
	
	def dialog() {
		def (brokerName,queueType,queueName)=params.id.split("____")
		def queue=activeMQService.getQueue(brokerName,queueName)
		def queueCommand=new ActiveMQQueueCommand(brokerName:brokerName)
		queueCommand.getFrom(queue)		
		[queueCommand:queueCommand]
	}
	
}
