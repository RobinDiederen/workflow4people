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
 * Controller for Form domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_USER_ADMIN'])
class PersonController {

    static allowedMethods = [save: "POST", update: "POST"]
                             
    def authenticateService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [personInstanceList: Person.list(params), personInstanceTotal: Person.count(), searchTemplate: "/person/search"]
    }

    def search = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def q = (params.q ? params.q : "")
        def model = [personInstanceList: Person.findAllByUsernameLike(q + "%", params), personInstanceTotal: Person.countByUsernameLike(q + "%"), searchTemplate: "/person/search", q: q]
        render(view: "list", model: model)
    }

    def create = {
        def personInstance = new Person()
        personInstance.properties = params
        return [personInstance: personInstance]
    }

    def save = {
        def personInstance = new Person(params)
        personInstance.passwd = authenticateService.encodePassword(params.passwd)
        if (personInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])}"
            redirect(action: "show", id: personInstance.id)
        }
        else {
            personInstance.passwd = ""
            render(view: "create", model: [personInstance: personInstance])
        }
    }

    def show = {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
        else {
            [personInstance: personInstance]
        }
    }

    def edit = {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [personInstance: personInstance]
        }
    }

    def update = {
       def personInstance = Person.get(params.id)
        if (personInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (personInstance.version > version) {
                    
                    personInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'person.label', default: 'Person')] as Object[], "Another user has updated this Person while you were editing")
                    render(view: "edit", model: [personInstance: personInstance])
                    return
                }
            }
			
            def oldPassword = personInstance.passwd
			Authority[] currentPersonAuth = personInstance.getAuthorities()
            personInstance.properties = params
            if (!params.passwd.equals(oldPassword)) {
    			personInstance.passwd = authenticateService.encodePassword(params.passwd)
    			def test=authenticateService.encodePassword(params.passwd)    			
    		}
            if (!personInstance.hasErrors() && personInstance.save(flush: true)) {
				currentPersonAuth.each { Authority currentAuthority -> 
					def deletePersonAuthority = true
					personInstance.getAuthorities().each { Authority newAuthority ->
						if (currentAuthority.getId() == newAuthority.getId()) {
							deletePersonAuthority = false;
						}
					}
					if (deletePersonAuthority) {
						currentAuthority.removeFromPeople(personInstance)
					}
				}
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])}"
                redirect(action: "show", id: personInstance.id)
            }
            else {
                render(view: "edit", model: [personInstance: personInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def personInstance = Person.get(params.id)
        if (personInstance) {
            try {
                personInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
    }
}
