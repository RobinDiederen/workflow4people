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

/** 
 * Describes an authority for Spring security
 * 
 * @author Joost Horward
 */
class Authority {
	/**
	 * properties to be shown in the user interface list	
	 */	
	static listProperties=['id','authority','description','authorityType']
	static hasMany = [people: Person]	
	String description
	/**
	 * The name of this authority (Role). When used in the backend with Sprin security, the name has to start with ROLE_
	 */
	String authority = ''
	
	/**
	 *  Group type; introduced because jBPM has the notion of a group type. Used to define a group as a home group by setting this value to 'home'
	 */
	String authorityType

	static constraints = {
		authority(blank: false,unique:true)
		description(nullable:true)
		authorityType(nullable:true)		
	}	
	
	/**
	 * String representation of this authority, simply returns the authority property
	 * @return The string representation of this authority
	 */
	String toString() {
		  return authority;
	}
	
}
