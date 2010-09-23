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
 * FieldTypeItem domain class. 
 * Holds a list of items that are part of the field definition.
 * Usually this is used when the type is an enumeration type.
 * @author Joost Horward
 */
class FieldTypeItem {
	static belongsTo = [fieldType:FieldType]	
    static constraints = {
    	itemPosition(help:'x')
    	label(help:'x',class:'wide')
    	value(help:'x',class:'wide')
    }
    int itemPosition
    String label
    String value
    
    String toString() {
		return "${label} (${value})"
	}
}
