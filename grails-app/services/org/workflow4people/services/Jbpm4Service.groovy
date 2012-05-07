/*

 * Workflow4people
 * Copyright 2009-2011, Open-T B.V., and individual contributors as indicated
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

import org.jbpm.api.ExecutionService;
import org.jbpm.api.IdentityService;
import org.jbpm.api.TaskService;
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
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()		
		taskService=processEngine.getTaskService()
		identityService=processEngine.getIdentityService()		
	}

	static exposes = ['jms']

    boolean transactional = false
    

    @Queue(name="wfp.jbpm4.out.workflow.new")
    def newWorkflow(msg) {
		log.debug "wfp.jbpm4.out.workflow.new received: ${msg}"
		
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

		def document = new XmlSlurper().parseText(workflow.document.xmlDocument)

		document.header.processInstanceId=workflow.id
		document.header.documentId=workflow.document.id
		def outputBuilder = new StreamingMarkupBuilder()

		workflow.document.xmlDocument=outputBuilder.bind { mkp.yield document }
				
		workflow.save(flush:true,failOnError:true)
		
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
		log.debug "wfp.jbpm4.out.workflow.new processed: ${msg}"
		return null					
	}

	@Queue(name="wfp.jbpm4.out.workflow.update")
	def updateWorkflowOut(msg) {
		log.debug "wfp.jbpm4.out.workflow.update received: ${msg}"
		java.lang.Long id=new java.lang.Long (msg.id)
		def workflow=Workflow.get(id)
		log.debug "wfp.jbpm4.out.workflow.update processed: ${msg}"
		return null
	}
	
	
	
	
	@Queue(name="wfp.jbpm4.in.workflow.update")
	def updateWorkflowIn(msg) {
		log.debug "wfp.jbpm4.in.workflow.update received: ${msg}"
		def processInstance=executionService.findProcessInstanceById(msg.id)
		log.debug "wfp.jbpm4.in.workflow.update processed: ${msg}"
		return null
	}
	
	@Queue(name="wfp.jbpm4.out.workflow.delete")
	def deleteWorkflowOut(msg) {
		log.debug "wfp.jbpm4.out.workflow.delete received: ${msg}"
		return null

	}
	
	@Queue(name="wfp.jbpm4.in.workflow.delete")
	def deleteWorkflowIn(msg) {
		log.debug "wfp.jbpm4.in.workflow.delete received: ${msg}"
		def processInstance=executionService.findProcessInstanceById(msg.id)
		def engine=WorkflowEngine.findByName("jbpm4")
		def workflow=Workflow.findByWorkflowEngineAndExternalId(engine,msg.id)
		if (workflow) {
			if (!workflow.completionDate) workflow.completionDate=new Date()
			workflow.save(failOnError:true,flush:true)
		}
		log.debug "wfp.jbpm4.in.workflow.delete processed: ${msg}"
		return null
	}
	
	
	
	@Queue(name="wfp.jbpm4.in.task.new")
	def newTaskIn(msg) {
		log.debug "wfp.jbpm4.in.task.new received: ${msg}"
		return null
	}
	
	@Queue(name="wfp.jbpm4.in.task.update")
	def updateTaskIn(msg) {
		log.debug "wfp.jbpm4.in.task.update received: ${msg}"
		
		
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
			//if (workflow) {
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
						person.addtocandidateUsers(person)
					}					
				}
				
				task.noMessage=true

				task.save(failOnError:true,flush:true)
			} // withTransaction
		}
		log.debug "wfp.jbpm4.in.task.update processed: ${msg}"
		
		return null
		
	}
	
	@Queue(name="wfp.jbpm4.out.task.update")
	def updateTaskOut(msg) {
		log.debug "wfp.jbpm4.out.task.update received: ${msg}"
		
		def task = Task.get(msg.id)
		if (task.outcome) {
			taskService.completeTask(task.externalId,task.outcome)
			task.completionDate=new Date()
			task.noMessage=true
			task.save(flush:true,failOnError:true)
		}
		log.debug "wfp.jbpm4.out.task.update processed: ${msg}"
		return null
	}
	
	
	@Queue(name="wfp.jbpm4.in.task.delete")
	def deleteTask(msg) {
		log.debug "wfp.jbpm4.in.task.delete received: ${msg}"
		/*def task=Task.findByExternalId(msg.id)
		if(task) {
			task.delete(failOnError:true,flush:true)
			log.debug "TASK ${task.id} DELETED (exernal id was ${msg.id}"
		}*/
		log.debug "wfp.jbpm4.in.task.delete processed: ${msg}"
		
		return null

	}
	@Queue(name="wfp.jbpm4.in.workflow.new")
	def inWorkflowNew(msg) { 
		log.debug "wfp.jbpm4.in.workflow.new received: ${msg}"
		return null
	}
	
	@Queue(name="wfp.jbpm4.out.task.new")
	def outTaskNew(msg) {
		log.debug "wfp.jbpm4.out.task.new received: ${msg}"
		return null
	}	
}
