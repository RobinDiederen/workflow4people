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
	
	def list() {				
		render (view:'/dialog/list',model:[ request:request, listConfig:ProcessInstanceCommand.listConfig])
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
			new ProcessInstanceCommand().getAllFrom(it)
		} 
			
		def totalRecords=activitiRuntimeService.createProcessInstanceQuery().active().count()
		render ProcessInstanceCommand.listConfig.renderList(dl,totalRecords,params) as JSON
				
	}
	
	def dialog() {
		def id=params.id.split("_")[1]
		def pi=activitiRuntimeService.createProcessInstanceQuery().processInstanceId(id).singleResult()
		[processInstanceCommand:new ProcessInstanceCommand().getAllFrom(pi)]
	}
	
	def submitdialog = { ProcessInstanceCommand processInstanceCommand ->
		def result = [
			success:true,
			message:"",
			id: processDefinitionCommand.id,
		]
		res=[result:result]
		render res as JSON
	}
	
	def delete = {
		def id=params.id.split("_")[1]
		def success
		def message
		try {
			activitiRuntimeService.deleteProcessInstance(id, null)
			success=true
			message="Process instance ${id} deleted"
		} catch (Exception e) {
			success=false
			message=e.message
		}
		def result = [
			success:success,
			message:message,
			id: params.id
		]
		def res=[result:result]
		render res as JSON
	}

}
