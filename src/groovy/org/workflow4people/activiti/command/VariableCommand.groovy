package org.workflow4people.activiti.command

import org.open_t.dialog.command.Command
import org.open_t.dialog.*
class VariableCommand extends Command {
	static listProperties=['name','value']
	String parentId
	String parentType
	String name
	String value
	String variableClassName

	def getId() {
		return "${parentType}_${parentId}_${name}"
	}
	
	void setId(idValue) {
		(parentType,parentId,name)=idValue.split('_')
	}
	
	static listConfig=new ListConfig(name:'activitiVariable',controller: 'activitiVariable').configure {
		//column name:'id',sortable:true
		column name:'name',sortable:true
		column name:'value',sortable:true
	}
}
