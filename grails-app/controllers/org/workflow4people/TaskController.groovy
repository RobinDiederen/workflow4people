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
			render (view:'/dialog/list', model:[dc:Task,controllerName:'task',request:request,jsonlist:'jsonlist'])
		}
			
		def jsonlist = {
			//render listService.jsonlist(Task,params,request) as JSON
			def actions= {  doc,env -> """<div class="btn-group"><span class="btn btn-small" onclick="dialog.formDialog(${doc.id},'task', { refresh : '${env.detailTableId}'}, null)">edit</span>&nbsp;<span class="btn btn-small" onclick="dialog.formDialog(${doc.id},'task',{ refresh : '${env.detailTableId}', dialogname : 'assigndialog', submitname : 'submitassigndialog' }, null)">assign</span>&nbsp;<span class="btn btn-small" onclick="dialog.deleteDialog(${doc.id},'task',{ refresh : '${env.detailTableId}'})">&times;</span></div>""" }
			render listService.jsonlist(Task,params,request,null,actions) as JSON
		}

	    def dialog = { return dialogService.edit(Task,params) }
		
		def submitdialog = { render dialogService.submit(Task,params) as JSON }
		
		def assigndialog = { return dialogService.edit(Task,params) }
		
		def submitassigndialog = { 
			def res
			def taskInstance
			
			if (params.id!=null && params.id!="null" ) {
				taskInstance = Task.get(params.id)
			} else {
				taskInstance = new Task()
				taskInstance.properties = params
			}

			if (taskInstance) {
				Authority[] currentCandidateGroups = taskInstance.getCandidateGroups()
				Person[] currentCandidateUsers = taskInstance.getCandidateUsers()
				taskInstance.properties = params
		
				res= dialogService.submit(Task,params,taskInstance)

				if (res.result.success == true) {
					//Delete CandidateGroups 
					currentCandidateGroups.each { Authority curCandidateGroup ->
						def deleteCandidateGroup = true
						Authority[] newCandidateGroups = params.candidateGroups ? taskInstance.getCandidateGroups() : []
						newCandidateGroups.each { Authority newCandidateGroup ->
							if (curCandidateGroup.getId() == newCandidateGroup.getId()) {
								deleteCandidateGroup = false
							}
						}
						if (deleteCandidateGroup) {
							taskInstance.removeFromCandidateGroups(curCandidateGroup)
						}
					}
					//Delete CandidateUsers
					currentCandidateUsers.each { Person curCandidateUser ->
						def deleteCandidateUser = true
						Person[] newCandidateUsers = params.candidateUsers ? taskInstance.getCandidateUsers() : []
						newCandidateUsers.each { Person newCandidateUser ->
							if (curCandidateUser.getId() == newCandidateUser.getId()) {
								deleteCandidateUser = false
							}
						}
						if (deleteCandidateUser) {
							taskInstance.removeFromCandidateUsers(curCandidateUser)
						}
					}
				}
			}
			render res as JSON
		}
		
		def delete = { render dialogService.delete(Task,params) as JSON }
		
	}