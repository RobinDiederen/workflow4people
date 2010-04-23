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

/**
 * WorkflowDefinition domain class. 
 * Represents a workflow definition form.
 * The process flow itself is in jBPM, WorkflowDefinition is only the data and forms
 * @author Joost Horward
 */

class WorkflowDefinition {
	static hasMany = [form : Form,workflowPermission:WorkflowPermission]	
	
    static constraints = {
		publish()
    	name()
    	title()
        description(size:0..50000)	
        version()
        dateCreated(nullable:true)
        lastUpdated(nullable:true)
        fieldList()
    }
    
    
    String name
    String title
    String description
    
    
    FieldList fieldList
    
    int version
    Date dateCreated
    Date lastUpdated
    
    boolean publish

	String toString() {
		  return name;
	  }
}
