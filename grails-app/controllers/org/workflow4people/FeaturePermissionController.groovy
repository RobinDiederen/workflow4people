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
import grails.converters.JSON;


@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])

/**
 * Controller for Feature Permission domain class
 * 
 * @author Joost Horward
 */
class FeaturePermissionController {
	def listService
	def dialogService

    def index = { redirect(action: "list", params: params) }

 // the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
                             
    def list = {
		render (view:'/datatable/list', model:[dc:FeaturePermission,controllerName:'featurePermission',request:request])
	}
		
	def jsonlist = {
		render listService.jsonlist(FeaturePermission,params,request) as JSON
	}

                             
    //def list = {
    //    params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
    //    [featurePermissionInstanceList: FeaturePermission.list(params), featurePermissionInstanceTotal: FeaturePermission.count()]
    //}
    
    
    
	def dialog = { return dialogService.edit(FeaturePermission,params) }
	
	def submitdialog = { render dialogService.submit(FeaturePermission,params) as JSON }
	
	def delete = { render dialogService.delete(FeaturePermission,params) as JSON }

    def create = {
        def featurePermissionInstance = new FeaturePermission()
        featurePermissionInstance.properties = params
        return [featurePermissionInstance: featurePermissionInstance]
    }

    def save = {
        def featurePermissionInstance = new FeaturePermission(params)
        if (!featurePermissionInstance.hasErrors() && featurePermissionInstance.save()) {
            flash.message = "featurePermission.created"
            flash.args = [featurePermissionInstance.id]
            flash.defaultMessage = "FeaturePermission ${featurePermissionInstance.id} created"
            redirect(action: "show", id: featurePermissionInstance.id)
        }
        else {
            render(view: "create", model: [featurePermissionInstance: featurePermissionInstance])
        }
    }

    def show = {
        def featurePermissionInstance = FeaturePermission.get(params.id)
        if (!featurePermissionInstance) {
            flash.message = "featurePermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FeaturePermission not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [featurePermissionInstance: featurePermissionInstance]
        }
    }

    def edit = {
        def featurePermissionInstance = FeaturePermission.get(params.id)
        if (!featurePermissionInstance) {
            flash.message = "featurePermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FeaturePermission not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [featurePermissionInstance: featurePermissionInstance]
        }
    }

    def update = {
        def featurePermissionInstance = FeaturePermission.get(params.id)
        if (featurePermissionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (featurePermissionInstance.version > version) {
                    
                    featurePermissionInstance.errors.rejectValue("version", "featurePermission.optimistic.locking.failure", "Another user has updated this FeaturePermission while you were editing")
                    render(view: "edit", model: [featurePermissionInstance: featurePermissionInstance])
                    return
                }
            }
            featurePermissionInstance.properties = params
            if (!featurePermissionInstance.hasErrors() && featurePermissionInstance.save()) {
                flash.message = "featurePermission.updated"
                flash.args = [params.id]
                flash.defaultMessage = "FeaturePermission ${params.id} updated"
                redirect(action: "show", id: featurePermissionInstance.id)
            }
            else {
                render(view: "edit", model: [featurePermissionInstance: featurePermissionInstance])
            }
        }
        else {
            flash.message = "featurePermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FeaturePermission not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def xdelete = {
        def featurePermissionInstance = FeaturePermission.get(params.id)
        if (featurePermissionInstance) {
            try {
                featurePermissionInstance.delete()
                flash.message = "featurePermission.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "FeaturePermission ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "featurePermission.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "FeaturePermission ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "featurePermission.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "FeaturePermission not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
