/*
 * Workflow4people
 * Copyright 2009-2013, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */

package org.workflow4people.services
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.*;
import org.springframework.beans.factory.InitializingBean;

import grails.plugin.jms.*
import org.workflow4people.*;

 
import groovy.xml.StreamingMarkupBuilder
import grails.plugin.jms.Queue

/**
 * Activiti JMS message service class
 * Listens to events for Activiti processes from both ends (Grails domain objects and Activiti task and process listeners)
 * 
 * @author Joost Horward
 */

class ActivitiService  {
	
	def documentService
	def solrService
	
	ProcessEngine activitiProcessEngine
	RepositoryService activitiRepositoryService
	ManagementService activitiManagementService
	RuntimeService activitiRuntimeService
	IdentityService activitiIdentityService
	HistoryService activitiHistoryService
	FormService activitiFormService
	TaskService activitiTaskService

	
	def domFactory
	
	def sessionFactory
	
	

	static exposes = ['jms']

    boolean transactional = false
	
	/**
	 * Process messages from jBPM and Wfp
	 * @param msg
	 * @return
	 */
	@Queue(name="wfp.engine.activiti")
	def HandleMessage(msg) {
		log.debug "activitiMessage received: ${msg}"
		switch (msg.messageType) {
			case "afterCreateActivitiWorkflow":
				// Do nothing
			break
			case "afterUpdateActivitiWorkflow":
				// Do nothing. The process instance would be accessible as follows:
				// def processInstance=executionService.findProcessInstanceById(msg.id)
			break
			case "afterDeleteActivitiWorkflow":
				afterDeleteActivitiWorkflow(msg)
			break
			
			case "afterCreateActivitiTask":
			break
			
			case "afterUpdateActivitiTask":
				afterUpdateActivitiTask(msg)
			break
			
			case "afterDeleteJbpmTask":
				afterDeleteActivitiTask(msg)
			break						

			case "afterCreateWfpWorkflow":
				afterCreateWfpWorkflow(msg)
			break
			case "afterUpdateWfpWorkflow":
			break
			case "afterDeleteWfpWorkflow":
			break
			case "afterCreateWfpTask":
			break
			case "afterUpdateWfpTask":
				afterUpdateWfpTask(msg)
			break
			case "afterDeleteWfpTask":
			break
		}
		log.debug "activitiMessage processed: ${msg}"
		
		return null
	}
    
	/**
	 * When a JBPM workflow is removed, we keep the wfp workflow and only populate the completion date.
	 * @param msg
	 * @return
	 */
	def afterDeleteActivitiWorkflow(msg) {
		def processInstance=executionService.findProcessInstanceById(msg.id)
		def engine=WorkflowEngine.findByName("activiti")
		def workflow=Workflow.findByWorkflowEngineAndExternalId(engine,msg.id)
		if (workflow) {
			if (!workflow.completionDate) workflow.completionDate=new Date()
			workflow.save(failOnError:true,flush:true)
		}
		return null
	}
	
	/**
	 * Handle task updates. The bulk of the logic is here. Due to the way jBPM handles the creation of a process instance there isn't much we can do before the first task exists.
	 * @param msg
	 * @return
	 */
	def afterUpdateActivitiTask(msg) {		
		org.activiti.engine.task.Task activitiTask = activitiTaskService.createTaskQuery().taskId(msg.id).singleResult()
			
		def task=Task.findByExternalId(msg.id)
		if (!task) {
			def executionId=acivitiTask.executionId
			jbpmTask.getExecutionId()
			def workflow=Workflow.findByExternalId(executionId)
			
			log.debug("Before wait for workflow instance")
			def iCounter = 1
			while (!workflow) {
				if (iCounter > 600) {
					log.error("Giving up waiting for workflow instance")
					break
				}
				log.error("wait for workflow instance, sleep for 100ms now ...")
				sleep(100)
				workflow=Workflow.findByExternalId(executionId)
				iCounter++
			}

			log.debug("After wait for workflow instance")
			
			org.workflow4people.Task.withTransaction { status ->
				task = new org.workflow4people.Task()
				task.workflow=workflow
				task.externalId=msg.id
				task.externalWorkflowId=activitiTask.getExecutionId()				
				task.description=activitiTask.description

				task.name=activitiTask.name

				// Hard-linked task name = form name for the moment
				def formName=activitiTask.name
				if(task.workflow?.workflowDefinition) {
					task.form=Form.findByWorkflowAndName(task.workflow.workflowDefinition,formName)
				}
				task.dueDate= activitiTask.dueDate
				task.priority=activitiTask.priority
				task.workflow=workflow
				// TODO Dit moet anders want getOutcomes bestaat niet voor Activiti
				/*
				taskService.getOutcomes (msg.id).each { outcome ->
					if (task.transitions){
						task.transitions="${task.transitions},${outcome}"
					} else {
						task.transitions=outcome
					}
				}
				*/
				if (activitiTask.assignee) {
					task.assignee=Person.findByUsername(activitiTask.assignee)
				}
				activitiTaskService.getIdentityLinksForTask(activitiTask.id).each { IdentityLink il ->
					if (il.type == IdentityLinkType.CANDIDATE && il.groupId) {
						def group=Authority.findByAuthority(il.groupId)
						task.addToCandidateGroups(group)
					}
					
					if (il.type == IdentityLinkType.CANDIDATE && il.userId) {
						def person=Person.findByUsername(il.groupId)
						task.addToCandidateUsers(person)						
					}					
				}
							
				task.noMessage=true

				task.save(failOnError:true,flush:true)
			} // withTransaction
		}
		return null
		
	}
	
