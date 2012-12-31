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

import java.util.logging.Logger;

/**
 * Form tag library
 * This library is used while rendering code snippet GSP's 
 *
 * @author Joost Horward
 */

class FormTagLib {
	static namespace="w"
	def templateService
	
	/*
	 * Creates tags of the form:
	 * <snippet var="" name="" model="" />
	 * or
	 * <snippet type="" name="" model="" />
	 * The model attribute is optional. 
	 * First form: The var attribute is a domain object which needs to have a runSnippet method. The type of snippet is determined from the object's class name and the model is the domain class' binding, merged with the binding from the model attribute.
	 * Second form form: The type attribute determines the snippet type. The model is the binding from the model attribute.
	 * In this case the snippet body is run against the given model and passed on as the body binding 
	 */
	
	
	def snippet = { attrs, body ->
		log.debug "Snippet attrs: ${attrs} body: ${body}"
		def model=attrs.model?:[:]
		def bodyText=body?body(model):""		
		model=model+[attrs:attrs,body:bodyText]
		
		if (attrs.type) {
			out << templateService.runGenericSnippetTemplate(attrs.type,attrs.name,model)
		}
		
		if (attrs.var) {	
			out << attrs.var.runSnippet(attrs.name,model)
		}
	}
	
	def items = { attrs,body -> 
		def sectionInstance=attrs.section
		org.workflow4people.FormItem.findAllByFormSection(sectionInstance,[sort:'position',order:'asc']).each { formItem ->	
        out << body((attrs.var):formItem)			
		}		
	}
	
	
	def pages = { attrs,body ->
		def formInstance=attrs.form
		org.workflow4people.FormPage.findAllByForm(formInstance,[sort:'position',order:'asc']).each { formPage ->
		out << body((attrs.var):formPage)
		}
	}
	
	def sections = { attrs,body ->
		def pageInstance=attrs.page
		org.workflow4people.FormSection.findAllByFormPage(pageInstance,[sort:'position',order:'asc']).each { formSection ->
		out << body((attrs.var):formSection)
		}
	}
		
	def namespaceFieldTypes = { attrs, body ->
	FieldType.findAllByNamespace(attrs.namespace,[sort:'name',order:'asc']).each({ fieldType ->
		log.debug "Namespace fieldtype ${fieldType}"		
        out << body((attrs.var):fieldType)
		})	
	}
}
