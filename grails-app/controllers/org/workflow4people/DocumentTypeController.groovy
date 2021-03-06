/*

 * Workflow4people
 * Copyright 2009-2010, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */
package org.workflow4people
import grails.plugins.springsecurity.Secured
import grails.converters.*

/**
 * Controller for DocumentType
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])

class DocumentTypeController {
	
	def listService
	def dialogService

    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

    def list = {    	
    	render (view:'/dialog/list', model:[dc:DocumentType,controllerName:'documentType',request:request])
    }
    
    def jsonlist = {
		def actions= {  doc,env -> """<div class="btn-group">
										<span class="btn btn-small" onclick="dialog.formDialog(${doc.id},'documentType', { refresh : '${env.detailTableId}'}, null)">edit</span>
										<a class="btn btn-small" href="${createLink(controller:'dataModelEditor',action:'documentType',id:doc.id)}">model &raquo;</a>
										<span class="btn btn-small" onclick="dialog.deleteDialog(${doc.id},'documentType',{ refresh : '${env.detailTableId}'})">&times;</span>
									</div>""" 
		}
    	render listService.jsonlist(DocumentType,params,request,null,actions) as JSON	
    }

	def dialog = { return dialogService.edit(DocumentType,params) }
	
	def submitdialog = { 
		def res = dialogService.submit(DocumentType,params)
		
		//Remove of all documentIndexField from documenttype
		if (res.result.success && params.documentIndexField == null) {
			def instance = DocumentType.get(res.result.id)
			instance.documentIndexField = []
			instance.save()
		}

		render res as JSON
	}
	
	def delete = { render dialogService.delete(DocumentType,params) as JSON }
	
}
