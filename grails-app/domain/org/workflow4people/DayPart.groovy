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
 * Day part domain class.
 * Stores day parts for the business calendar.  
 * @author Joost Horward
 */
class DayPart {

	static listProperties=['id','position','dayName','fromTime','toTime']
	
    static constraints = {
    	position(help:'x')
    	dayName(inList:['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],help:'x')
    	fromTime(matches:"[0-9]{2}:[0-9]{2}",help:'x')
    	toTime(matches:"[0-9]{2}:[0-9]{2}",help:'x')
    }
    int position
    String dayName
    String fromTime
    String toTime
    String toString() {		  
		  return "${dayName} ${fromTime}-${toTime}"
	}
}
