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
	static listProperties=['id','name','description']
	static belongsTo = [parent: Field]
    static constraints = {
		parent(help:'x',nullable:true)
		fieldPosition()
		name(help:'x',class:'wide')
		fieldType(help:'x')
		
				
		description(nullable:true,size:0..50000)
    	
    	defaultValue(nullable:true,class:'wide')
    	label(nullable:true,class:'wide')
    	help(nullable:true,size:0..50000)
	    alert(nullable:true,size:0..50000)
	    fieldLength(nullable:true)
	    contentText(nullable:true,size:0..50000)
	    
	    
	    // Determines repetition of this field
	    
	    minOccurs(nullable:true)
	    maxOccurs(nullable:true)
		    nillable(nullable:true)
		    
	    // Determines dependency of this field on another field
		dependsOn(nullable:true)
		dependencyType(nullable:true,inList:['true','false','empty','nonempty','gt','lt','eq','ne'])	    	
		dependencyParameter(nullable:true)
	    
    	readonly(help:'x')
	
	    xpath(nullable:true,class:'extrawide')
	    
    }
	def templateService
    int fieldPosition=1
    
    /**
     * The parent of this field
     */
    //Field parent
    
    /**
     * The type of this field
     */
    FieldType fieldType

    /** 
     * The child field list that is represented by this field. When this is populated, the field behaves as a list.
     * The fieldType should be set to a type that supports a list.  
     */
    //FieldList childFieldList
    
    
	boolean readonly=false
	
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
        
    String toString() {
		
		  def theName
		  try {
			  theName = name ? name : fieldType.name;		  
			  return "${theName} - ${fieldType.name}"
		  } 
		  catch (Exception e) {
			  return "${name} - fieldType does not exist"
		  }
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
	
	def getPrefixedName() {
		return "${parent.fieldType.namespace.prefix}:${getFieldProperty('name')}"
	}
	
	def getBinding() {
		return binding()
	}
	
	
	Binding binding() {
		
		groovy.lang.Binding binding = new Binding()		
		
		binding.name=getFieldProperty('name');
		binding.namespacePrefix=namespacePrefix
		binding.prefixedName="${namespacePrefix}:${name}"		
		
		binding.label = getFieldProperty('label')
		binding.help=getFieldProperty('help')			
		binding.alert=getFieldProperty('alert')		
		binding.fieldLength=getFieldProperty('fieldLength')
		binding.minLength=fieldType.minLength ? fieldType.minLength : ""
		binding.maxLength=fieldType.maxLength ? fieldType.maxLength : ""
		
		binding.minInclusive=fieldType.minInclusive ? fieldType.minInclusive : ""
		binding.maxInclusive=fieldType.maxInclusive ? fieldType.maxInclusive : ""
			
		binding.minExclusive=fieldType.minExclusive ? fieldType.minExclusive : ""
		binding.maxExclusive=fieldType.maxExclusive ? fieldType.maxExclusive : ""
			
		binding.pattern=fieldType.pattern ? fieldType.pattern : ""	
			
		binding.defaultValue = getFieldProperty('defaultValue')
		
		binding.fieldTypeName=fieldType.name
		binding.contentText=getFieldProperty('contentText')
		
		binding.occurrence=""
		if (minOccurs?.size()>0) binding.occurrence+=" minOccurs=\"${minOccurs}\""
		if (maxOccurs?.size()>0) binding.occurrence+=" maxOccurs=\"${maxOccurs}\""
			
		binding.xpath=xpath
		binding.gpath=gpath
		binding.listGpath=listGpath
		
		binding.gpathExpr=gpathExpr
		binding.listGpathExpr=listGpathExpr
		
		binding.field=this
		binding.prefix=namespacePrefix
		binding.output=""
		
		binding.fields=Field.findAllByParent(this,[sort:'fieldPosition',order:'asc'])
		binding.children=Field.findAllByParent(this,[sort:'fieldPosition',order:'asc'])
		binding.hasChildren=Field.countByParent(this)>0		
		
		return binding
	}
	
	def getGpath() {
		def indexString=""
		if (maxOccurs?.length()>0) {
			indexString="[${name}Index]"
		}
		
		if (parent) {
			return parent.readGpath(0) ?  "${parent.readGpath(0)}.${name}${indexString}" : "${name}${indexString}" 
			//return "${parent.readGpath(0)}.${name}${indexString}"
		} else {
			//return "${name}${indexString}"
			return ""
		}		
	}
	
	
	// Gpath with the last brackets missing so it refers to the entire list 
	def getListGpath() {				
		if (parent) {
			//return "${parent.readGpath(0)}.${name}"
			return parent.readGpath(0) ? "${parent.readGpath(0)}.${name}" : "${name}"
		} else {
			//return "${name}"
			return ""
		}		
	}
	
	// GPath with expressions in the square brackets
	def getGpathExpr() {
		return gpath.replace('[','[${').replace(']','}]')
	}
	
	def getListGpathExpr() {
		return listGpath.replace('[','[${').replace(']','}]')
	}
	
	
	
	def readGpath(int depth) {
		def indexString=""
			if (maxOccurs?.length()>0) {
				indexString="[${name}Index]"
		}
			
		
		if (depth<30) {
			depth++
			if (parent) {
				//return "${parent.readGpath(depth)}.${name}${indexString}"
				return parent.readGpath(depth) ? "${parent.readGpath(depth)}.${name}${indexString}" : "${name}${indexString}"
			} else {
				//return "${name}${indexString}"
				return ""
			}		
		} else {
			return "GPath nested too deep!"
		}
	}
	
	
	
	
	def getXpath() {
		if (parent) {
			return "${parent.readXpath(0)}/${namespacePrefix}:${name}"
		} else {
			//return "/${namespacePrefix}:${name}"
			return ""
			
		}		
	}
	
	def readXpath(int depth) {
		if (depth<30) {
			depth++
			if (parent) {			
				return "${parent.readXpath(depth)}/${namespacePrefix}:${name}"
			} else {
				//return "/${namespacePrefix}:${name}"
				return ""	
			}
		} else {
			return "XPath Nested too deep!"
		}
	}

		
	
	def getNamespacePrefix() {
			def thePrefix=null
			def f=this
			println "getting namesp"
			while (thePrefix==null && f.parent!=null && f.parent!=f) {
				println "f=${f}"				
				f=f.parent
				if (f.fieldType.namespace) {
					thePrefix=f.fieldType.namespace.prefix
				}
			}
			return thePrefix
	}
	
	
	def propertyMissing(String name,args){	
		if (name.lastIndexOf("Snippet")>0) {
			def snippetName=name.substring(0,name.lastIndexOf("Snippet"))
			println "Running field snippet ${snippetName} for field ${this.name}"
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

	
	def runSnippet(String snippetName,def model=[:]) {
		return templateService.runSnippetTemplate(this,snippetName,model)
	}
	
	def getDependencySource() {
		return Field.findByDependsOn(this)!=null
	}
	
	def getDescendants() {
		def fields=[]
		Field.findAllByParent(this).each { field ->
			fields+=field
	        fields+=field.getDescendants()
		}
		return fields
	}
	
	/*
	 * This function returns the id of the parent of this field that is visible in the DME
	 * That means that if the parent of this field is the listParent the visible element is the FieldType
	 */
	def getVisibleParentId() {
		def parentId=""
		if (parent?.parent==null || parent?.parent==parent?.parent) {
			def theFieldType=FieldType.findByListParent(parent)			
			parentId="fieldtype_${theFieldType?.id}"
		} else {
			parentId="field_${parent.id}"
		}
		return parentId
	}
	
}
