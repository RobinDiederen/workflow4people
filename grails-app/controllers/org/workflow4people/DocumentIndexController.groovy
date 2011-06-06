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
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import grails.converters.*


/**
 * Controller for DocumentIndex 
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN'])
class DocumentIndexController {
	def listService
	def dialogService


    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
                             
    def list = {    	
    	render (view:'/datatable/list', model:[dc:DocumentIndex,controllerName:'documentIndex',request:request])
    }
    
    def jsonlist = {
    	render listService.jsonlist(DocumentIndex,params,request) as JSON	
    }

	def dialog = { return dialogService.edit(DocumentIndex,params) }
	
	def submitdialog = { render dialogService.submit(DocumentIndex,params) as JSON }
	
	def delete = { render dialogService.delete(DocumentIndex,params) as JSON }

    def create = {
        def documentIndexInstance = new DocumentIndex()
        documentIndexInstance.properties = params
        return [documentIndexInstance: documentIndexInstance]
    }

    def save = {
        def documentIndexInstance = new DocumentIndex(params)
        if (!documentIndexInstance.hasErrors() && documentIndexInstance.save()) {
            flash.message = "documentIndex.created"
            flash.args = [documentIndexInstance.id]
            flash.defaultMessage = "DocumentIndex ${documentIndexInstance.id} created"
            redirect(action: "show", id: documentIndexInstance.id)
        }
        else {
            render(view: "create", model: [documentIndexInstance: documentIndexInstance])
        }
    }

    def show = {
        def documentIndexInstance = DocumentIndex.get(params.id)
        if (!documentIndexInstance) {
            flash.message = "documentIndex.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndex not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentIndexInstance: documentIndexInstance]
        }
    }

    def edit = {
        def documentIndexInstance = DocumentIndex.get(params.id)
        if (!documentIndexInstance) {
            flash.message = "documentIndex.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndex not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentIndexInstance: documentIndexInstance]
        }
    }

    def update = {
        def documentIndexInstance = DocumentIndex.get(params.id)
        if (documentIndexInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentIndexInstance.version > version) {
                    
                    documentIndexInstance.errors.rejectValue("version", "documentIndex.optimistic.locking.failure", "Another user has updated this DocumentIndex while you were editing")
                    render(view: "edit", model: [documentIndexInstance: documentIndexInstance])
                    return
                }
            }
            documentIndexInstance.properties = params
            if (!documentIndexInstance.hasErrors() && documentIndexInstance.save()) {
                flash.message = "documentIndex.updated"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentIndex ${params.id} updated"
                redirect(action: "show", id: documentIndexInstance.id)
            }
            else {
                render(view: "edit", model: [documentIndexInstance: documentIndexInstance])
            }
        }
        else {
            flash.message = "documentIndex.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndex not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def xdelete = {
        def documentIndexInstance = DocumentIndex.get(params.id)
        if (documentIndexInstance) {
            try {
            	def documentInstanceId=documentIndexInstance.document.id
                documentIndexInstance.delete()
                flash.message = "documentIndex.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentIndex ${params.id} deleted"
                redirect(action: "show",controller:"document",id:documentInstanceId)
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "documentIndex.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentIndex ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "documentIndex.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndex not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
