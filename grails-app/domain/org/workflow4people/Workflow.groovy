package org.workflow4people
import grails.plugin.jms.*

class Workflow {
	def jmsService
	
	static transients = ["noMessage"]
	static hasMany = [workflowLog:WorkflowLog]

	static listProperties=['id','workflowDefinition','dateCreated','dueDate','completionDate']

    static constraints = {
		externalId(nullable:true)
		name(nullable:true)
		workflowEngine(nullable:true)
		workflowDefinition(nullable:true)		
		dateCreated(nullable:true,edit:false,help:'x')
		dueDate(edit:false,nullable:true)
		completionDate(nullable:true)
		lastUpdated(nullable:true,edit:false,help:'x')
		status(nullable:true)        
	}
	
	WorkflowEngine workflowEngine
	WorkflowDefinition workflowDefinition
	String name
	Document document
	
	int priority
	
	Date dateCreated
	Date lastUpdated
	Date dueDate
	Date completionDate
	
	String externalId
	
	String status
	
	boolean noMessage=false
	                   	
   	String toString() {
   		return "Workflow ${workflowDefinition.name} ${id}";
   	}
	/*
	def afterInsert = {
		def engineName=workflowEngine.name
		String queueName="wfp.${engineName}.out.workflow.new"
		log.debug "SENDING MESSAGE"
	    jmsService.send(queueName,[id:id])
	    log.debug "MESSAGE SENT"
	    
	}
	
	def afterUpdate = {
		def engineName=workflowEngine.name
		String queueName="wfp.${engineName}.out.workflow.update"
		jmsService.send(queueName,[id:id])
	}
	
	def afterDelete = {
		def engineName=workflowEngine.name
		String queueName="wfp.${engineName}.out.workflow.delete"
	    jmsService.send(queueName,[id:id,externalId:externalId])
	}
	*/
	   
	def log(def message,def person=null) {
		def logInstance=new WorkflowLog()
		logInstance.message=message
		logInstance.workflow=this
		if(person) {
			logInstance.person=person
		}
		logInstance.save()
	}   
	
}
