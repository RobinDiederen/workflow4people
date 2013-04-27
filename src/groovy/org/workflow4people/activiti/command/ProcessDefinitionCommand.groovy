package org.workflow4people.activiti.command

import org.open_t.dialog.command.Command

class ProcessDefinitionCommand extends Command {

	String name
	String key
	String description
	String diagramResourceName
	
	static listConfig=new org.workflow4people.ListConfig(name:'activitiProcessDefinition',controller: 'activitiProcessDefinition').configure {
		column name:'id',sortable:true
		column name:'key',sortable:true
		column name:'version',sortable:true
		column name:'name',sortable:true
		column name:'description'
	}	
}
