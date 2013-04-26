package org.workflow4people.activiti.command

import org.open_t.dialog.command.Command

class TaskCommand extends Command {
	//static listProperties=['name','description']
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
	
	static listConfig=new org.workflow4people.ListConfig(name:'activitiTask',controller: 'activitiTask').configure {
		column name:'id',sortable:true
		column name:'processInstanceId',sortable:true	
		column name:'processDefinitionId',sortable:false
	


		column name:'name',sortable:false
		column name:'description',sortable:false
		column name:'assignee',sortable:false

		column name:'priority',sortable:false
		column name:'createTime',sortable:false		
		column name:'dueDate',sortable:false
	

	}
}
