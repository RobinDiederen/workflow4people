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
import org.open_t.dialog.*

/**
 * Document permission domain class. This defines documen permissions. It is used to control access to Document istances
 * 
 * @see org.workflow4people.Document
 * @author Joost Horward
 */
class DocumentPermission {

	static listConfig=new ListConfig(name:'documentPermission',controller: 'documentPermission',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'authority',sortable:true,filter:true
		column name:'role',sortable:true,filter:true
		column name:'remark',sortable:true,filter:true
	}
	
	static belongsTo=[document:Document]

	Authority authority
	Role role
	String remark

	static constraints = {
		remark(nullable:true)
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
