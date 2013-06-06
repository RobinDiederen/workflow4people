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
package org.workflow4people
import java.util.Date;
import org.apache.solr.common.SolrInputDocument;
import org.open_t.dialog.*

/**
 * Task domain class
 * 
 * @author Joost Horward
 */
class Task {
	def solrService
	static transients = ["noMessage"]

	static listConfig=new ListConfig(name:'task',controller: 'task',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'description',sortable:true,filter:true
		column name:'dueDate',sortable:true,filter:true
		column name:'assignee',sortable:true,filter:true
	}
    static constraints = {
		name(nullable:true)
		description(nullable:true)
		dateCreated(nullable:true)
		dueDate(nullable:true)
		completionDate(nullable:true)
		lastUpdated(nullable:true)        
		assignee(nullable:true)
		outcome(nullable:true)
		transitions(nullable:true)
		form(nullable:true)
		externalId(nullable:true)
		externalWorkflowId(nullable:true)
		workflow(nullable:true)
		priority(nullable:true)
		cssClass(nullable:true)
		taskStatus(nullable:true)
		statusUser(nullable:true)
    }
	
	static hasMany = [candidateUsers: Person,candidateGroups:Authority]
	String name
	String description
	int priority
	String cssClass
		
	TaskStatus taskStatus 
	String statusUser
	
	Person assignee
	
	Form form

	Date dateCreated
	Date lastUpdated
	Date dueDate
	Date completionDate
	Workflow workflow
	
	String transitions
	String outcome=null
	String externalId
	String externalWorkflowId
	boolean noMessage=false
	
	def getCompleted() {
		return completionDate !=null
	}
	
	def getActive() {
		return completionDate ==null
	}
	
	def getTransitionsArray() {
		if (transitions) {
			return transitions.split(',')
		} else {
			return []
		}
	}
	
	/*
	 * Emulate status string behaviour with getter and setter
	 */
	def getStatus()  {
		if (taskStatus) {
			return taskStatus.name
		} else {
		return ""
		}
	}
	
	def updateStatus(String name) {
		log.debug "setting task status to ${name}"
		def theStatus=TaskStatus.findByName(name)
		if (theStatus) {
			taskStatus=theStatus			
		}		
	}
	
	
	def beforeInsert = {
		taskStatus=TaskStatus.findByName("new")
		if (workflow) {
			workflow.log("Task '${name}' created")
		}
		return true
	}
	
	def beforeUpdate = {
		if (isDirty('workflow')) {
			workflow.log("Task '${name}' created")			
		}		
		if (isDirty('outcome')) {
			workflow.log("Task '${name}' completed with outcome ${outcome}")
		}
		return true
		
	}
	
	def afterDelete() {
		log.debug "AfterDelete task ${id}"
		try {
			// TODO maybe arrange this through a message queue so Solr and wfp are decoupled
			solrService.deleteItem(Task,id)
		} catch (Exception e){
			log.error "Error while removing task from Solr: ${e.message}"
		}
	}

		
	SolrInputDocument getSolrInputDocument() {
		SolrInputDocument sid = new SolrInputDocument()
		sid.addField("id",this.id.toString())
		sid.addField("description",description)
		sid.addField("priority",priority)
		sid.addField("dateCreated",lastUpdated)		
		sid.addField("lastUpdated",lastUpdated)
		sid.addField("cssClass",cssClass)
		sid.addField("taskStatus",taskStatus)
		sid.addField("statusUser",statusUser)
		sid.addField("assignee",assignee?.username)


		sid.addField("dueDate",dueDate)
		sid.addField("completionDate",completionDate)

		sid.addField("workflow",workflow?.id)

		sid.addField("transitions",transitions)

		sid.addField("outcome",outcome)
		sid.addField("externalId",externalId)
		sid.addField("externalWorkflowId",externalWorkflowId)

		candidateGroups.each { cg -> 
			sid.addField("candidateGroups",cg.authority)			
		}

		candidateUsers.each { cu ->
			sid.addField("candidateUsers",cu.username)
		}			
		return sid
	}	
}
