/*
 * Workflow4people
 * Copyright 2009-2013, Open-T B.V., and individual contributors as indicated
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
import grails.plugin.jms.*
import org.open_t.dialog.*

/**
 * Workflow domain class
 * 
 * @author Joost Horward
 */
class Workflow {
	def jmsService
	
	static transients = ["noMessage"]
	static hasMany = [workflowLog:WorkflowLog]

	static listConfig=new ListConfig(name:'workflow',controller: 'workflow',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'workflowDefinition',sortable:true,filter:true
		column name:'dateCreated',sortable:true,filter:true
		column name:'dueDate',sortable:true,filter:true
		column name:'completionDate',sortable:true,filter:true
	}

    static constraints = {
		externalId(nullable:true)
		name(nullable:true)
		workflowEngine(nullable:true)
		workflowDefinition(nullable:true)
		dateCreated(nullable:true)
		dueDate(nullable:true)
		completionDate(nullable:true)
		lastUpdated(nullable:true)
		status(nullable:true)
	}
	
	WorkflowEngine workflowEngine
	WorkflowDefinition workflowDefinition
	String name
	Document document
	
	int priority
	
	Date dateCreated
	Date lastUpdated
	Date dueDate
	Date completionDate
	
	String externalId
	
	String status
	
	boolean noMessage=false
	                   	
   	String toString() {
   		return "Workflow ${workflowDefinition.name} ${id}";
   	}
	   
	def log(def message,def person=null) {
		def logInstance=new WorkflowLog()
		logInstance.message=message
		logInstance.workflow=this
		if(person) {
			logInstance.person=person
		}
		logInstance.save()
	}   
	
}
