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
 * Controller for DocumentIndexField
 * See domain class for more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class DocumentIndexFieldController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [documentIndexFieldInstanceList: DocumentIndexField.list(params), documentIndexFieldInstanceTotal: DocumentIndexField.count()]
    }

    def create = {
        def documentIndexFieldInstance = new DocumentIndexField()
        documentIndexFieldInstance.properties = params
        return [documentIndexFieldInstance: documentIndexFieldInstance]
    }

    def save = {
        def documentIndexFieldInstance = new DocumentIndexField(params)
        if (!documentIndexFieldInstance.hasErrors() && documentIndexFieldInstance.save()) {
            flash.message = "documentIndexField.created"
            flash.args = [documentIndexFieldInstance.id]
            flash.defaultMessage = "DocumentIndexField ${documentIndexFieldInstance.id} created"
            redirect(action: "show", id: documentIndexFieldInstance.id)
        }
        else {
            render(view: "create", model: [documentIndexFieldInstance: documentIndexFieldInstance])
        }
    }

    def show = {
        def documentIndexFieldInstance = DocumentIndexField.get(params.id)
        if (!documentIndexFieldInstance) {
            flash.message = "documentIndexField.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndexField not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentIndexFieldInstance: documentIndexFieldInstance]
        }
    }

    def edit = {
        def documentIndexFieldInstance = DocumentIndexField.get(params.id)
        if (!documentIndexFieldInstance) {
            flash.message = "documentIndexField.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndexField not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [documentIndexFieldInstance: documentIndexFieldInstance]
        }
    }

    def update = {
        def documentIndexFieldInstance = DocumentIndexField.get(params.id)
        if (documentIndexFieldInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentIndexFieldInstance.version > version) {
                    
                    documentIndexFieldInstance.errors.rejectValue("version", "documentIndexField.optimistic.locking.failure", "Another user has updated this DocumentIndexField while you were editing")
                    render(view: "edit", model: [documentIndexFieldInstance: documentIndexFieldInstance])
                    return
                }
            }
            documentIndexFieldInstance.properties = params
            if (!documentIndexFieldInstance.hasErrors() && documentIndexFieldInstance.save()) {
                flash.message = "documentIndexField.updated"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentIndexField ${params.id} updated"
                redirect(action: "show", id: documentIndexFieldInstance.id)
            }
            else {
                render(view: "edit", model: [documentIndexFieldInstance: documentIndexFieldInstance])
            }
        }
        else {
            flash.message = "documentIndexField.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndexField not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def documentIndexFieldInstance = DocumentIndexField.get(params.id)
        if (documentIndexFieldInstance) {
            try {
                documentIndexFieldInstance.delete()
                flash.message = "documentIndexField.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentIndexField ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "documentIndexField.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DocumentIndexField ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "documentIndexField.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DocumentIndexField not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
