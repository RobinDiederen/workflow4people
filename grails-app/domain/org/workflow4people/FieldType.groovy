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

import groovy.lang.Binding;
import org.workflow4people.services.*;

/**
 * FieldType domain class. This defines a type of field. It links back to an XML Schema type (baseSchemaType) and a BaseFieldType.
 * @see org.workflow4people.Field
 * @author Joost Horward
 */

class FieldType {
	def templateService
	
	static listProperties=['id','name','namespace','baseType','baseSchemaType','description']
	
	static hasMany = [fieldTypeItem : FieldTypeItem]    
	static constraints = {
		name(help:'x',class:'wide')
		namespace(nullable:true,help:'x')
		// TODO Nullable alleen voor migratie
	
		baseType(nullable:true,help:'x')
		baseSchemaType(nullable:true,help:'x')
		
				
		description(size:0..50000,help:'x')	    
	    defaultValue(nullable:true,help:'x',class:'wide')
	    label(nullable:true,help:'x',class:'wide')
	    help(size:0..50000,help:'x')
	    alert(size:0..50000,help:'x')
	    
	    runtimeEditableList(help:'x')
	    
	    generateSchemaType(nullable:true,help:'x')
	    restrictions(nullable:true,help:'x')
	    length(nullable:true,help:'x')
	    minLength(nullable:true,help:'x')
	    maxLength(nullable:true,help:'x')
	    pattern(nullable:true,class:'wide',help:'x')
	    minInclusive(nullable:true,help:'x')
	    maxInclusive(nullable:true,help:'x')
	    minExclusive(nullable:true,help:'x')
	    maxExclusive(nullable:true,help:'x')
	    
	    fieldTypeItem(sortable:true,sort:'itemPosition',sortOrder:'asc',display:false,edit:true,create:true,delete:true,show:true)
	    
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
     * Flag to indicate whether restrictions should be applied. The fieldtype binding for the template provides a 'restrictions' generated field that contains XML schema bindings based on the properties of the field type.
     */
    boolean restrictions=false
    /**
     * Fixed length restriction
     */
    String length
    /**
     * Minimum length restriction
     */
    String minLength
    /**
     * Maximum length restriction
     */
    String maxLength
    /**
     * Pattern restriction
     */
    String pattern
    /**
     * Minimum inclusive range restriction
     */
    String minInclusive
    /**
     * Maximum inclusive range restriction
     */
    String maxInclusive
    /**
     * Minimum exclusive range restriction
     */
    String minExclusive
    /**
     * Maximum exclusive range restriction
     */
    String maxExclusive
    /**
     * Provides a binding for the field type. The binding is used by the template.
     * Contains:
     * - name
     * - baseSchemaType
     * - restrictions
     * - fieldType
     */
    Binding binding() {	
		groovy.lang.Binding binding = new Binding()		
		binding.name=this.name
		binding.baseSchemaType=this.baseSchemaType
		
		binding.restrictions=""
		if (maxLength) binding.restrictions+="<maxLength value=\"${maxLength}\" />"
		if (minLength) binding.restrictions+="<minLength value=\"${minLength}\" />"
		if (length) binding.restrictions+="<length value=\"${length}\" />"
		if (minInclusive) binding.restrictions+="<minInclusive value=\"${minInclusive}\" />"
		if (maxInclusive) binding.restrictions+="<maxInclusive value=\"${maxInclusive}\" />"
		if (minExclusive) binding.restrictions+="<minExclusive value=\"${minExclusive}\" />"
		if (maxExclusive) binding.restrictions+="<maxExclusive value=\"${maxExclusive}\" />"
		if (pattern) binding.restrictions+="<pattern value=\"${pattern}\" />"
	
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
    		return "${namespace.prefix}:${name}"
		else
			return baseSchemaType
    }

    /**
     * String representation of this field type. Just returns the name of the field type
     */
    
    String toString() {
		  return name;
	}
	// TODO check if this is used at all?
	void renumberItems(){
		def currentItemPosition=1;
		FieldTypeItem.findAllByFieldType(this,[sort:'itemPosition',order:'asc']).each({
			def fieldTypeItem = FieldTypeItem.get(it.id)
			fieldTypeItem.itemPosition=currentItemPosition
			fieldTypeItem.save()
			currentItemPosition++
		});
	}
	
	
}
