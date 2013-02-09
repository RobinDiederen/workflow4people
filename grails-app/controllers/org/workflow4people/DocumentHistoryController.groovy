package org.workflow4people
import grails.plugins.springsecurity.Secured
import grails.converters.JSON

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN'])
class DocumentHistoryController {

    
	def listService
	def dialogService
	
	//***
	def index() {
		redirect(action: "list")
	}
	
	def list() {
		render (view:'/dialog/list', model:[dc:DocumentHistory,controllerName:'documentHistory',request:request])
	}

	def jsonlist() {
		render listService.jsonlist(DocumentHistory, params, request) as JSON
	}
	
	def dialog() { 
		return dialogService.edit(DocumentHistory, params) 		
	}
	
	def submitdialog() {
		def res =dialogService.submit(DocumentHistory, params)
		render res as JSON
	}
	
	def delete() { render dialogService.delete(DocumentHistory, params) as JSON }
}
