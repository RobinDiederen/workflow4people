package org.workflow4people

class WorkflowEngine {
	static listProperties=['id','name','title','description']

    static constraints = {
    	name(help:'x',class:'wide',blank:false)
    	title(help:'x',class:'wide')
        description(size:0..50000,help:'x')
        dateCreated(nullable:true,edit:false,help:'x')
        lastUpdated(nullable:true,edit:false,help:'x')        
    }
	
	String name
	String title
	String description
	Date dateCreated
	Date lastUpdated
	
	String toString() {
		return name;
	}
}
