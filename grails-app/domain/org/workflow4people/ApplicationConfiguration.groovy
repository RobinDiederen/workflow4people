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
 * Application Configuration domain class.
 * Simply stores key/value pairs used to configure workflow4people. This serves as a settings registry.
 * 
 * @author Joost Horward
 */
class ApplicationConfiguration {
	/**
	 * properties to be shown in the user interface list	
	 */
	
	static listConfig=new ListConfig(name:'applicationConfiguration',controller: 'applicationConfiguration',bFilter:true).configure {
		column name:'id',sortable:true
		column name:'configKey',sortable:true,filter:true
		column name:'configValue',sortable:true,filter:true
	}
	
	static features = []
    static constraints = {
    }
    /**
     * The key that identifies the configuration item
     */
    String configKey
    /**
     * The value of the configuration item
     */    
    String configValue
    /**
     * String representation of configuration item
     * @returns The string representation of this configuration item
     */
    String toString() {		  
		  return "${configKey} - [${configValue}]"
	  }
    
    
}
