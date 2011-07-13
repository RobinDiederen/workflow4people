package org.workflow4people

import java.util.Date;

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
    }
	
	static hasMany = [candidateUsers: Person,candidateGroups:Authority]
	String name
	String description
	int priority
	
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
}
