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
 * Form tag library
 * This library is used while rendering code snippet GSP's 
 *
 * @author Joost Horward
 */

class FormTagLib {
	static namespace="w"
	def templateService
	
	def models = { attrs, body ->
		org.workflow4people.FieldType.findAll().each { fieldType ->
			if (fieldType.modelSnippet) {
				def model=[content:fieldType.modelSnippet,fieldType:fieldType]
		        out << body((attrs.var):model)
			}
		}
	}

	def fields = { attrs, body ->
		println "FIELDS: ${attrs}"
		if(attrs.workflow) {
			def workflow=attrs.workflow
			workflow.documentType.fieldList.init()
			org.workflow4people.Field.findAllByFieldList(workflow.documentType.fieldList,[sort:'name',order:'asc']).each { field ->					
		        out << body((attrs.var):field)			
			}
		}
		
		if (attrs.fieldList) {
			def fieldList=attrs.fieldList
			fieldList.init()
			org.workflow4people.Field.findAllByFieldList(fieldList,[sort:'fieldPosition',order:'asc']).each { field ->					
		        out << body((attrs.var):field)			
			}
		}				
	}

	def fieldTypes = { attrs, body ->		
		org.workflow4people.FieldType.findAll().each { fieldType ->					
        	out << body((attrs.var):fieldType)			
		}
	}
	
	/*
	 * Creates tags of the form:
	 * <snippet var="" name="" model="" />
	 * or
	 * <snippet type="" name="" model="" />
	 * The model attribute is optional. 
	 * First form: The var attribute is a domain class variable which needs to have a runSnippet method. The type of snippet is determined from the var class name and the model is the domain class' binding, merged with the binding from the model attribute.
	 * Second form form: The type attribute determines the snippet type. The model is the binding from the model attribute. 
	 */
	
	
	def snippet = { attrs, body ->
		def model=attrs.model? attrs.model : [:]
		if (attrs.type) {
			out << templateService.runGenericSnippetTemplate(attrs.type,attrs.name,model)
		}
		if (attrs.var) {	
			out << attrs.var.runSnippet(attrs.name,model)
		}
	}
	
	def formItems = { attrs,body -> 
		def formInstance=attrs.form
		org.workflow4people.FormItem.findAllByForm(formInstance,[sort:'position',order:'asc']).each { formItem ->	
        out << body((attrs.var):formItem)			
		}		
	}
	
	
	
	
	

	
	
	def workflows = { attrs, body ->
	org.workflow4people.WorkflowDefinition.findAllByPublish(true).each { workflow ->			
	        out << body((attrs.var):workflow)
		}
	}
	
	
	def form = { attrs,body -> 
		def formInstance=attrs.form
		def model=[name:formInstance.name,title:formInstance.title,formAction:formInstance.formAction,workflow:formInstance.workflow,explanationMessage:formInstance.explanationMessage]
		
        out << body((attrs.var):model)
	}
		
	def sections = { attrs,body -> 
		def formInstance=attrs.form
		org.workflow4people.FormItem.findAllByForm(formInstance,[sort:'position',order:'asc']).each { formItem ->
		
			def prefixedName="${formItem.field.fieldList.namespace.prefix}:${formItem.field.name}"
			
			def theType="element"
			if (formItem.field.childFieldList) {
			 theType = formItem.field.fieldType.name=="repeatingFieldList"?"repeat":"group"
			}
				
			def section=[title:formItem.field.label,formItem:formItem,xpath:formItem.baseXpath,prefixedName:prefixedName,type:theType,id:formItem.id]
            out << body((attrs.var):section)			
		}		
	}
	
	def items = { attrs,body -> 
		def section=attrs.section
	
		def theFields
		if (section.formItem.field.childFieldList) {
			theFields=Field.findAllByFieldList(section.formItem.field.childFieldList,[sort:'fieldPosition',order:'asc'])
		} else {
			theFields=[section.formItem.field]
		}
	
		theFields.each { field ->
			field.storeXPath("", section.formItem.baseXpath)
			if(section.formItem.readonly) {
				def theItem=[title:field.label,content:field.readonlyFormSnippet]
	            out << body((attrs.var):theItem)
			} else {
				def theItem=[title:field.label,content:field.formSnippet]
	            out << body((attrs.var):theItem)
			}
		}
	
	}
	
	def namespaceFieldLists = { attrs, body ->
	FieldList.findAllByNamespace(attrs.namespace,[sort:'name',order:'asc']).each({ fieldList ->		
        out << body((attrs.var):fieldList)
		})
	
	}
	
	def namespaceFieldTypes = { attrs, body ->
	FieldType.findAllByNamespace(attrs.namespace,[sort:'name',order:'asc']).each({ fieldType ->		
        out << body((attrs.var):fieldType)
		})
	
	}
}
