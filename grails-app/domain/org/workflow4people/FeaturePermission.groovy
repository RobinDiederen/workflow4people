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
 * Feature permission domain class. This defines presentation feature permissions. It is used to control access to features defined in org.workflow4people.Feature.
 * 
 * @see org.workflow4people.Feature
 * @author Joost Horward
 */
class FeaturePermission {
	static listProperties=['id','authority','role','remark']
	static belongsTo=[feature:Feature]

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
