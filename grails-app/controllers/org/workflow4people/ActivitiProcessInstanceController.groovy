package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*
import org.open_t.dialog.command.Command

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.workflow4people.activiti.command.*

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class ActivitiProcessInstanceController {

    ProcessEngine activitiProcessEngine
	RepositoryService activitiRepositoryService
	ManagementService activitiManagementService
	RuntimeService activitiRuntimeService
	IdentityService activitiIdentityService
	HistoryService activitiHistoryService
	FormService activitiFormService
	def fileService

    def index = { 	
		redirect (action:list)
	}
	
	def listConfig=new ListConfig(name:'activitiProcessInstance',controller: 'activitiProcessInstance').configure {
		column name:'id',sortable:true		
		column name:'processDefinitionId',sortable:true		
	}
	
	def list() {		
		[ request:request, listConfig:this.listConfig]
	}

	def jsonlist() {				
		def datalist=activitiRuntimeService.createProcessInstanceQuery().active()

	
		switch(params.iSortCol_0) {
			case '0':
				datalist=datalist.orderByProcessInstanceId()
			break
						
			case '1':
				datalist=datalist.orderByProcessDefinitionId()
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

		def dl =datalist.collect {
			new ProcessInstanceCommand(processInstanceId:it.getProcessInstanceId())
		} 
	
		
		def totalRecords=activitiRuntimeService.createProcessInstanceQuery().active().count()
		render listConfig.renderList(dl,totalRecords,params) as JSON
				
	}
	/*
	def variableListConfig=new ListConfig(name:'activitiProcessVariable',controller: 'activitiProcessVariable').configure {
		column name:'id',sortable:true
		column name:'name',sortable:true
		column name:'value',sortable:true
	}
	*/
	
	def dialog() {
		def id=params.id.split("_")[1]
		def pi=activitiRuntimeService.createProcessInstanceQuery().processInstanceId(id).singleResult()
		def processInstance=new ProcessInstanceCommand(processInstanceId:id,processDefinitionId:pi.processDefinitionId)
		// The construct below excludes key and id ... 
		//def processDefinition=new ProcessDefinitionCommand()
		//processDefinition.getFrom(pd)
		
		[processInstance:processInstance]
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
