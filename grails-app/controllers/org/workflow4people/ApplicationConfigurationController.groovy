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

/** Application configuration controller
 * 
 * See domain class for more details
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN'])
class ApplicationConfigurationController {
	
	def listService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    //def list = {
    //    params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
    //    [applicationConfigurationInstanceList: ApplicationConfiguration.list(params), applicationConfigurationInstanceTotal: ApplicationConfiguration.count()]
    //}
	
	def list = {
		render (view:'/datatable/list', model:[dc:ApplicationConfiguration,controllerName:'applicationConfiguration',request:request])
	}
		
	def jsonlist = {
		render listService.jsonlist(ApplicationConfiguration,params,request) as JSON
	}

    def create = {
        def applicationConfigurationInstance = new ApplicationConfiguration()
        applicationConfigurationInstance.properties = params
        return [applicationConfigurationInstance: applicationConfigurationInstance]
    }

    def save = {
        def applicationConfigurationInstance = new ApplicationConfiguration(params)
        if (!applicationConfigurationInstance.hasErrors() && applicationConfigurationInstance.save()) {
            flash.message = "applicationConfiguration.created"
            flash.args = [applicationConfigurationInstance.id]
            flash.defaultMessage = "ApplicationConfiguration ${applicationConfigurationInstance.id} created"
            redirect(action: "show", id: applicationConfigurationInstance.id)
        }
        else {
            render(view: "create", model: [applicationConfigurationInstance: applicationConfigurationInstance])
        }
    }

    def show = {
        def applicationConfigurationInstance = ApplicationConfiguration.get(params.id)
        if (!applicationConfigurationInstance) {
            flash.message = "applicationConfiguration.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "ApplicationConfiguration not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [applicationConfigurationInstance: applicationConfigurationInstance]
        }
    }

    def edit = {
        def applicationConfigurationInstance = ApplicationConfiguration.get(params.id)
        if (!applicationConfigurationInstance) {
            flash.message = "applicationConfiguration.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "ApplicationConfiguration not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [applicationConfigurationInstance: applicationConfigurationInstance]
        }
    }

    def update = {
        def applicationConfigurationInstance = ApplicationConfiguration.get(params.id)
        if (applicationConfigurationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (applicationConfigurationInstance.version > version) {
                    
                    applicationConfigurationInstance.errors.rejectValue("version", "applicationConfiguration.optimistic.locking.failure", "Another user has updated this ApplicationConfiguration while you were editing")
                    render(view: "edit", model: [applicationConfigurationInstance: applicationConfigurationInstance])
                    return
                }
            }
            applicationConfigurationInstance.properties = params
            if (!applicationConfigurationInstance.hasErrors() && applicationConfigurationInstance.save()) {
                flash.message = "applicationConfiguration.updated"
                flash.args = [params.id]
                flash.defaultMessage = "ApplicationConfiguration ${params.id} updated"
                redirect(action: "show", id: applicationConfigurationInstance.id)
            }
            else {
                render(view: "edit", model: [applicationConfigurationInstance: applicationConfigurationInstance])
            }
        }
        else {
            flash.message = "applicationConfiguration.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "ApplicationConfiguration not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def applicationConfigurationInstance = ApplicationConfiguration.get(params.id)
        if (applicationConfigurationInstance) {
            try {
                applicationConfigurationInstance.delete()
                flash.message = "applicationConfiguration.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "ApplicationConfiguration ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "applicationConfiguration.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "ApplicationConfiguration ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "applicationConfiguration.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "ApplicationConfiguration not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
