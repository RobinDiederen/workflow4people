package org.workflow4people

class FormPage {
	static belongsTo = [form: Form]
	static hasMany = [formSection : FormSection]
	
	static listProperties=['id','position','name','title']

    static constraints = {		
		title(nullable:true)
		message(nullable:true)
    }
	
	
	int position
	String name="default"
	String title
	String message
}
