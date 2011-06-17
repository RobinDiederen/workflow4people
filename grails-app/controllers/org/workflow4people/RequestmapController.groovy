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
import grails.plugins.springsecurity.Secured


import org.springframework.util.StringUtils

/**
 * Requestmap controller 
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class RequestmapController {

	def authenticateService

	// the delete, save and update actions only accept POST requests
	static Map allowedMethods = [ save: 'POST', update: 'POST']

	def index = {
		redirect action: list, params: params
	}

	def list = {
		if (!params.max) {
			params.max = 10
		}
		[requestmapList: Requestmap.list(params)]
	}

	def show = {
		def requestmap = Requestmap.get(params.id)
		if (!requestmap) {
			flash.message = "Requestmap not found with id $params.id"
			redirect action:list
			return
		}
		[requestmap: requestmap]
	}

	def delete = {
		def requestmap = Requestmap.get(params.id)
		if (!requestmap) {
			flash.message = "Requestmap not found with id $params.id"
			redirect action:list
			return
		}

		requestmap.delete()

		authenticateService.clearCachedRequestmaps()

		flash.message = "Requestmap $params.id deleted."
		redirect(action: list)
	}

	def edit = {
		def requestmap = Requestmap.get(params.id)
		if (!requestmap) {
			flash.message = "Requestmap not found with id $params.id"
			redirect(action: list)
			return
		}

		[requestmap: requestmap]
	}

	/**
	 * Update action, called when an existing Requestmap is updated.
	 */
	def update = {

		def requestmap = Requestmap.get(params.id)
		if (!requestmap) {
			flash.message = "Requestmap not found with id $params.id"
			redirect(action: edit, id :params.id)
			return
		}

		long version = params.version.toLong()
		if (requestmap.version > version) {
			requestmap.errors.rejectValue 'version', "requestmap.optimistic.locking.failure",
				"Another user has updated this Requestmap while you were editing."
			render view: 'edit', model: [requestmap: requestmap]
			return
		}

		requestmap.properties = params
		if (requestmap.save()) {
			authenticateService.clearCachedRequestmaps()
			redirect action: show, id: requestmap.id
		}
		else {
			render view: 'edit', model: [requestmap: requestmap]
		}
	}

	def create = {
		[requestmap: new Requestmap(params)]
	}

	/**
	 * Save action, called when a new Requestmap is created.
	 */
	def save = {
		def requestmap = new Requestmap(params)
		if (requestmap.save()) {
			authenticateService.clearCachedRequestmaps()
			redirect action: show, id: requestmap.id
		}
		else {
			render view: 'create', model: [requestmap: requestmap]
		}
	}
}
