/*
 * Workflow4people
 * Copyright 2009, Open-T B.V., and individual contributors as indicated
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

import java.io.Serializable;
import groovy.lang.Binding;


/**
 * Form domain class. 
 * Represents a workflow form.
 * @author Joost Horward
 */
class Form implements Serializable {
	def templateService
    static constraints = {
    	name()
    	title()
    	description(size:0..50000)
    	explanationMessage(size:0..50000)
    	confirmationMessage(size:0..50000)
    	template()    
    	formAction()
    	//formItem(widget:"insert")
    	workflow(display:false)
    	formItem(widget:'insert',display:false,sortable:true,sort:'position',sortOrder:'asc',create:true,show:true,edit:true,delete:true)
    }
	static belongsTo = [workflow: WorkflowDefinition]
    static hasMany = [formItem : FormItem]                  
    
    String name
    String title
    String description
    String explanationMessage
    String confirmationMessage
    String template
    Action formAction
    
    def getFieldList() {
    	return workflow.documentType.fieldList
    }
	
    String toString() {
		  return name;
	}
    
	Binding binding() {	
		groovy.lang.Binding binding = new Binding()
		binding.form=this		
		binding.output=""
		return binding
	}
	
	def runSnippet(String snippetName,def model=[:]) {
		model+=binding().getVariables()
		return templateService.runGenericSnippetTemplate("Form",snippetName,model)
	}
	
	
    
}
