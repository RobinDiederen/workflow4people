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
import grails.converters.JSON;

import org.codehaus.groovy.grails.plugins.springsecurity.Secured
/**
 * Controller for Holiday domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER','ROLE_WF4P_PROCESS_ADMIN'])
class HolidayController {

	def listService
	
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

//    def list = {
//        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
//        [holidayInstanceList: Holiday.list(params), holidayInstanceTotal: Holiday.count()]
//    }

	def list = {
		render (view:'/datatable/list', model:[dc:Holiday,controllerName:'holiday',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(Holiday,params,request) as JSON
	}
	
    def create = {
        def holidayInstance = new Holiday()
        holidayInstance.properties = params
        return [holidayInstance: holidayInstance]
    }

    def save = {
        def holidayInstance = new Holiday(params)
        if (!holidayInstance.hasErrors() && holidayInstance.save()) {
            flash.message = "holiday.created"
            flash.args = [holidayInstance.id]
            flash.defaultMessage = "Holiday ${holidayInstance.id} created"
            redirect(action: "show", id: holidayInstance.id)
        }
        else {
            render(view: "create", model: [holidayInstance: holidayInstance])
        }
    }

    def show = {
        def holidayInstance = Holiday.get(params.id)
        if (!holidayInstance) {
            flash.message = "holiday.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Holiday not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [holidayInstance: holidayInstance]
        }
    }

    def edit = {
        def holidayInstance = Holiday.get(params.id)
        if (!holidayInstance) {
            flash.message = "holiday.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Holiday not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [holidayInstance: holidayInstance]
        }
    }

    def update = {
        def holidayInstance = Holiday.get(params.id)
        if (holidayInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (holidayInstance.version > version) {
                    
                    holidayInstance.errors.rejectValue("version", "holiday.optimistic.locking.failure", "Another user has updated this Holiday while you were editing")
                    render(view: "edit", model: [holidayInstance: holidayInstance])
                    return
                }
            }
            holidayInstance.properties = params
            if (!holidayInstance.hasErrors() && holidayInstance.save()) {
                flash.message = "holiday.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Holiday ${params.id} updated"
                redirect(action: "show", id: holidayInstance.id)
            }
            else {
                render(view: "edit", model: [holidayInstance: holidayInstance])
            }
        }
        else {
            flash.message = "holiday.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Holiday not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def holidayInstance = Holiday.get(params.id)
        if (holidayInstance) {
            try {
                holidayInstance.delete()
                flash.message = "holiday.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Holiday ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "holiday.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Holiday ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "holiday.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Holiday not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
