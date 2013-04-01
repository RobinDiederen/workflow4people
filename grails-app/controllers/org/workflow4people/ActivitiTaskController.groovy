package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*
import org.open_t.dialog.command.Command

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.workflow4people.activiti.command.*

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class ActivitiTaskController {

    ProcessEngine activitiProcessEngine
	RepositoryService activitiRepositoryService
	ManagementService activitiManagementService
	RuntimeService activitiRuntimeService
	IdentityService activitiIdentityService
	HistoryService activitiHistoryService
	FormService activitiFormService
	TaskService activitiTaskService
	def fileService

    def index = { 	
		redirect (action:list)
	}
	
	def listConfig=new ListConfig(name:'activitiTask',controller: 'activitiTask').configure {
		column name:'id',sortable:true		
		column name:'processDefinitionId',sortable:true	
		column name:'taskDefinitionKey',sortable:true
		column name:'name',sortable:false
		column name:'description',sortable:false
		column name:'priority',sortable:false
		column name:'assignee',sortable:false
		column name:'createTime',sortable:false		
		column name:'dueDate',sortable:false
		
	}
	
	def list() {		
		[ request:request, listConfig:this.listConfig]
	}

	def jsonlist() {				
		def datalist=activitiTaskService.createTaskQuery()
		
		switch(params.iSortCol_0) {
			case '0':
				datalist=datalist.orderByTaskId()
			break
						
			case '1':
				datalist=datalist.orderByProcessInstanceId()
			break
			
		}
				
		switch (params.sSortDir_0) {
			case 'asc':
				datalist=datalist.asc()
			break
			case 'desc':
				datalist=datalist.desc()
			break
		}
		
		Integer firstResult=params.iDisplayStart?new Integer(params.iDisplayStart):0
		Integer maxResults=params.iDisplayLength?new Integer(params.iDisplayLength):10
		
		datalist=datalist.listPage(firstResult,maxResults)
		
		def totalRecords=activitiTaskService.createTaskQuery().count()
		render listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}
	
	def dialog() {
		def pd=activitiRepositoryService.getProcessDefinition(params.id)
		def processDefinition=new ProcessDefinitionCommand(id:params.id,name:pd.name,description:pd.description,key:pd.key,version:pd.version)
		// The construct below excludes key and id ... 
		//def processDefinition=new ProcessDefinitionCommand()
		//processDefinition.getFrom(pd)
		
		[processDefinition:processDefinition]
	}
	
	def submitdialog = { ProcessDefinitionCommand processDefinition ->
		//ProcessDefinition pd=activitiRepositoryService.getProcessDefinition(processDefinition.id)
		
		
		def result = [
			success:successFlag,
			message:resultMessage,
			id: domainClassInstance.id,
			//name: domainClassInstance.toString(),
			//errorFields:theErrorFields
		]
		res=[result:result]
		render res as JSON
	}
	
}
