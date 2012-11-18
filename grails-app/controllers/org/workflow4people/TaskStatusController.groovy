package org.workflow4people
import grails.converters.JSON;

import grails.plugins.springsecurity.Secured


	/**
	 * Controller for TaskStatus domain class
	 * 
	 * @author Joost Horward
	 */
	@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
	class TaskStatusController {

		def listService
		def dialogService
		
	    def index = { redirect(action: "list", params: params) }

		// the submitdialog and delete actions only accept POST requests
	    static allowedMethods = [submitdialog: "POST", delete: "POST"]

		def list = {
			render (view:'/dialog/list', model:[dc:TaskStatus,controllerName:'taskStatus',request:request,jsonlist:'jsonlist'])
		}
			
		def jsonlist = {
			render listService.jsonlist(TaskStatus,params,request) as JSON			
		}

	    def dialog = { return dialogService.edit(TaskStatus,params) }
		
		def submitdialog = { render dialogService.submit(TaskStatus,params) as JSON }
		
		def delete = { render dialogService.delete(TaskStatus,params) as JSON }
		
	}