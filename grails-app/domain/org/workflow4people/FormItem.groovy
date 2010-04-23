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
 * FormItem domain class. 
 * Represents a workflow form item. It consists of a reference to the associated field and the base xpath expression to the field.
 * @author Joost Horward
 */


class FormItem {
	static belongsTo = [form: Form]
    static constraints = {
    	position()
    	field()
    	baseXpath(nullable:true)
    	readonly()
    	form(display:false)
    }
    int position
    Field field
    String baseXpath="/"
    boolean readonly=false
    
    String toString() {
		return "${position} - ${field.name}" 
	}
	
	String formSnippet() {
		field.storeXPath("", baseXpath)
		if(readonly) {
			return field.readonlyFormSnippet
		} else {
			return field.formSnippet
		}
			
	}
    
}
