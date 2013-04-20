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
import org.springframework.beans.factory.InitializingBean;

import grails.plugin.jms.*
import org.workflow4people.*;

import org.jbpm.api.* 
import groovy.xml.StreamingMarkupBuilder
import grails.plugin.jms.Queue

/**
 * JBPM4 JMS message service class
 * Listens to events for jBPM processes from both ends (Grails domain objects and JBPM4 domain objects)
 * 
 * @author Joost Horward
 */

class Jbpm4Service implements InitializingBean {
	
	def documentService
	
	def processEngine
	TaskService taskService
	ExecutionService executionService
	IdentityService identityService

	
	def domFactory
	
	def sessionFactory
	
	/**
	 * Initialization of jBPM service beans
	 */
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()		
		taskService=processEngine.getTaskService()
		identityService=processEngine.getIdentityService()		
	}

	static exposes = ['jms']

    boolean transactional = false
	
	/**
	 * Process messages from jBPM and Wfp
	 * @param msg
	 * @return
	 */
	@Queue(name="wfp.engine.jbpm4")
	def HandleMessage(msg) {
		log.debug "jbpmMessage received: ${msg}"
		switch (msg.messageType) {
			case "afterCreateJbpmWorkflow":
				// Do nothing
			break
			case "afterUpdateJbpmWorkflow":
				// Do nothing. The process instance would be accessible as follows:
				// def processInstance=executionService.findProcessInstanceById(msg.id)
			break
			case "afterDeleteJbpmWorkflow":
				afterDeleteJbpmWorkflow(msg)
			break
			
			case "afterCreateJbpmTask":
			break
			
			case "afterUpdateJbpmTask":
				afterUpdateJbpmTask(msg)
			break
			
			case "afterDeleteJbpmTask":
				afterDeleteJbpmTask(msg)
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
		log.debug "jbpmMessage processed: ${msg}"
		
		return null
	}
    
	/**
	 * When a JBPM workflow is removed, we keep the wfp workflow and only populate the completion date.
	 * @param msg
	 * @return
	 */
	def afterDeleteJbpmWorkflow(msg) {
		def processInstance=executionService.findProcessInstanceById(msg.id)
		def engine=WorkflowEngine.findByName("jbpm4")
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
	def afterUpdateJbpmTask(msg) {		
		def jbpmTask = taskService.getTask(msg.id)
		
		def task=Task.findByExternalId(msg.id)
		if (!task) {
			def executionId=jbpmTask.getExecutionId()
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
			
			Task.withTransaction { status ->
				task = new org.workflow4people.Task()
				task.workflow=workflow
				task.externalId=msg.id
				task.externalWorkflowId=jbpmTask.getExecutionId()
				task.description=jbpmTask.description
				task.name=jbpmTask.name
				def form
				def formName=jbpmTask.formResourceName ? jbpmTask.formResourceName : jbpmTask.name
				if(task.workflow?.workflowDefinition) {
					task.form=Form.findByWorkflowAndName(task.workflow.workflowDefinition,formName)
				}
				task.dueDate=jbpmTask.duedate
				task.priority=jbpmTask.priority
				task.workflow=workflow
				taskService.getOutcomes (msg.id).each { outcome ->
					if (task.transitions){
						task.transitions="${task.transitions},${outcome}"
					} else {
						task.transitions=outcome
					}
				}
				if (jbpmTask.assignee) {
					task.assignee=Person.findByUsername(jbpmTask.assignee)
				}
				taskService.getTaskParticipations(msg.id).each { participation ->
					if (participation.type == "candidate" && participation.groupId) {
						def group=Authority.findByAuthority(participation.groupId)
						task.addToCandidateGroups(group)
					}
					if (participation.type == "candidate" && participation.userId) {
						def person=Person.findByUsername(participation.userId)
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
	 * Processes the removal of a task on the jBPM end. 
	 * We remove it on the wfp side, too.
	 * @param msg
	 * @return
	 */

	def afterDeleteJbpmTask(msg) {
		Task.withTransaction { status ->
			def task=Task.findByExternalId(msg.id)
			if(task) {
				task.delete(failOnError:true,flush:true)
				// The afterDelete event handler removes the task from Solr
				log.debug "TASK ${task.id} DELETED (exernal id was ${msg.id}"
			}
		}
	}

	/**
	 * When a new workflow domain object is created in wfp start a new process instance in jBPM
 	 * @param msg	
	 */
    def afterCreateWfpWorkflow(msg) {
		Workflow.withTransaction { status ->			
			java.lang.Long id=new java.lang.Long (msg.id)
			def workflow=Workflow.get(id)
			LinkedHashMap variableMap = new LinkedHashMap()    							
			variableMap.put("documentId",workflow.document.id)
			variableMap.put("user",workflow.document.user)
			variableMap.put("group",documentService.getHomeGroup(workflow.document))
	    		
			def processInstance = executionService.startProcessInstanceByKey(workflow.workflowDefinition.name,variableMap)
					
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
					def jbpmTask = taskService.getTask(task.externalId)
					def formName=jbpmTask.formResourceName ? jbpmTask.formResourceName : jbpmTask.name
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
