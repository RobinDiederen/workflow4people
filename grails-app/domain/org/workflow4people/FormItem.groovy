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
import groovy.lang.Binding;

/**
 * FormItem domain class. 
 * Represents a workflow form item. It consists of a reference to the associated field and the base xpath expression to the field.
 * 
 * @author Joost Horward
 */
class FormItem {
	def templateService

	static belongsTo = [formSection: FormSection]
	static listProperties=['position','field','readonly']
	static constraints = {    	
		snippet(nullable:true)
		baseXpath(nullable:true)
	}
    int position
	Field field
	String snippet="formItem"
	@Deprecated
	String baseXpath="/"
	boolean readonly=false

	String toString() {
		try {
			return "${position} - ${field?.name}"
		} catch (Exception e) {
			return "${position} - non-existing field"
		}
	}

	String formSnippet() {
		field.storeXPath("", baseXpath)
		if(readonly) {
			return field.readonlyFormSnippet
		} else {
			return field.formSnippet
		}
	}

	Binding binding() {
		groovy.lang.Binding binding = new Binding()
		binding.formItem=this		
		binding.output=""
		return binding
	}

	def runSnippet(String snippetName,def model=[:]) {
		return templateService.runSnippetTemplate(this,snippetName,model)
	}

	def propertyMissing(String name,args){
		if (name.lastIndexOf("Snippet")>0) {
			def snippetName=name.substring(0,name.lastIndexOf("Snippet"))
			//TODO make this more generic so that it works for all snippets that have an existing readonly variant
			// and defaults to the indicated snippet if the readonly version doesn't exist
			if((readonly) && (snippetName=="section")) {
				snippetName="readonlySection"
			}
			return runSnippet(snippetName)
		} else {
			throw new MissingPropertyException(name,Field.class,args)
		}
	}
}