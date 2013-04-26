package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*
import org.open_t.dialog.command.Command

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.workflow4people.activiti.command.*

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class ActivitiProcessVariableController {

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
	
	def listConfig=new ListConfig(name:'activitiProcessVariable',controller: 'activitiProcessVariable').configure {
		column name:'name',sortable:true		
		column name:'value',sortable:false		
	}
	
	def list() {		
		[ request:request, listConfig:this.variableListConfig]
	}

	def jsonlist() {			
		//def pi=activitiRuntimeService.createProcessInstanceQuery().processInstanceId(params.objectId).singleResult()
		
		def dl=activitiRuntimeService.getVariables(params.objectId)
		def totalRecords=dl.size()
		// convert to list
		def datalist=dl.collect { [id:"${params.objectId}-${it.key}",name:it.key,value:it.value]}
		
		switch(params.iSortCol_0) {
			case '0':
				//datalist=datalist.orderByProcessInstanceId()
			break
						
			case '1':
				datalist=datalist.sort { it.name}
			break
			
		}
				
		switch (params.sSortDir_0) {
			case 'asc':
				//datalist=datalist
			break
			case 'desc':
				datalist=datalist.reverse()
			break
		}
		
		Integer firstResult=params.iDisplayStart?new Integer(params.iDisplayStart):0
		Integer maxResults=params.iDisplayLength?new Integer(params.iDisplayLength):10
		
		// pagination
		if (firstResult>totalRecords) { firstResult=totalRecords }
		if ((firstResult+maxResults)>totalRecords) {maxResults=totalRecords-firstResult} 
		datalist=datalist[firstResult..maxResults-1]
		
		
		render ProcessVariableCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}
	/*
	def variableListConfig=new ListConfig(name:'activitiProcessVariable',controller: 'activitiProcessVariable').configure {
		column name:'id',sortable:true
		column name:'name',sortable:true
		column name:'value',sortable:true
	}
	*/
	def dialog() {
		def (id,name)=params.id.split('-')		
		def value=activitiRuntimeService.getVariable(id, name)
		def processVariable=new ProcessVariableCommand(id:id,name:name,value:value,variableClassName:value?.class?.name)		
		[processVariable:processVariable]
	}
	
	def submitdialog = { ProcessVariableCommand processVariable ->

		def successFlag=true
		
		switch (processVariable.variableClassName) {
			
			case 'java.lang.Boolean':
				Boolean val=params.variableValue=="true"
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,val)
			break
			
			case 'java.lang.Byte':			
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Byte))
			break
			case 'java.lang.Character':			
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Character))
			break
			case 'java.lang.Date':			
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Date))
			break
			case 'java.lang.Double':
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Double))
			break
			case 'java.lang.Float':
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Float))
			break
			case 'java.lang.String':			
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value)
			break
			case 'java.lang.Integer':
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Integer))
			break
			case 'java.lang.Long':
				activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value.asType(java.lang.Long))
			break
			}
		
		
		
		def value=activitiRuntimeService.setVariable(processVariable.id, processVariable.name,processVariable.value)
		def resultMessage="${processVariable.name} set to ${processVariable.value}"
		
		def result = [
			success:successFlag,
			message:resultMessage,
			id: processVariable.id
		]
		res=[result:result]
		render res as JSON
	}
	

}
