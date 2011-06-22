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
/**
 * Controller for FormPermission domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FormPermissionController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [formPermissionInstanceList: FormPermission.list(params), formPermissionInstanceTotal: FormPermission.count()]
    }

    def create = {
        def formPermissionInstance = new FormPermission()
        formPermissionInstance.properties = params
        return [formPermissionInstance: formPermissionInstance]
    }

    def save = {
        def formPermissionInstance = new FormPermission(params)
        if (!formPermissionInstance.hasErrors() && formPermissionInstance.save()) {
            flash.message = "formPermission.created"
            flash.args = [formPermissionInstance.id]
            flash.defaultMessage = "FormPermission ${formPermissionInstance.id} created"
            redirect(action: "show", id: formPermissionInstance.id)
        }
        else {
            render(view: "create", model: [formPermissionInstance: formPermissionInstance])
        }
    }

    def show = {
        def formPermissionInstance = FormPermission.get(params.id)
        if (!formPermissionInstance) {
            flash.message = "formPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormPermission not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [formPermissionInstance: formPermissionInstance]
        }
    }

    def edit = {
        def formPermissionInstance = FormPermission.get(params.id)
        if (!formPermissionInstance) {
            flash.message = "formPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormPermission not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [formPermissionInstance: formPermissionInstance]
        }
    }

    def update = {
        def formPermissionInstance = FormPermission.get(params.id)
        if (formPermissionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (formPermissionInstance.version > version) {
                    
                    formPermissionInstance.errors.rejectValue("version", "formPermission.optimistic.locking.failure", "Another user has updated this FormPermission while you were editing")
                    render(view: "edit", model: [formPermissionInstance: formPermissionInstance])
                    return
                }
            }
            formPermissionInstance.properties = params
            if (!formPermissionInstance.hasErrors() && formPermissionInstance.save()) {
                flash.message = "formPermission.updated"
                flash.args = [params.id]
                flash.defaultMessage = "FormPermission ${params.id} updated"
                redirect(action: "show", id: formPermissionInstance.id)
            }
            else {
                render(view: "edit", model: [formPermissionInstance: formPermissionInstance])
            }
        }
        else {
            flash.message = "formPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormPermission not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def formPermissionInstance = FormPermission.get(params.id)
        if (formPermissionInstance) {
            try {
                formPermissionInstance.delete()
                flash.message = "formPermission.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "FormPermission ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "formPermission.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "FormPermission ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "formPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FormPermission not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
