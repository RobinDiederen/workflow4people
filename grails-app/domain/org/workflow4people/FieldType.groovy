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
import org.workflow4people.services.*;
import org.open_t.dialog.*

/**
 * FieldType domain class. This defines a type of field. It links back to an XML Schema type (baseSchemaType) and a BaseFieldType.
 * 
 * @see org.workflow4people.Field
 * @author Joost Horward
 */
class FieldType {
	def templateService
	
	static listConfig=new ListConfig(name:'fieldType',controller: 'fieldType',bFilter:true).configure {		
		column name:'id',sortable:true,filter:true
		column name:'name',sortable:true,filter:true
		column name:'namespace',sortable:true,filter:true
		column name:'baseType',sortable:true,filter:true
		column name:'baseSchemaType',sortable:true,filter:true
		column name:'description',sortable:true,filter:true
	}
	
	static hasMany = [fieldTypeItem : FieldTypeItem]    
	static constraints = {		
		namespace(nullable:true)
		// TODO Nullable alleen voor migratie
		baseType(nullable:true)
		baseSchemaType(nullable:true)

		description(size:0..50000)	    
	    defaultValue(nullable:true)
	    label(nullable:true)
	    help(size:0..50000)
	    alert(size:0..50000)
	    
	    
	    
	    generateSchemaType(nullable:true)
	    
	    
		listParent(nullable:true)
	    
    }
	
	static mapping = {
		description type: 'text'
		help type: 'text'
		alert type: 'text'
	}
	
	/**
	 *  The name of the field type. This name is used in the XML Schema. 
	 */
    String name
    /**
     * The namespace of the field type. Only useful	if generateSchemaType is true or if the type is included and referenced (like the header). 
     */
    Namespace namespace
    /**
     * Textual description of this field type
     */
    String description
    /**
     * Default value. Can be overridden by individual fields.
     */
    String defaultValue
    /**
     * The value to be shown in the label in the input form. Can be overridden by individual fields.
     */
    String label
    /**
     * The help text to be shown in the input form. Can be overridden by individual fields.
     */
    String help
    /**
     * The text to be shown in the input form when validation fails. Can be overridden by individual fields.
     */
    String alert
    /**
     * Flag to indicate whether the runtime system should allow for this list to be editable.
     */
    boolean runtimeEditableList
    /**
     * The base type for this field type. This sets a set of default snippets in the template to be used.
     */
    BaseType baseType
    /**
     * Flag to indicate whether this field type should be generated as a type in the XML Schema library. 
     */
    boolean generateSchemaType=true
    // the Schema type on which this fieldtype is based
    String baseSchemaType
    
    
    /**
	 * Parent for field list associated with this FieldType
	 */
	Field listParent
	
	
	Map snippetParameters
	
    /**
     * Provides a binding for the field type. The binding is used by the template.
     * Contains:
     * - name
     * - baseSchemaType
     * - fieldType
     * - parameters
     * - snippetConfig
     */
    Binding binding() {	
		groovy.lang.Binding binding = new Binding()		
		binding.name=this.name
		binding.baseSchemaType=this.baseSchemaType
	
		def templateSnippetConfig=templateService.getSnippetConfig(name)?:templateService.getSnippetConfig(baseType.name)

		def defaultParameters=templateSnippetConfig.parameters.collectEntries { key, item ->
			[key,item.defaultValue]
		}
		
		binding.snippetConfig=templateSnippetConfig

		binding.parameters=defaultParameters+snippetParameters
		
		binding.fieldType=this
		binding.output=""
		return binding
	}
	
	/**
	 * propertyMissing
	 * Dynamic properties of the form [name]Snippet 
	 * When such a property is referenced the corresponding template snippet is run.
	 * This allows for each template to define it's own snippet names for field types. 
	 * 
	 * @param name The name of the property
	 * @param args Any arguments 
	 * @return
	 */

    def propertyMissing(String name,args){
    	
    	def snippetName
		if (name.lastIndexOf("Snippet")>0) {
			snippetName=name.substring(0,name.lastIndexOf("Snippet"))
			if((generateSchemaType==false) && (snippetName=="schemaType")) {
				log.debug "FieldType: not generating ${snippetName}"
				return ""
			} else {
				log.debug "FieldType: generating ${snippetName}"
				return templateService.runSnippetTemplate(this,snippetName)
			}
		} else {
			throw new MissingPropertyException(name,Field.class,args)
		}
			
	}
    
	def runSnippet(String snippetName,def model=[:]) {
		return templateService.runSnippetTemplate(this,snippetName,model)
	}
    
    
    /**
     * getSchemaType
     * @return The name of this schema type, or the base type if this fieldtype does not generate its own schema type
     */
    
    def getSchemaType() {
    	if (generateSchemaType)
			if(namespace) {
				return "${namespace?.prefix}:${name}"
			} else {
				return name
			}
		else
			return baseSchemaType
    }

    /**
     * String representation of this field type. Just returns the name of the field type
     */
    
    String toString() {
		  return name;
	}
	
	
}
