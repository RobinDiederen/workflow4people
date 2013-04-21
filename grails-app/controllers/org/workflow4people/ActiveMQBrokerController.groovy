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


class ActiveMQBrokerController {
	
	def activeMQService

    def index = { }
	
	def list() {
		[ request:request, listConfig:ActiveMQBrokerCommand.listConfig]
	}

	def jsonlist() {
	
		def brokers=activeMQService.brokers
		def totalRecords=brokers.size()
		
		// convert to list
		def datalist=brokers.collect { broker ->
			def queues=broker.queues.collect { it.getKeyProperty('Destination') }.join('<br>')

			def topics=broker.topics.collect { it.getKeyProperty('Destination') }.join('<br>')
			new ActiveMQBrokerCommand(brokerName:broker.brokerName,queues:queues,topics:topics,totalEnqueueCount:broker.totalEnqueueCount,totalDequeueCount:broker.totalDequeueCount)
		}
		
		switch(params.iSortCol_0) {
			case '0':
				//datalist=datalist.orderByProcessInstanceId()
			break
						
			case '1':
				datalist=datalist.sort { it.brokerName}
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
		
		def actions= {  doc,env -> """<div class="btn-group">
                                        <span class="btn btn-small" onclick="dialog.formDialog(${doc.brokerName},'workflowDefinition', { refresh : '${env.detailTableId}'}, null)"></span>
                                        <a class="btn btn-small" href="${createLink(controller:'dataModelEditor',action:'workflow',id:doc.id)}">model &raquo;</a>
                                        <span class="btn btn-small" onclick="dialog.deleteDialog(${doc.id},'workflowDefinition',{ refresh : '${env.detailTableId}'})">&times;</span>
                                    </div>"""
					}

		
		render ActiveMQBrokerCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}	
	
	def dialog() {
		def broker=activeMQService.getBroker(params.id)
		def brokerCommand=new ActiveMQBrokerCommand(brokerName:broker.brokerName)

		//def brokerCommand=new ActiveMQBrokerCommand()
		brokerCommand.getFrom(broker)
		
		[brokerCommand:brokerCommand]
	}
	/*
	def submitdialog = { ProcessDefinitionCommand processDefinition ->
		//ProcessDefinition pd=activitiRepositoryService.getProcessDefinition(processDefinition.id)
		
		
		def result = [
			success:successFlag,
			message:resultMessage,
			id: domainClassInstance.id,
			//name: domainClassInstance.toString(),
			//errorFields:theErrorFields
		]
		res=[result:result]
		render res as JSON
	}
	*/
}
