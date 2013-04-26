package org.workflow4people.activiti.command
import org.workflow4people.*

import org.open_t.dialog.command.Command

class ProcessInstanceCommand extends Command {
	def processInstanceId
	
	def getId() {
		return "Process_${processInstanceId}"
	}

	String processDefinitionId

	def listConfig=new ListConfig(name:'activitiProcessInstance',controller: 'activitiProcessInstance').configure {
		column name:'id',sortable:true		
		column name:'processDefinitionId',sortable:true		
	}

	
}
