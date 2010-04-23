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
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
/**
 * Controller for MinerQuery domain class
 * 
 * @author Joost Horward
 */
class MinerQueryController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [minerQueryInstanceList: MinerQuery.list(params), minerQueryInstanceTotal: MinerQuery.count()]
    }

    def create = {
        def minerQueryInstance = new MinerQuery()
        minerQueryInstance.properties = params
        return [minerQueryInstance: minerQueryInstance]
    }

    def save = {
        def minerQueryInstance = new MinerQuery(params)
        if (!minerQueryInstance.hasErrors() && minerQueryInstance.save()) {
            flash.message = "minerQuery.created"
            flash.args = [minerQueryInstance.id]
            flash.defaultMessage = "MinerQuery ${minerQueryInstance.id} created"
            redirect(action: "show", id: minerQueryInstance.id)
        }
        else {
            render(view: "create", model: [minerQueryInstance: minerQueryInstance])
        }
    }

    def show = {
        def minerQueryInstance = MinerQuery.get(params.id)
        if (!minerQueryInstance) {
            flash.message = "minerQuery.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MinerQuery not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [minerQueryInstance: minerQueryInstance]
        }
    }

    def edit = {
        def minerQueryInstance = MinerQuery.get(params.id)
        if (!minerQueryInstance) {
            flash.message = "minerQuery.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MinerQuery not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [minerQueryInstance: minerQueryInstance]
        }
    }

    def update = {
        def minerQueryInstance = MinerQuery.get(params.id)
        if (minerQueryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (minerQueryInstance.version > version) {
                    
                    minerQueryInstance.errors.rejectValue("version", "minerQuery.optimistic.locking.failure", "Another user has updated this MinerQuery while you were editing")
                    render(view: "edit", model: [minerQueryInstance: minerQueryInstance])
                    return
                }
            }
            minerQueryInstance.properties = params
            if (!minerQueryInstance.hasErrors() && minerQueryInstance.save()) {
                flash.message = "minerQuery.updated"
                flash.args = [params.id]
                flash.defaultMessage = "MinerQuery ${params.id} updated"
                redirect(action: "show", id: minerQueryInstance.id)
            }
            else {
                render(view: "edit", model: [minerQueryInstance: minerQueryInstance])
            }
        }
        else {
            flash.message = "minerQuery.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MinerQuery not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def minerQueryInstance = MinerQuery.get(params.id)
        if (minerQueryInstance) {
            try {
                minerQueryInstance.delete()
                flash.message = "minerQuery.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "MinerQuery ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "minerQuery.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "MinerQuery ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "minerQuery.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MinerQuery not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
