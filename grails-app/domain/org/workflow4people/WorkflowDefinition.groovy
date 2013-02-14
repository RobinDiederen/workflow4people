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

/**
 * WorkflowDefinition domain class.
 * Represents a workflow definition
 * The process flow itself is defined in a workflow engine, WorkflowDefinition only represents the data and forms
 * 
 * @author Joost Horward
 */
class WorkflowDefinition implements Serializable {
	static listProperties=['id','publish','name','title','description','version','dateCreated','lastUpdated']

	static hasMany = [form : Form,workflowPermission:WorkflowPermission]	

    static constraints = {
    	name(unique:true)    	
        description(size:0..50000)	

        dateCreated(nullable:true)
        lastUpdated(nullable:true)

    	processDefinitionDate(nullable:true)
    }

	/* For some reason, setting:
	 * static fetchMode = [form: 'eager',documentType:'eager']
	 * only works for form, and the mapping below works for both form and documentType
	 * The eager loading is here because otherwise the GetWorkflowDefinitions webservice fails.
	 */
	static mapping ={     
		form lazy: false
		documentType lazy: false
	}
	
    String name
    String title
    String description

    DocumentType documentType
    WorkflowEngine workflowEngine

    int version
    Date dateCreated
    Date lastUpdated
    Date processDefinitionDate
    boolean publish
	boolean run=true

	String toString() {
		return name;
	}	
}