	/**
	 * Processes the removal of a task on the Activiti end. 
	 * We remove it on the wfp side, too.
	 * @param msg
	 * @return
	 */

	def afterDeleteActivitiTask(msg) {
		org.workflow4people.Task.withTransaction { status ->
			def task=org.workflow4people.Task.findByExternalId(msg.id)
			if(task) {
				task.delete(failOnError:true,flush:true)
				// TODO maybe arrange this through a message queue so Solr and wfp are decoupled
				solrService.deleteItem(org.workflow4people.Task,msg.id)			
				log.debug "TASK ${task.id} DELETED (exernal id was ${msg.id}"
			}
		}
	}

	/**
	 * When a new workflow domain object is created in wfp start a new process instance in jBPM
 	 * @param msg	
 	 * 
	 */
    def afterCreateWfpWorkflow(msg) {
		Workflow.withTransaction { status ->			
			java.lang.Long id=new java.lang.Long (msg.id)
			def workflow=Workflow.get(id)
			LinkedHashMap variableMap = new LinkedHashMap()    							
			variableMap.put("documentId",workflow.document.id)
			variableMap.put("user",workflow.document.user)
			variableMap.put("group",documentService.getHomeGroup(workflow.document))
	    		
			def processInstance = activitiRuntimeService.startProcessInstanceByKey(workflow.workflowDefinition.name,variableMap)
					
			workflow.externalId=processInstance.id
			workflow.noMessage=true
			
			
			// Store the document again, now with the processInstanceId in it.
			log.debug "The original xml is ${workflow.document.xmlDocument}"
			def document = new XmlSlurper().parseText(workflow.document.xmlDocument)
			log.debug "The workflow id is ${workflow.id}"
			log.debug "The document id is ${workflow.document.id}"
			document.header.processInstanceId=workflow.id
			document.header.documentId=workflow.document.id
			def outputBuilder = new StreamingMarkupBuilder()
			def resultXML=outputBuilder.bind { mkp.yield document }.toString()			
			log.debug "The result XML is ${resultXML}"
			workflow.document.xmlDocument=resultXML
			log.debug "Saving document with xml Document ${workflow.document.xmlDocument}"
			workflow.document.save(flush:true,failOnError:true)

			log.debug "Saving workflow"
			workflow.save(flush:true,failOnError:true)
			
			log.debug "The xml document in workflow.document.xmlDocument is now ${workflow.document.xmlDocument}"
			log.debug "All done."
			
			def hibSession = sessionFactory.getCurrentSession()
			
			hibSession.flush()
			
			
			// Find the tasks that the process engine has created while we were waiting for it to return.		
			
			Task.findAllByExternalWorkflowId(workflow.externalId).each { task ->
				task.workflow=workflow
				task.noMessage=true
				if (!task.form){					
					org.activiti.engine.task.Task activitiTask = activitiTaskService.createTaskQuery().taskId(task.externalId).singleResult()
					// TODO convention for now: task name = form name
					def formName=activitiTask.name
					
					if(task.workflow?.workflowDefinition) {
						task.form=Form.findByWorkflowAndName(task.workflow.workflowDefinition,formName)
					}
				}
				
				task.save(flush:true,failOnError:true)		
			}		
		}
	}
	/**
	 * 
	 * @param msg
	 * @return
	 */

	def afterUpdateWfpTask(msg) {
		Task.withTransaction { status ->
			def task = Task.get(msg.id)
			if (task.outcome) {
				taskService.completeTask(task.externalId,task.outcome)
				task.completionDate=new Date()
				task.noMessage=true
				task.save(flush:true,failOnError:true)
			}
		}
	}
	
}
