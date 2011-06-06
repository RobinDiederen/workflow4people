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
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
/**
 * Controller for Feature domain class
 * 
 * @author Joost Horward
 */
class FeatureController {

	def listService
	def dialogService
	
    def index = { redirect(action: "list", params: params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]
  
	
	def list = {
		render (view:'/datatable/list', model:[dc:Feature,controllerName:'feature',request:request])
	}
		
	def jsonlist = {
		render listService.jsonlist(Feature,params,request) as JSON
	}

    def create = {
        def featureInstance = new Feature()
        featureInstance.properties = params
        return [featureInstance: featureInstance]
    }
	
	def dialog = { return dialogService.edit(Feature,params) }
	
	def submitdialog = { render dialogService.submit(Feature,params) as JSON }
	
	def delete = { render dialogService.delete(Feature,params) as JSON }

    def save = {
        def featureInstance = new Feature(params)
        if (!featureInstance.hasErrors() && featureInstance.save()) {
            flash.message = "feature.created"
            flash.args = [featureInstance.id]
            flash.defaultMessage = "Feature ${featureInstance.id} created"
            redirect(action: "show", id: featureInstance.id)
        }
        else {
            render(view: "create", model: [featureInstance: featureInstance])
        }
    }

    def show = {
        def featureInstance = Feature.get(params.id)
        if (!featureInstance) {
            flash.message = "feature.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Feature not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [featureInstance: featureInstance]
        }
    }

    def edit = {
        def featureInstance = Feature.get(params.id)
        if (!featureInstance) {
            flash.message = "feature.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Feature not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [featureInstance: featureInstance]
        }
    }

    def update = {
        def featureInstance = Feature.get(params.id)
        if (featureInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (featureInstance.version > version) {
                    
                    featureInstance.errors.rejectValue("version", "feature.optimistic.locking.failure", "Another user has updated this Feature while you were editing")
                    render(view: "edit", model: [featureInstance: featureInstance])
                    return
                }
            }
            featureInstance.properties = params
            if (!featureInstance.hasErrors() && featureInstance.save()) {
                flash.message = "feature.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Feature ${params.id} updated"
                redirect(action: "show", id: featureInstance.id)
            }
            else {
                render(view: "edit", model: [featureInstance: featureInstance])
            }
        }
        else {
            flash.message = "feature.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Feature not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def xdelete = {
        def featureInstance = Feature.get(params.id)
        if (featureInstance) {
            try {
                featureInstance.delete()
                flash.message = "feature.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Feature ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "feature.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Feature ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "feature.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Feature not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
