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
 * Person domain class. 
 * Represents a person.
 * @author Joost Horward
 */
class Person  {
	static listProperties=['id','username','userRealName','familyName','givenName','email']
	static hasMany = [authorities: Authority]
	static belongsTo = Authority

	/** Username */
	String username
	/** User Real Name*/
	String userRealName
	String familyName
	String givenName
	
	/** MD5 Password */
	String passwd
	/** enabled */
	boolean enabled = true

	String email
	boolean emailShow

	/** description */
	String description = ''

    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired	

	static constraints = {
		username(blank: false, unique: true,help:'x',class:'wide')
		userRealName(blank: false,help:'x',class:'wide')
		familyName(blank: false,help:'x',class:'wide',nullable:true)
		givenName(blank: false,help:'x',class:'wide',nullable:true)
		email(help:'x',class:'wide')
		emailShow(help:'x')
		enabled(help:'x')
		passwd(blank: false,password:true,show:false,help:'x',class:'wide')
		authorities(nullable:true,help:'x',sortable:true,selectSort:'authority')
		accountExpired(nullable: false)
		accountLocked(nullable: false)
		passwordExpired(nullable: false)		
	}
			
	String toString() {
		  return username;
	  }	
}
