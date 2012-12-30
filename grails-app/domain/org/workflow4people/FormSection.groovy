package org.workflow4people

class FormSection {
	
	static belongsTo = [formPage: FormPage]
	static hasMany = [formItem : FormItem]
	
	static listProperties=['id','position','name','title']

	static constraints = {		
		title(nullable:true)
		message(nullable:true)
    }
	
	int position
	String name
	String title
	String message
}
