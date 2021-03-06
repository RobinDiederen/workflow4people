package org.workflow4people
import org.activiti.spring.*
import org.activiti.engine.*
import org.open_t.dialog.command.Command

import grails.converters.*
import grails.plugins.springsecurity.Secured
import org.workflow4people.activiti.command.*

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])

class ActivitiProcessDefinitionController {
	
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
		def datalist=activitiRepositoryService.createProcessDefinitionQuery().active().latestVersion()
		
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
	
	
	def testdeploy(){ 
		def processDefinitionText=new File('/home/joost/workspaces/grails-workspace/wfp/process-definitions/StoringMelding.bpmn').text
		println processDefinitionText
		def id = activitiRepositoryService.createDeployment().name("test").addString("process.bpmn20.xml", processDefinitionText).deploy().getId();
		def json=[id:id]
		render json as JSON
	}
	def upload() {
		def res=fileService.uploadFile(request,params)
		println "UPLOAD ${res}"
		
		def processDefinitionText=new File(res.path).text

		def id = activitiRepositoryService.createDeployment().name("upload").addString("process.bpmn20.xml", processDefinitionText).deploy().getId();
		
		
		render res as JSON
	}

}
