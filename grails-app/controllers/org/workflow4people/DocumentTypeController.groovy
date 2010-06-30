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

/**
 * Controller for DocumentType
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])

class DocumentTypeController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [documentTypeInstanceList: DocumentType.list(params), documentTypeInstanceTotal: DocumentType.count()]
    }

    def create = {
        def documentTypeInstance = new DocumentType()
        documentTypeInstance.properties = params
        return [documentTypeInstance: documentTypeInstance]
    }

    def save = {
        def documentTypeInstance = new DocumentType(params)
        if (!documentTypeInstance.hasErrors() && documentTypeInstance.save()) {
            flash.message = "documentType.created"
            flash.args = [documentTypeInstance.id]
            flash.defaultMessage = "DocumentType ${documentTypeInstance.id} created"
            redirect(action: "show", id: documentTypeInstance.id)
        }
        else {
            render(view: "create", model: [documentTypeInstance: documentTypeInstance])
        }
    }

    def show = {
        def documentTypeInstance = DocumentType.get(params.id)
        if (!documentTypeInstance) {
            flash.message = "documentType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentType not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentTypeInstance: documentTypeInstance]
        }
    }

    def edit = {
        def documentTypeInstance = DocumentType.get(params.id)
        if (!documentTypeInstance) {
            flash.message = "documentType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentType not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentTypeInstance: documentTypeInstance]
        }
    }

    def update = {
        def documentTypeInstance = DocumentType.get(params.id)
        if (documentTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentTypeInstance.version > version) {
                    
                    documentTypeInstance.errors.rejectValue("version", "documentType.optimistic.locking.failure", "Another user has updated this DocumentType while you were editing")
                    render(view: "edit", model: [documentTypeInstance: documentTypeInstance])
                    return
                }
            }
            documentTypeInstance.properties = params
            if (!documentTypeInstance.hasErrors() && documentTypeInstance.save()) {
                flash.message = "documentType.updated"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentType ${params.id} updated"
                redirect(action: "show", id: documentTypeInstance.id)
            }
            else {
                render(view: "edit", model: [documentTypeInstance: documentTypeInstance])
            }
        }
        else {
            flash.message = "documentType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentType not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def documentTypeInstance = DocumentType.get(params.id)
        if (documentTypeInstance) {
            try {
                documentTypeInstance.delete()
                flash.message = "documentType.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentType ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "documentType.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentType ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "documentType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentType not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
