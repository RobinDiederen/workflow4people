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
import org.workflow4people.services.*;

/**
 * Field domain class. This defines a field in a field list.
 * @see org.workflow4people.FieldList,org.workflow4people.FieldType
 * @author Joost Horward
 */

class Field {
	//static transients = ["xpath"]
	static belongsTo = [fieldList: FieldList]	
    static constraints = {
		fieldPosition()
		name(help:'x')
		fieldType(help:'x')
		childFieldList(nullable:true,display:true,help:'x')		
		fieldList(display:false)
				
		description(size:0..50000,help:'x')
    	
    	defaultValue(nullable:true,help:'x')
    	label(help:'x')
    	help(nullable:true,size:0..50000,help:'x')
	    alert(nullable:true,size:0..50000,help:'x')
	    fieldLength(nullable:true)
	    contentText(nullable:true,size:0..50000,help:'x')
	    
	    
	    // Determines repetition of this field
	    
	    minOccurs(nullable:true,help:'x')
	    maxOccurs(nullable:true,help:'x')
	    nillable(help:'x')
	    
	    // Determines dependency of this field on another field
	    dependsOn(nullable:true,help:'x')
	    dependencyType(nullable:true,inList:['true','false','empty','nonempty','exist','nonexist','gt','lt','eq','ne'],help:'x')	    	
	    dependencyParameter(nullable:true,help:'x')
	    customDependencyExpression(nullable:true,size:0..50000,help:'x')
	    
    	readonly(help:'x')
	    securitylevelRead(nullable:true,help:'x')
    	securitylevelReadWrite(nullable:true,help:'x')

	    xpath(nullable:true)
	    
    }
	def templateService
    int fieldPosition
    
    /**
     * The position of this field in the list of data elements
     */
    FieldType fieldType

    /** 
     * The child field list that is represented by this field. When this is populated, the field behaves as a list.
     * The fieldType should be set to a type that supports a list.  
     */
    FieldList childFieldList
    
    
	boolean readonly=false
	int securitylevelRead
	int securitylevelReadWrite
	
    String description
    
    // The fields below can override field definitions
    String name     
    String defaultValue
    String label
    String help
    /**
     * The alert to show in the XForm. If empty, the alert from the FieldType is used 
     */
    String alert
    String fieldLength
    
    String contentText
    
    // repetition    
    String minOccurs 
    String maxOccurs 
    
    boolean nillable=false
    
    // Arranges conditional showing of this field
    Field dependsOn
    String dependencyType
    String dependencyParameter
    String customDependencyExpression
    
    // Transient field
    String xpath
    
    String toString() {
		  def theName
		  theName = name ? name : fieldType.name;
		  if (fieldList){
			  theName="${theName} (${fieldList.name})"
		  }
		  return "${theName} - ${fieldType.name}"
	  }
	
	/*
	 * Returns the asked property value
	 * If the property of the field is empty, the linked field (if any) or the fieldType field is used
	 * 
	 */
	
	String getFieldProperty(String name){
		if (this."${name}"?.length() == 0 | this."$name"==null)  {						
				
					if (this.fieldType.properties[name]) {
						//println(this.fieldType."${name}")
						return this.fieldType."${name}"
						
					} else {
						return ("")
					}				
			
		}  else {
			def value=this."${name}"
			//println ("Returning field property value ${value} of field ${this.name} (${this.id})for ${name}")
			return (this."${name}");
		}
	}
	
	Binding binding() {
		
		groovy.lang.Binding binding = new Binding()		
		
		binding.name=getFieldProperty('name');
		binding.namespacePrefix=fieldList.namespace.prefix
		binding.prefixedName="${fieldList.namespace.prefix}:${binding.name}"
		
		
		binding.label = getFieldProperty('label')
		binding.help=getFieldProperty('help')			
		binding.alert=getFieldProperty('alert')		
		binding.fieldLength=getFieldProperty('fieldLength')				
		binding.defaultValue = getFieldProperty('defaultValue')
		
		binding.fieldTypeName=fieldType.name
		binding.contentText=getFieldProperty('contentText')
		
		binding.occurrence=""
		if (minOccurs?.size()>0) binding.occurrence+=" minOccurs=\"${minOccurs}\""
		if (maxOccurs?.size()>0) binding.occurrence+=" maxOccurs=\"${maxOccurs}\""	
		binding.xpath=xpath
		binding.field=this
		binding.prefix=fieldList.namespace.prefix
		binding.output=""
		if (childFieldList) {			
			binding.fields=Field.findAllByFieldList(childFieldList,[sort:'fieldPosition',order:'asc'])
			binding.childFieldListName=childFieldList.name
			if (binding.label.size()<1) label=childFieldList.label
			// flooding everything below with xpath
			log.debug("Storing xpath prefix ${fieldList.namespace.prefix} and xpath ${this.xpath} in ${childFieldList.name}")
			childFieldList.storeXPath(fieldList.namespace.prefix, this.xpath)
		}
		
		// Yes. we need to do this for the xpath, too. It will always stop at the field though
		// It will never reach the FieldType because the lowest level field always has its' xpath value filled.
		binding.xpath=getFieldProperty('xpath')
		return binding
	}
		void storeXPath(String prefix,String theXPath){
		xpath=theXPath
    			    	
    	if (childFieldList) {
    		childFieldList.storeXPath(prefix,xpath)    			    	    		
    	}
    }
	
	def propertyMissing(String name,args){	
		if (name.lastIndexOf("Snippet")>0) {
			def snippetName=name.substring(0,name.lastIndexOf("Snippet"))
			//TODO make this more generic so that it works for all snippets that have an existing readonly variant
			// and defaults to the indicated snippet if the readonly version doesn't exist
			if((readonly) && (snippetName=="form")) {
				snippetName="readonlyForm"
			}
			return templateService.runSnippetTemplate(this,snippetName)			
		} else {
			throw new MissingPropertyException(name,Field.class,args)
		}
			
	}
	
}
