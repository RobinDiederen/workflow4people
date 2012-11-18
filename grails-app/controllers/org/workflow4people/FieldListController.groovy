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

import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.apache.commons.lang.StringUtils

/**
 * Controller for Field List domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class FieldListController {
    
	def listService
	def dialogService
	
    def index = { redirect(action:list,params:params) }

	// the submitdialog and delete actions only accept POST requests
    static allowedMethods = [submitdialog: "POST", delete: "POST"]


//    def list = {
//        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
//        [ fieldListInstanceList: FieldList.list( params ), fieldListInstanceTotal: FieldList.count() ]
//    }

	def list = {
		render (view:'/dialog/list', model:[dc:FieldList,controllerName:'fieldList',request:request])
	}
	
	def jsonlist = {
		render listService.jsonlist(FieldList,params,request) as JSON
	}
	
	def dialog = { return dialogService.edit(FieldList,params) }
	
	def submitdialog = { render dialogService.submit(FieldList,params) as JSON }
	
	def delete = { render dialogService.delete(FieldList,params) as JSON }
	
	
	
	
	
	
    def show = {
        def fieldListInstance = FieldList.get( params.id )

        if(!fieldListInstance) {
            flash.message = "FieldList not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldListInstance : fieldListInstance,navTemplate:"/fieldList/nav",buttonsTemplate:"/fieldList/buttons" ] }
    }

    def tree = {
        def fieldListInstance = FieldList.get( params.id )

        if(!fieldListInstance) {
            flash.message = "FieldList not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ fieldListInstance : fieldListInstance ] }
    }


    def xdelete = {
        def fieldListInstance = FieldList.get( params.id )
        if(fieldListInstance) {
            try {
                fieldListInstance.delete(flush:true)
                flash.message = "FieldList ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "FieldList ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "FieldList not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def fieldListInstance = FieldList.get( params.id )

        if(!fieldListInstance) {
            flash.message = "FieldList not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ fieldListInstance : fieldListInstance ]
        }
    }

    def update = {
        def fieldListInstance = FieldList.get( params.id )
        if(fieldListInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(fieldListInstance.version > version) {
                    
                    fieldListInstance.errors.rejectValue("version", "fieldList.optimistic.locking.failure", "Another user has updated this FieldList while you were editing.")
                    render(view:'edit',model:[fieldListInstance:fieldListInstance])
                    return
                }
            }
            fieldListInstance.properties = params
            if(!fieldListInstance.hasErrors() && fieldListInstance.save()) {
                flash.message = "FieldList ${params.id} updated"
                redirect(action:show,id:fieldListInstance.id)
            }
            else {
                render(view:'edit',model:[fieldListInstance:fieldListInstance])
            }
        }
        else {
            flash.message = "FieldList not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def fieldListInstance = new FieldList()
        fieldListInstance.properties = params
        return ['fieldListInstance':fieldListInstance]
    }

    def save = {
        def fieldListInstance = new FieldList(params)
        if(!fieldListInstance.hasErrors() && fieldListInstance.save()) {
            flash.message = "FieldList ${fieldListInstance.id} created"
            redirect(action:show,id:fieldListInstance.id)
        }
        else {
            render(view:'create',model:[fieldListInstance:fieldListInstance])
        }
    }
	
	/*
	 * Clones a domain object and recursively clones children, clearing ids and
	 * attaching children to their new parents. Ownership relationships (indicated
	 * by GORM belongsTo keyword) cause "copy as new" (a recursive deep clone),
	 * but associations without ownership are shallow copied by reference.
	 */
	def deepClone(domainInstanceToClone){
		
		//Our target instance for the instance we want to clone
		def newDomainInstance = domainInstanceToClone.getClass().newInstance()  
		
		//Returns a DefaultGrailsDomainClass (as interface GrailsDomainClass) for inspecting properties
		def domainClass = ApplicationHolder.application.getDomainClass(newDomainInstance.getClass().name)
		
		domainClass?.persistentProperties.each{prop ->           
			if(prop.association){
				if(prop.owningSide){
					//we have to deep clone owned associations
					if(prop.oneToOne){
						def newAssociationInstance = deepClone(domainInstanceToClone."${prop.name}")
						newDomainInstance."${prop.name}" = newAssociationInstance
					}
					else{
						domainInstanceToClone."${prop.name}".each{ associationInstance ->
							def newAssociationInstance = deepClone(associationInstance)
							newDomainInstance."addTo${StringUtils.capitalize(prop.name)}"(newAssociationInstance)
						}
					}
				}
				else{                   
					if(!prop.bidirectional){
						//If the association isn't owned or the owner, then we can just do a  shallow copy of the reference.
						newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
					}
				}
			}
			else{               
				//If the property isn't an association then simply copy the value
				newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
			}
		}
		
		return newDomainInstance
	}
    def copy = {
            def fieldListInstance = FieldList.get( params.id )

            if(!fieldListInstance) {
                flash.message = "FieldList not found with id ${params.id}"
                redirect(action:list)
            }
            else {
				def clone=deepClone(fieldListInstance)
				clone.save()                
				render(view:'edit',model:[fieldListInstance:clone])
            }
        }
	
	
	
	
}
