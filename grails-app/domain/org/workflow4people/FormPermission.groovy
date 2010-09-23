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

/**
 * FormPermission domain class. 
 * Represents a permission of an Authority on a form.
 * Each permission assigns a Role on the Form to the Authority
 * @author Joost Horward
 */

package org.workflow4people

class FormPermission {
	static belongsTo=[form:Form]
	                  
    Authority authority
	Role role
	String remark
	
    static constraints = {
		
		authority(help:'x')
		role(help:'x')
		remark(nullable:true,class:'extrawide',help:'x')
		form(display:false,help:'x')
    }
	
	String toString() {
		try {
			return "${authority.authority} (${role.name})"
		}
		catch (Exception e) {
			return "Authority or role does not exist"
		}
	}
	
	
}
