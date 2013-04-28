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
class ActiveMQBrokerController {
	
	def activeMQService

    def index = { }
	
	def list = { render (view:'/dialog/list', model:[listConfig:ActiveMQBrokerCommand.listConfig,request:request]) }

	def jsonlist() {
	
		def brokers=activeMQService.brokers
		
		// convert to list
		def datalist=brokers.collect { broker ->
			def queues=broker.queues.collect { it.getKeyProperty('Destination') }.join('<br>')

			def topics=broker.topics.collect { it.getKeyProperty('Destination') }.join('<br>')
			new ActiveMQBrokerCommand(brokerName:broker.brokerName,queues:queues,topics:topics,totalEnqueueCount:broker.totalEnqueueCount,totalDequeueCount:broker.totalDequeueCount)
		}

		render ActiveMQBrokerCommand.listConfig.paginateList(datalist,params) as JSON
				
	}	
	
	def dialog() {
		def broker=activeMQService.getBroker(params.id)
		def brokerCommand=new ActiveMQBrokerCommand(brokerName:broker.brokerName)

		brokerCommand.getFrom(broker)
		
		[brokerCommand:brokerCommand]
	}
	
	def submitdialog = { ActiveMQBrokerCommand activeMQBrokerCommand ->				
		def result = [
			success:true,
			message:"",
			id: activeMQBrokerCommand.id,
		]
		def res=[result:result]		
		render res as JSON
	}
	
}
