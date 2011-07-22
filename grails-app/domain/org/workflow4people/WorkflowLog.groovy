package org.workflow4people

class WorkflowLog {
   	static belongsTo=[workflow:Workflow]
   	static listProperties=['id','dateCreated','message','person']

   	                  
    static constraints = {
   		workflow()
   		dateCreated()
   		message()
   		person(nullable:true)
    }
   	
   	Date dateCreated
   	String message
   	Person person
}