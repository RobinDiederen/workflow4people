package org.workflow4people
import grails.converters.JSON;

import grails.plugins.springsecurity.Secured


	/**
	 * Controller for Task domain class
	 * 
	 * @author Joost Horward
	 */
	@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
	class TaskController {

		def listService
		def dialogService
		
	    def index = { redirect(action: "list", params: params) }

		// the submitdialog and delete actions only accept POST requests
	    static allowedMethods = [submitdialog: "POST", delete: "POST"]

		def list = {
			render (view:'/datatable/list', model:[dc:Task,controllerName:'task',request:request])
		}
			
		def jsonlist = {
			render listService.jsonlist(Task,params,request) as JSON
		}

	    def dialog = { return dialogService.edit(Task,params) }
		
		def submitdialog = { render dialogService.submit(Task,params) as JSON }
		
		def delete = { render dialogService.delete(Task,params) as JSON }
		
	}