package org.workflow4people

class TaskStatus {
	static listProperties=['id','name','title','description','cssClass']
	
    static constraints = {
		name()
		title()
		description()
		cssClass()
    }
	
	String name
	String title
	String description	
	String cssClass
	
	String toString() {
		
		 return "${title} (${name})"
	  }
}
