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
import grails.converters.*

import grails.plugins.springsecurity.Secured


/**
 * Controller for Document
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class DocumentController {
	def listService
	def dialogService

    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]

    def oldlist = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [documentInstanceList: Document.list(params), documentInstanceTotal: Document.count()]
    }
    def list = {
    	
    	render (view:'/datatable/list', model:[dc:Document,controllerName:'document',request:request])
    }
    
    def jsonlist = {
    	render listService.jsonlist(Document,params,request) as JSON	
    }

	def dialog = { return dialogService.edit(Document,params) }
	
	def submitdialog = { render dialogService.submit(Document,params) as JSON }
	
	def delete = { render dialogService.delete(Document,params) as JSON }
	
    def create = {
        def documentInstance = new Document()
        documentInstance.properties = params
        return [documentInstance: documentInstance]
    }

    def save = {
        def documentInstance = new Document(params)
        if (!documentInstance.hasErrors() && documentInstance.save()) {
            flash.message = "document.created"
            flash.args = [documentInstance.id]
            flash.defaultMessage = "Document ${documentInstance.id} created"
            redirect(action: "show", id: documentInstance.id)
        }
        else {
            render(view: "create", model: [documentInstance: documentInstance])
        }
    }

    def show = {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = "document.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Document not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentInstance: documentInstance]
        }
    }

    def edit = {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = "document.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Document not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentInstance: documentInstance]
        }
    }

    def update = {
        def documentInstance = Document.get(params.id)
        if (documentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentInstance.version > version) {
                    
                    documentInstance.errors.rejectValue("version", "document.optimistic.locking.failure", "Another user has updated this Document while you were editing")
                    render(view: "edit", model: [documentInstance: documentInstance])
                    return
                }
            }
            documentInstance.properties = params
            if (!documentInstance.hasErrors() && documentInstance.save()) {
                flash.message = "document.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Document ${params.id} updated"
                redirect(action: "show", id: documentInstance.id)
            }
            else {
                render(view: "edit", model: [documentInstance: documentInstance])
            }
        }
        else {
            flash.message = "document.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Document not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def xdelete = {
    	log.debug "deleting ..."
        def documentInstance = Document.get(params.id)
        if (documentInstance) {
            try {
                documentInstance.delete()
                flash.message = "document.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Document ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "document.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Document ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "document.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Document not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
