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
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import java.lang.management.*;

/**
 * Status controller
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER','ROLE_WF4P_USER_ADMIN'])
class StatusController {
	def wf4pConfigService
    def status = {
    		def status=[]
    		def webAppLocation = wf4pConfigService.getWebAppLocation()
            long totalMemory = Runtime.getRuntime().totalMemory();
    		long freeMemory = Runtime.getRuntime().freeMemory()
    		long maxMemory = Runtime.getRuntime().maxMemory()
    		def env = System.getenv()
    		def properties=System.getProperties()
    		
    		def iter = ManagementFactory.getMemoryPoolMXBeans().iterator();
    		def memItems=[]
    		while (iter.hasNext())
    		{
    			MemoryPoolMXBean item = (MemoryPoolMXBean) iter.next();
    			def memItem=[:]
    			memItem.put('name',item.getName())
    			memItem.put('type',item.getType())
    			memItem.put('usage',item.getUsage())
    			memItem.put('peak',item.getPeakUsage())
    			memItem.put('collections',item.getCollectionUsage())
    			
    			//memItems+=["${memItem.name}":memItem]
	            memItems+=memItem
    			
    		}
    		
    		['webAppLocation':webAppLocation,'grailsApplicationConfig':grailsApplication.getConfig(),'freeMemory':freeMemory,'totalMemory':totalMemory,'maxMemory':maxMemory,'env':env,'theProperties':properties,'memItems':memItems]

    }
}
