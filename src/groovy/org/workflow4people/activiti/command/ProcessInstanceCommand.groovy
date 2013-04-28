package org.workflow4people.activiti.command
import org.workflow4people.*
import org.open_t.dialog.*
import org.open_t.dialog.command.Command

class ProcessInstanceCommand extends Command {
	def processInstanceId
	def ended
	def suspended
	
	def getId() {
		return "Process_${processInstanceId}"
	}
	
	void setId(idValue) {
		processInstanceId=idValue.split('_')[1]
	}

	String processDefinitionId

	static listConfig=new ListConfig(name:'activitiProcessInstance',controller: 'activitiProcessInstance').configure {
		column name:'id',sortable:true		
		column name:'processDefinitionId',sortable:true
		column name:'suspended',sortable:false
		column name:'ended',sortable:false
		
	}

	
}
