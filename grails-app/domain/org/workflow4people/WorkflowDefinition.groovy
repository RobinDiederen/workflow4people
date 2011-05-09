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

class WorkflowDefinition implements Serializable {
	static listProperties=['id','publish','name','title','description','version','dateCreated','lastUpdated']
	                     	                       
	static hasMany = [form : Form,workflowPermission:WorkflowPermission]	
	
    static constraints = {
		publish(help:'x')
    	name(help:'x',class:'wide')
    	title(help:'x',class:'wide')
        description(size:0..50000,help:'x')	
        version(help:'x')
        dateCreated(nullable:true,edit:false,help:'x')
        lastUpdated(nullable:true,edit:false,help:'x')
        documentType(help:'x')
    	form(display:false,sortable:false,sort:'name',sortOrder:'asc',create:true,show:true,edit:true,delete:true)
    	workflowPermission(display:false,sortable:false,sort:'authority',sortOrder:'asc',create:true,show:true,edit:true,delete:true)
    	processDefinitionDate(edit:false,nullable:true,help:'x')
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
    
    int version
    Date dateCreated
    Date lastUpdated
    Date processDefinitionDate
    boolean publish

	String toString() {
		  return name;
	  }
	
	def getFieldList() {
		return documentType.fieldList
	}
	
}
