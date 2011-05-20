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
 * Role domain class. 
 * Represents a workflow role.
 * Each role has one or more actions which this role can perform on a workflow or form.
 * @author Joost Horward
 */
package org.workflow4people

class Role {
	static listProperties=['id','name','title','description']
	
	String name
	String title
	String description
	static hasMany=[roleAction:Action]

    static constraints = {
		name(help:'x',class:'wide')
		title(help:'x',class:'wide')
		description(nullable:true,help:'x',class:'wide')
		roleAction(selectSort:'name')
    }
	
	String toString() {
		return title
	}
}
