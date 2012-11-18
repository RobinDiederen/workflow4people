package org.workflow4people
import grails.converters.JSON;
import grails.plugins.springsecurity.Secured

	/**
	 * Controller for WorkflowEngine domain class
	 * 
	 * @author Joost Horward
	 */
	@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
	class WorkflowController {

		def listService
		def dialogService
		
	    def index = { redirect(action: "list", params: params) }

		// the submitdialog and delete actions only accept POST requests
	    static allowedMethods = [submitdialog: "POST", delete: "POST"]

		def list = {
			render (view:'/dialog/list', model:[dc:Workflow,controllerName:'workflow',request:request])
		}
			
		def jsonlist = {
			render listService.jsonlist(Workflow,params,request) as JSON
		}
		
		def dialog = { return dialogService.edit(Workflow,params) }
		
		def submitdialog = { render dialogService.submit(Workflow,params) as JSON }
		
		def delete = { render dialogService.delete(Workflow,params) as JSON }
		
	}