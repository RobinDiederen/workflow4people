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
		[ request:request, listConfig:ActiveMQTopicCommand.listConfig]
	}

	def jsonlist() {
		

		def topics=activeMQService.getTopics(params.objectId)

		def totalRecords=topics.size()
		def datalist=[]
		if (totalRecords>0) {
		
		// convert to list
		datalist=topics.collect { queue ->			
			def topicCommand=new ActiveMQTopicCommand(brokerName:params.objectId)
			topicCommand.getFrom(queue)
			return topicCommand			
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
		
		render ActiveMQTopicCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}	
	
	def dialog() {		
		def (brokerName,queueType,topicName)=params.id.split("____")
		def queue=activeMQService.getTopic(brokerName,topicName)
		println "BROWSE: ${queue.browse()}"
		def topicCommand=new ActiveMQTopicCommand(brokerName:brokerName)
		topicCommand.getFrom(queue)		
		[topicCommand:topicCommand]
	}

}
