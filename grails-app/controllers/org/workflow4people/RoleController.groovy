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
 * Controller for Role domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class RoleController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [roleInstanceList: Role.list(params), roleInstanceTotal: Role.count()]
    }

    def create = {
        def roleInstance = new Role()
        roleInstance.properties = params
        return [roleInstance: roleInstance]
    }

    def save = {
        def roleInstance = new Role(params)
        if (!roleInstance.hasErrors() && roleInstance.save()) {
            flash.message = "role.created"
            flash.args = [roleInstance.id]
            flash.defaultMessage = "Role ${roleInstance.id} created"
            redirect(action: "show", id: roleInstance.id)
        }
        else {
            render(view: "create", model: [roleInstance: roleInstance])
        }
    }

    def show = {
        def roleInstance = Role.get(params.id)
        if (!roleInstance) {
            flash.message = "role.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Role not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [roleInstance: roleInstance]
        }
    }

    def edit = {
        def roleInstance = Role.get(params.id)
        if (!roleInstance) {
            flash.message = "role.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Role not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [roleInstance: roleInstance]
        }
    }

    def update = {
        def roleInstance = Role.get(params.id)
        if (roleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (roleInstance.version > version) {
                    
                    roleInstance.errors.rejectValue("version", "role.optimistic.locking.failure", "Another user has updated this Role while you were editing")
                    render(view: "edit", model: [roleInstance: roleInstance])
                    return
                }
            }
            roleInstance.properties = params
            if (!roleInstance.hasErrors() && roleInstance.save()) {
                flash.message = "role.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Role ${params.id} updated"
                redirect(action: "show", id: roleInstance.id)
            }
            else {
                render(view: "edit", model: [roleInstance: roleInstance])
            }
        }
        else {
            flash.message = "role.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Role not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def roleInstance = Role.get(params.id)
        if (roleInstance) {
            try {
                roleInstance.delete()
                flash.message = "role.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Role ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "role.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Role ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "role.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Role not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
