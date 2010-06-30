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
 * Controller for Action domain
 * See domain class for more details
 * 
 * @author joost
 *
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class ActionController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [actionInstanceList: Action.list(params), actionInstanceTotal: Action.count()]
    }

    def create = {
        def actionInstance = new Action()
        actionInstance.properties = params
        return [actionInstance: actionInstance]
    }

    def save = {
        def actionInstance = new Action(params)
        if (!actionInstance.hasErrors() && actionInstance.save()) {
            flash.message = "action.created"
            flash.args = [actionInstance.id]
            flash.defaultMessage = "Action ${actionInstance.id} created"
            redirect(action: "show", id: actionInstance.id)
        }
        else {
            render(view: "create", model: [actionInstance: actionInstance])
        }
    }

    def show = {
        def actionInstance = Action.get(params.id)
        if (!actionInstance) {
            flash.message = "action.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Action not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [actionInstance: actionInstance]
        }
    }

    def edit = {
        def actionInstance = Action.get(params.id)
        if (!actionInstance) {
            flash.message = "action.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Action not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [actionInstance: actionInstance]
        }
    }

    def update = {
        def actionInstance = Action.get(params.id)
        if (actionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (actionInstance.version > version) {
                    
                    actionInstance.errors.rejectValue("version", "action.optimistic.locking.failure", "Another user has updated this Action while you were editing")
                    render(view: "edit", model: [actionInstance: actionInstance])
                    return
                }
            }
            actionInstance.properties = params
            if (!actionInstance.hasErrors() && actionInstance.save()) {
                flash.message = "action.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Action ${params.id} updated"
                redirect(action: "show", id: actionInstance.id)
            }
            else {
                render(view: "edit", model: [actionInstance: actionInstance])
            }
        }
        else {
            flash.message = "action.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Action not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def actionInstance = Action.get(params.id)
        if (actionInstance) {
            try {
                actionInstance.delete()
                flash.message = "action.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Action ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "action.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Action ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "action.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Action not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
