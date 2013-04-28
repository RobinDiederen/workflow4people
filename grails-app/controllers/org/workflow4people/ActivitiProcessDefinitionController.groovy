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
	
	
	def list() {				
		render (view:'/dialog/list',model:[ request:request, listConfig:ProcessDefinitionCommand.listConfig])
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
		
		def totalRecords=activitiRepositoryService.createProcessDefinitionQuery().active().latestVersion().count()
		render ProcessDefinitionCommand.listConfig.renderList(datalist,totalRecords,params) as JSON
				
	}
	
	def dialog() {
		def pd=activitiRepositoryService.getProcessDefinition(params.id)
		[processDefinitionCommand:new ProcessDefinitionCommand().getAllFrom(pd)]
	}
	
	def diagram() {
		def pd=activitiRepositoryService.getProcessDefinition(params.id)
		def contentStream=activitiRepositoryService.getResourceAsStream(pd.deploymentId,pd.diagramResourceName)

		response.setHeader("Content-disposition", "attachment; filename=\"" +pd.diagramResourceName+"\"")
		response.setHeader("Content-Type", "image/png")

		def inputStream=contentStream
		def bufsize=100000
		byte[] bytes=new byte[(int)bufsize]

		def offset=0
		def len=1
		while (len>0) {
			len=inputStream.read(bytes, 0, bufsize)
			if (len>0)
			response.outputStream.write(bytes,0,len)
			offset+=bufsize
		}
		response.outputStream.flush()
	}
	
	def submitdialog = { ProcessDefinitionCommand processDefinition ->
		def result = [
			success:true,
			message:"",
			id: processDefinition.id
		]
		res=[result:result]
		render res as JSON
	}
	
	
	def upload() {
		def res=fileService.uploadFile(request,params)
		
		def processDefinitionText=new File(res.path).text

		def id = activitiRepositoryService.createDeployment().name("upload").addString("process.bpmn20.xml", processDefinitionText).deploy().getId();
		
		render res as JSON
	}
	
	def delete = {		
		def success
		def message
		try {
			def pd=activitiRepositoryService.getProcessDefinition(params.id)			
			activitiRepositoryService.deleteDeployment(pd.deploymentId)
			success=true
			message="Process definition ${params.id} deleted"
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
