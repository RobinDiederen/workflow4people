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
 * Status of a task
 * 
 * @author Joost Horward
 */
class TaskStatus {
	static listConfig=new ListConfig(name:'taskStatus',controller: 'taskStatus',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'name',sortable:true,filter:true
		column name:'title',sortable:true,filter:true
		column name:'description',sortable:true,filter:true
		column name:'cssClass',sortable:true,filter:true
	}
    static constraints = {	
    }
	
	String name
	String title
	String description	
	String cssClass
	
	String toString() {		
		 return "${title} (${name})"
	  }
}
