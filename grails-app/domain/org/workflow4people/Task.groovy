package org.workflow4people

import java.util.Date;

import org.apache.solr.common.SolrInputDocument;

class Task {
	static transients = ["noMessage"]
   	//static belongsTo=[workflow:Workflow]

   	static listProperties=['id','description','dueDate','assignee']
    //static fetchMode = [workflow:'eager',form:'eager']
/*   	                       
    static mapping = {
        workflow fetch:"join"
        form fetch: "join"
        	
    }
  */                  
    static constraints = {
		name(nullable:true)
		description(nullable:true)
		dateCreated(nullable:true,edit:false,help:'x')
		dueDate(edit:false,nullable:true)
		completionDate(nullable:true)
		lastUpdated(nullable:true,edit:false,help:'x')        
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
	
	
//	def Task(){
//		taskStatus=TaskStatus.find("from TaskStatus t where t.name='new'")
//	}
	
	
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
		
		
		sid.addField("externalId",externalId)
		sid.addField("externalWorkflowId",externalWorkflowId)
		
		/*
		candidateGroups.each { cg -> 
			sid.addField("candidateGroup",cg.authority)
			
		}
		
		candidateUsers.each { cu ->
			sid.addField("candidateUser",cu.username)
			
		}
			*/	
		return sid
	}
	
	
}
