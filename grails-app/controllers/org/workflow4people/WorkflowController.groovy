package org.workflow4people
import grails.converters.JSON;

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

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
			render (view:'/datatable/list', model:[dc:Workflow,controllerName:'workflow',request:request])
		}
			
		def jsonlist = {
			render listService.jsonlist(Workflow,params,request) as JSON
		}
		
		def listwithtasks = {
			render (view:'/datatable/list', model:[dc:Workflow,controllerName:'workflow',request:request,jsonlist:'jsonlistwithtasks'])
		}
			
		def jsonlistwithtasks = {
			//def actions = { doc -> "lalala ${doc.id}"}
			def baseUrl=request.contextPath
			def actions= {  doc -> """<span class="list-action-button ui-state-default" onclick="formDialog(${doc.id},'workflow','')">dialog</span>&nbsp;<span class="list-action-button ui-state-default" onclick="deleteDialog(${doc.id},'workflow','')">delete</span>&nbsp;<a class="list-action-button ui-state-default" href="${baseUrl}/workflow/show/${doc.id}">show</a>&nbsp;<a class="list-action-button ui-state-default" href="${baseUrl}/workflow/edit/${doc.id}">edit</a>&nbsp;<a class="list-action-button ui-state-default confirm" href="${baseUrl}/workflow/delete/${doc.id}" title="Delete this item" >&times;</a>""" }
			render listService.jsonlist(Workflow,params,request,null,actions) as JSON
		}
		
		

	    def dialog = { return dialogService.edit(Workflow,params) }
		
		def submitdialog = { render dialogService.submit(Workflow,params) as JSON }
		
		def delete = { render dialogService.delete(Workflow,params) as JSON }
		
	}