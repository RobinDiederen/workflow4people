package org.workflow4people
import grails.validation.Validateable;
@Validateable
class ReIndexDialog extends Command {
	static constraints = {		
		itemType(inList:['Document','Task'])
	}
			
	Long startId =0
	String itemType="Document"

}
