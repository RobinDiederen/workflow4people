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
 * AuthorityController
 * See domain class form more details
 *
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class AuthorityController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [authorityInstanceList: Authority.list(params), authorityInstanceTotal: Authority.count()]
    }

    def create = {
        def authorityInstance = new Authority()
        authorityInstance.properties = params
        return [authorityInstance: authorityInstance]
    }

    def save = {
        def authorityInstance = new Authority(params)
        if (authorityInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'authority.label', default: 'Authority'), authorityInstance.id])}"
            redirect(action: "show", id: authorityInstance.id)
        }
        else {
            render(view: "create", model: [authorityInstance: authorityInstance])
        }
    }

    def show = {
        def authorityInstance = Authority.get(params.id)
        if (!authorityInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'authority.label', default: 'Authority'), params.id])}"
            redirect(action: "list")
        }
        else {
            [authorityInstance: authorityInstance]
        }
    }

    def edit = {
        def authorityInstance = Authority.get(params.id)
        if (!authorityInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'authority.label', default: 'Authority'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [authorityInstance: authorityInstance]
        }
    }

    def update = {
        def authorityInstance = Authority.get(params.id)
        if (authorityInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (authorityInstance.version > version) {
                    
                    authorityInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'authority.label', default: 'Authority')] as Object[], "Another user has updated this Authority while you were editing")
                    render(view: "edit", model: [authorityInstance: authorityInstance])
                    return
                }
            }
            authorityInstance.properties = params
            if (!authorityInstance.hasErrors() && authorityInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'authority.label', default: 'Authority'), authorityInstance.id])}"
                redirect(action: "show", id: authorityInstance.id)
            }
            else {
                render(view: "edit", model: [authorityInstance: authorityInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'authority.label', default: 'Authority'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def authorityInstance = Authority.get(params.id)
        if (authorityInstance) {
            try {
                authorityInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'authority.label', default: 'Authority'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'authority.label', default: 'Authority'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'authority.label', default: 'Authority'), params.id])}"
            redirect(action: "list")
        }
    }
}
