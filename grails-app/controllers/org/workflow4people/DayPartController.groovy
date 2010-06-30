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
 * Conroller for DayPart
 * See domain class for more details
 *
 * @author Joost Horward
 */

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])

class DayPartController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [dayPartInstanceList: DayPart.list(params), dayPartInstanceTotal: DayPart.count()]
    }

    def create = {
        def dayPartInstance = new DayPart()
        dayPartInstance.properties = params
        return [dayPartInstance: dayPartInstance]
    }

    def save = {
        def dayPartInstance = new DayPart(params)
        if (!dayPartInstance.hasErrors() && dayPartInstance.save()) {
            flash.message = "dayPart.created"
            flash.args = [dayPartInstance.id]
            flash.defaultMessage = "DayPart ${dayPartInstance.id} created"
            redirect(action: "show", id: dayPartInstance.id)
        }
        else {
            render(view: "create", model: [dayPartInstance: dayPartInstance])
        }
    }

    def show = {
        def dayPartInstance = DayPart.get(params.id)
        if (!dayPartInstance) {
            flash.message = "dayPart.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DayPart not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [dayPartInstance: dayPartInstance]
        }
    }

    def edit = {
        def dayPartInstance = DayPart.get(params.id)
        if (!dayPartInstance) {
            flash.message = "dayPart.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DayPart not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [dayPartInstance: dayPartInstance]
        }
    }

    def update = {
        def dayPartInstance = DayPart.get(params.id)
        if (dayPartInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (dayPartInstance.version > version) {
                    
                    dayPartInstance.errors.rejectValue("version", "dayPart.optimistic.locking.failure", "Another user has updated this DayPart while you were editing")
                    render(view: "edit", model: [dayPartInstance: dayPartInstance])
                    return
                }
            }
            dayPartInstance.properties = params
            if (!dayPartInstance.hasErrors() && dayPartInstance.save()) {
                flash.message = "dayPart.updated"
                flash.args = [params.id]
                flash.defaultMessage = "DayPart ${params.id} updated"
                redirect(action: "show", id: dayPartInstance.id)
            }
            else {
                render(view: "edit", model: [dayPartInstance: dayPartInstance])
            }
        }
        else {
            flash.message = "dayPart.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DayPart not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def dayPartInstance = DayPart.get(params.id)
        if (dayPartInstance) {
            try {
                dayPartInstance.delete()
                flash.message = "dayPart.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DayPart ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "dayPart.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "DayPart ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "dayPart.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "DayPart not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
