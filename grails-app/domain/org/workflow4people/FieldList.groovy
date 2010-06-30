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

import groovy.lang.Binding;

/**
 * FieldList domain class. This defines a list of fields.
 * @see org.workflow4people.Field
 * @author Joost Horward
 */

class FieldList implements Serializable {
	def templateService
    static constraints = {
    	name()    	
    	namespace()
    	baseType()
    	label()
    	description(size:0..50000)
    	field(sortable:true,sort:'fieldPosition',sortOrder:'asc')
    	    
    }
    static mapping = {
    	   field sort:'name'
   	}

    
    static transients = ["xpath"]
	static hasMany = [field : Field]    
    
    String name
    Namespace namespace
    BaseType baseType
    String label
    String description
    String xpath
       
    Binding binding() {	
		groovy.lang.Binding binding = new Binding()
		binding.fields=Field.findAllByFieldList(this,[sort:'fieldPosition',order:'asc'])
		binding.name=this.name		
		binding.fieldList=this		
		binding.output=""
		return binding
	}
    

    def propertyMissing(String name,args){	
		if (name.lastIndexOf("Snippet")>0) {
			def snippetName=name.substring(0,name.lastIndexOf("Snippet"))			
			return templateService.runSnippetTemplate(this,snippetName)			
		} else {
			throw new MissingPropertyException(name,Field.class,args)
		}			
	}
        
    void storeXPath(String prefix, String theXPath){
    	//xpath=theXPath+"/${prefix}:${name}"
    	xpath=theXPath
    	log.debug("Stored xpath: ${xpath}")
    	field.each {
    		it.storeXPath(namespace.prefix,xpath+'/'+namespace.prefix+':'+it.name)    	
    	}
    	
    }
	
	String toString() {
		  return name;
	}
	
	void renumberPositions(){
		def currentPosition=1;
		Field.findAllByFieldList(this,[sort:'fieldPosition',order:'asc']).each({
			def field = Field.get(it.id)
			field.fieldPosition=currentPosition
			field.save()
			currentPosition++
		});
	}
	
}
