package org.workflow4people.activiti.command

import org.open_t.dialog.command.Command

class ProcessVariableCommand extends Command {
	static listProperties=['name','value']
	String processDefinitionId
	String name
	String value
	String variableClassName
	
	static listConfig=new org.workflow4people.ListConfig(name:'activitiProcessVariable',controller: 'activitiProcessVariable').configure {
		column name:'id',sortable:true
		column name:'name',sortable:true
		column name:'value',sortable:true
	}
}
