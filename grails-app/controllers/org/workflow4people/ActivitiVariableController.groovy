package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*
import org.open_t.dialog.command.Command

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.workflow4people.activiti.command.*

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class ActivitiVariableController {

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
	
	def listConfig=new ListConfig(name:'activitiProcessVariable',controller: 'activitiProcessVariable').configure {
		column name:'name',sortable:true		
		column name:'value',sortable:false		
	}
	
	def list() {		
		[ request:request, listConfig:this.variableListConfig]
	}

	def jsonlist() {
		def dl=[:]
		def (parentType,id)=params.objectId.split("_")
		switch (parentType) {
			case "Task":
				dl=activitiTaskService.getVariables(id)
			break
			case "Process":
				dl=activitiRuntimeService.getVariables(id)
			break			
		}			
		
		
		// convert to list
		def datalist=dl.collect { 
				def variableCommand = new VariableCommand(parentType:parentType,parentId:id,name:it.key)
				variableCommand.getFrom(it)
				return variableCommand
			}
		render VariableCommand.listConfig.paginateList(datalist,params) as JSON
		/*
		def totalRecords=dl.size()
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
		
		
		render VariableCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
			*/	
	}
		
	def dialog() { 
		def (parentType,id,name)=params.id.split('_')
		def value
		if (parentType=="Task") {
			value=activitiTaskService.getVariable(id,name)
		} else {
			value=activitiRuntimeService.getVariable(id, name)
		}
		def variableCommand=new VariableCommand(parentType:parentType,parentId:id,name:name,value:value,variableClassName:value?.class?.name)		
		[variableCommand:variableCommand]
	}
	
	def submitdialog = { VariableCommand variableCommand ->
		variableCommand.id=params.id
		def successFlag=true
		def resultMessage
		
		def val
		
		try {
		
		switch (variableCommand.variableClassName) {
			
			case 'java.lang.Boolean':
				val=variableCommand.value=="true"
			break
			
			case 'java.lang.Byte':			
				val=variableCommand.value.asType(java.lang.Byte)
			break
			case 'java.lang.Character':			
				val=variableComamnd.value.asType(java.lang.Character)
			break
			case 'java.lang.Date':			
				val=variableCommand.value.asType(java.lang.Date)
			break
			case 'java.lang.Double':
				val=variableCommand.value.asType(java.lang.Double)
			break
			case 'java.lang.Float':
				val=variableCommand.value.asType(java.lang.Float)
			break
			case 'java.lang.String':			
				val=variableCommand.value
			break
			case 'java.lang.Integer':
				val=variableCommand.value.asType(java.lang.Integer)
			break
			case 'java.lang.Long':
				val=variableCommand.value.asType(java.lang.Long)
			break
			}
		
		if (variableCommand.parentType=="Task") {
			activitiTaskService.setVariable(variableCommand.parentId, variableCommand.name,val)
		} else {
			activitiRuntimeService.setVariable(variableCommand.parentId, variableCommand.name,val)
		}
			resultMessage="${variableCommand.name} set to ${variableCommand.value}"
		
		} catch (Exception e) {
			resultMessage=e.message
			successFlag=false
		}
		
		def result = [
			success:successFlag,
			message:resultMessage,
			id: variableCommand.id
		]
		def res=[result:result]
		render res as JSON
	}
}
