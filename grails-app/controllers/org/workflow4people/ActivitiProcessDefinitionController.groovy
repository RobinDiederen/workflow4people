package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*

import grails.converters.*
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])

class ActivitiProcessDefinitionController {
	
	ProcessEngine activitiProcessEngine
	RepositoryService activitiRepositoryService
	ManagementService activitiManagementService
	RuntimeService activitiRuntimeService
	IdentityService activitiIdentityService
	HistoryService activitiHistoryService
	FormService activitiFormService

    def index = { 	
		redirect (action:list)
	}
	
	def listConfig=new ListConfig(name:'activitiProcessDefinition',controller: 'activitiProcessDefinition').configure {
		column name:'id',sortable:true		
		column name:'key',sortable:true
		column name:'version',sortable:true
		column name:'name',sortable:true
		column name:'description'
	}
	
	def list() {		
		[ request:request, listConfig:this.listConfig]
	}

	def jsonlist() {				
		def datalist=activitiRepositoryService.createProcessDefinitionQuery().active()
		
		switch(params.iSortCol_0) {
			case '0':
				datalist=datalist.orderByProcessDefinitionId()
			break
						
			case '1':
				datalist=datalist.orderByProcessDefinitionKey()
			break
			
			case '2':
				datalist=datalist.orderByProcessDefinitionVersion()
			break
		
			case '3':
				datalist=datalist.orderByProcessDefinitionName()
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
		
		def totalRecords=activitiRepositoryService.createProcessDefinitionQuery().active().count()
		render listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}
	
	
	
	def testdeploy(){ 
		def processDefinitionText=new File('/home/joost/workspaces/grails-workspace/wfp/process-definitions/StoringMelding.bpmn').text
		println processDefinitionText
		def id = activitiRepositoryService.createDeployment().name("test").addString("process.bpmn20.xml", processDefinitionText).deploy().getId();
		def json=[id:id]
		render json as JSON
	}

}
