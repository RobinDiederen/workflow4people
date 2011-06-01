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
 * Controller for BasType
 * See domain class for more details
 *
 * @author Joost Horward
 */

@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class BaseTypeController {
	
	def listService

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

//    def list = {
//        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
//        [baseTypeInstanceList: BaseType.list(params), baseTypeInstanceTotal: BaseType.count()]
//    }
	
	def list = {
		render (view:'/datatable/list', model:[dc:BaseType,controllerName:'baseType',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(BaseType,params,request) as JSON
	}

    def create = {
        def baseTypeInstance = new BaseType()
        baseTypeInstance.properties = params
        return [baseTypeInstance: baseTypeInstance]
    }

    def save = {
        def baseTypeInstance = new BaseType(params)
        if (!baseTypeInstance.hasErrors() && baseTypeInstance.save()) {
            flash.message = "baseType.created"
            flash.args = [baseTypeInstance.id]
            flash.defaultMessage = "BaseType ${baseTypeInstance.id} created"
            redirect(action: "show", id: baseTypeInstance.id)
        }
        else {
            render(view: "create", model: [baseTypeInstance: baseTypeInstance])
        }
    }

    def show = {
        def baseTypeInstance = BaseType.get(params.id)
        if (!baseTypeInstance) {
            flash.message = "baseType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BaseType not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [baseTypeInstance: baseTypeInstance]
        }
    }

    def edit = {
        def baseTypeInstance = BaseType.get(params.id)
        if (!baseTypeInstance) {
            flash.message = "baseType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BaseType not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [baseTypeInstance: baseTypeInstance]
        }
    }

    def update = {
        def baseTypeInstance = BaseType.get(params.id)
        if (baseTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (baseTypeInstance.version > version) {
                    
                    baseTypeInstance.errors.rejectValue("version", "baseType.optimistic.locking.failure", "Another user has updated this BaseType while you were editing")
                    render(view: "edit", model: [baseTypeInstance: baseTypeInstance])
                    return
                }
            }
            baseTypeInstance.properties = params
            if (!baseTypeInstance.hasErrors() && baseTypeInstance.save()) {
                flash.message = "baseType.updated"
                flash.args = [params.id]
                flash.defaultMessage = "BaseType ${params.id} updated"
                redirect(action: "show", id: baseTypeInstance.id)
            }
            else {
                render(view: "edit", model: [baseTypeInstance: baseTypeInstance])
            }
        }
        else {
            flash.message = "baseType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BaseType not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def baseTypeInstance = BaseType.get(params.id)
        if (baseTypeInstance) {
            try {
                baseTypeInstance.delete()
                flash.message = "baseType.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "BaseType ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "baseType.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "BaseType ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "baseType.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "BaseType not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
