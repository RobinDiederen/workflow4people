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
 * Controller for WorkflowPermission domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN','ROLE_WF4P_DEVELOPER'])

class WorkflowPermissionController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [workflowPermissionInstanceList: WorkflowPermission.list(params), workflowPermissionInstanceTotal: WorkflowPermission.count()]
    }

    def create = {
        def workflowPermissionInstance = new WorkflowPermission()
        workflowPermissionInstance.properties = params
        return [workflowPermissionInstance: workflowPermissionInstance]
    }

    def save = {
        def workflowPermissionInstance = new WorkflowPermission(params)
        if (!workflowPermissionInstance.hasErrors() && workflowPermissionInstance.save()) {
            flash.message = "workflowPermission.created"
            flash.args = [workflowPermissionInstance.id]
            flash.defaultMessage = "WorkflowPermission ${workflowPermissionInstance.id} created"
            redirect(action: "show", id: workflowPermissionInstance.id)
        }
        else {
            render(view: "create", model: [workflowPermissionInstance: workflowPermissionInstance])
        }
    }

    def show = {
        def workflowPermissionInstance = WorkflowPermission.get(params.id)
        if (!workflowPermissionInstance) {
            flash.message = "workflowPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "WorkflowPermission not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [workflowPermissionInstance: workflowPermissionInstance]
        }
    }

    def edit = {
        def workflowPermissionInstance = WorkflowPermission.get(params.id)
        if (!workflowPermissionInstance) {
            flash.message = "workflowPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "WorkflowPermission not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [workflowPermissionInstance: workflowPermissionInstance]
        }
    }

    def update = {
        def workflowPermissionInstance = WorkflowPermission.get(params.id)
        if (workflowPermissionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (workflowPermissionInstance.version > version) {
                    
                    workflowPermissionInstance.errors.rejectValue("version", "workflowPermission.optimistic.locking.failure", "Another user has updated this WorkflowPermission while you were editing")
                    render(view: "edit", model: [workflowPermissionInstance: workflowPermissionInstance])
                    return
                }
            }
            workflowPermissionInstance.properties = params
            if (!workflowPermissionInstance.hasErrors() && workflowPermissionInstance.save()) {
                flash.message = "workflowPermission.updated"
                flash.args = [params.id]
                flash.defaultMessage = "WorkflowPermission ${params.id} updated"
                redirect(action: "show", id: workflowPermissionInstance.id)
            }
            else {
                render(view: "edit", model: [workflowPermissionInstance: workflowPermissionInstance])
            }
        }
        else {
            flash.message = "workflowPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "WorkflowPermission not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def workflowPermissionInstance = WorkflowPermission.get(params.id)
        if (workflowPermissionInstance) {
            try {
                workflowPermissionInstance.delete()
                flash.message = "workflowPermission.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "WorkflowPermission ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "workflowPermission.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "WorkflowPermission ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "workflowPermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "WorkflowPermission not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
