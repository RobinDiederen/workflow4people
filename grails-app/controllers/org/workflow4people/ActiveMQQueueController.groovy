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
		[ request:request, listConfig:ActiveMQQueueCommand.listConfig]
	}

	def jsonlist() {
		def queues=activeMQService.getQueues(params.objectId)
		def totalRecords=queues.size()
		def datalist=[]
		if (totalRecords>0) {
		
		// convert to list
		datalist=queues.collect { queue ->			
			def queueCommand=new ActiveMQQueueCommand(brokerName:params.objectId)
			queueCommand.getFrom(queue)
			return queueCommand			
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
	
		
		
		render ActiveMQQueueCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}	
	
	def dialog() {
		def (brokerName,queueType,queueName)=params.id.split("____")
		def queue=activeMQService.getQueue(brokerName,queueName)
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
		[queueCommand:queueCommand]
	}
	
}
