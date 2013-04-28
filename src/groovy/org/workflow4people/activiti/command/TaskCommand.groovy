package org.workflow4people.activiti.command

import org.open_t.dialog.command.Command
import org.open_t.dialog.*
class TaskCommand extends Command {
	String name
	String description	
	String assignee
	Date dueDate
	String owner
	Date createTime
	int priority
	String taskId
	String processDefinitionId
	String processInstanceId
	
	def getId() {
		return "Task_${taskId}"
	}
	
	void setId(idValue) {
		taskId=idValue.split('_')[1]
	}
	
	static listConfig=new ListConfig(name:'activitiTask',controller: 'activitiTask').configure {
		column name:'taskId',sortable:true
		column name:'processInstanceId',sortable:true	
		column name:'processDefinitionId',sortable:false
	


		column name:'name',sortable:true
		column name:'description',sortable:true
		column name:'assignee',sortable:true

		column name:'priority',sortable:true
		column name:'createTime',sortable:true		
		column name:'dueDate',sortable:true
	

	}
}
