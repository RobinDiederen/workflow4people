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

class ActiveMQTopicController {
	
	def activeMQService

    def index = { }
	
	def list() {		
		render (view:'/dialog/list',model:[ request:request, listConfig:ActiveMQTopicCommand.listConfig])
	}

	def jsonlist() {
		
		def topics=activeMQService.getTopics(params.objectId)

		// convert to list
		def datalist=topics.collect { queue ->			
			def topicCommand=new ActiveMQTopicCommand(brokerName:params.objectId)
			topicCommand.getFrom(queue)
			return topicCommand			
		}
		
		render ActiveMQTopicCommand.listConfig.paginateList(datalist,params) as JSON
				
	}	
	
	def dialog() {		
		def (brokerName,queueType,topicName)=params.id.split("____")
		def queue=activeMQService.getTopic(brokerName,topicName)
		def topicCommand=new ActiveMQTopicCommand(brokerName:brokerName)
		topicCommand.getFrom(queue)		
		[topicCommand:topicCommand]
	}

}
