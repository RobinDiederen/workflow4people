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
 * BusinessCalendar service class. 
 * Provides calendar services which are implemented by the modified jBPM business calendar.
 * Configuration takes place using ApplicationConfiguration, Holiday and DayPart domain classes rather than the XML provided with jBPM.
 * Adds a businessDuration function to calculate actual duration based on a startdate and end date.
 * 
 * @author Joost Horward
 */


package org.workflow4people.services
import org.workflow4people.*;
import org.springframework.beans.factory.InitializingBean;

import sun.rmi.runtime.Log;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.jbpm.pvm.internal.cal.*;
import org.mortbay.*;

public class BusinessCalendarService extends BusinessCalendarImpl implements BusinessCalendar,InitializingBean {

    boolean transactional = false
    def initialized=false
	
    Day fndDay(String dayName) {    	
    	Day day = new Day();
        day.setBusinessCalendar(this);
        DateFormat hourFormat = new SimpleDateFormat("HH:mm");
        
        def dayPartIndex=0
      
        def dayParts= org.workflow4people.DayPart.findAllByDayName(dayName).collect({ dp ->
        	
        	org.jbpm.pvm.internal.cal.DayPart dayPart = new org.jbpm.pvm.internal.cal.DayPart()
        	
            dayPart.setDay(day);

            Calendar calendar = new GregorianCalendar();
            
            Date from = hourFormat.parse(dp.fromTime);
            calendar.setTime(from);
            dayPart.setFromHour(calendar.get(Calendar.HOUR_OF_DAY));
            dayPart.setFromMinute(calendar.get(Calendar.MINUTE));
            
            Date to = hourFormat.parse(dp.toTime);
            calendar.setTime(to);
            dayPart.setToHour(calendar.get(Calendar.HOUR_OF_DAY));
            dayPart.setToMinute(calendar.get(Calendar.MINUTE));
            
            dayPart.setIndex(dayPartIndex);
            dayPartIndex++
            
            return dayPart        	
        });        
        org.jbpm.pvm.internal.cal.DayPart[] dayPartArray = new org.jbpm.pvm.internal.cal.DayPart[dayParts.size()];
        dayPartArray = dayParts.toArray(dayPartArray);
        day.setDayParts(dayPartArray);
       return day
    }
    /*
     * Poor man's lazy-but-not-too-lazy initializer
     * InitializingBean afterPropertiesSet comes too early (Domain classes not available)
     * Setting the spring bean definition of jBPM to lazy comes too late (service classes and controllers cannot find jBPM)
     * There should be a more elegant way?
     */
    void init() {
    	if (!initialized) {
    	
	    	log.debug "Initializig business days"
	    	Day[] days = new Day[8];
	    	days[Calendar.SUNDAY]=fndDay("Sunday");
	    	days[Calendar.MONDAY]=fndDay("Monday");
	    	days[Calendar.TUESDAY]=fndDay("Tuesday");
	    	days[Calendar.WEDNESDAY]=fndDay("Wednesday");
	    	days[Calendar.THURSDAY]=fndDay("Thursday");
	    	days[Calendar.FRIDAY]=fndDay("Friday");
	    	days[Calendar.SATURDAY]=fndDay("Saturday");
	    	setDays(days)
	    	
	    	log.debug "Initializig holidays"
	    	
	    	holidays = new org.jbpm.pvm.internal.cal.Holiday[org.workflow4people.Holiday.count()];
	    	def i=0
	    	org.workflow4people.Holiday.findAll().each { hol ->
	    	  def holiday=new org.jbpm.pvm.internal.cal.Holiday()
	    	  holiday.setFromDay (hol.fromDate)
	    	  holiday.setToDay (hol.toDate)
	    	  holidays[i] = holiday
	    	  i++
	    	}
	    	
	    	def configItem
	    	
	    	configItem=ApplicationConfiguration.findByConfigKey('calendar.businessDayInMinutes')
	    	if (configItem) {
	    		setBusinessDayInMillis(configItem.configValue.asType(Long)*minuteInMillis)
	    	}
	    	
	    	configItem=ApplicationConfiguration.findByConfigKey('calendar.businessWeekInMinutes')
	    	if (configItem) {
	    		setBusinessWeekInMillis(configItem.configValue.asType(Long)*minuteInMillis)
	    	}
	    	
	    	configItem=ApplicationConfiguration.findByConfigKey('calendar.businessMonthInDays')
	    	if (configItem) {
	    		setBusinessMonthInMillis(configItem.configValue.asType(Long)*dayInMillis)
	    	}
	    	
	    	configItem=ApplicationConfiguration.findByConfigKey('calendar.businessYearInDays')
	    	if (configItem) {
	    		setBusinessYearInMillis(configItem.configValue.asType(Long)*dayInMillis)
	    	}
	    	
	    	
	    	initialized=true
    	}
	}
    
    
    void afterPropertiesSet() {
    	//init()
	}
    

    Date add(Date date, String duration) {
    	init()    
    	return super.add (date,duration)
    }
    
    public long businessDuration(Date startDate, Date endDate) {
    	log.debug "The dates are: ${startDate} ${endDate}"
    	init()
    	if (startDate>endDate) {
    		def s=startDate
    		def e=endDate
    		startDate=e
    		endDate=s
    	}
    	
    	
    	org.jbpm.pvm.internal.cal.DayPart dayPart = findDayPart(startDate);
    	if (!dayPart) {
    		// find the daypart for the start date 
    		Object[] result = new Object[2];
            findDay(startDate).findNextDayPartStart(0, startDate, result);
            startDate = (Date) result[0];
            dayPart = (org.jbpm.pvm.internal.cal.DayPart) result[1];
    	}
    	
		
    	
    	org.jbpm.pvm.internal.cal.DayPart endDayPart = findDayPart(endDate);
    	if (!endDayPart) {
    		// find the daypart for the end date 
    		Object[] result = new Object[2];
            findDay(endDate).findNextDayPartStart(0, endDate, result);
            endDate = (Date) result[0];
            endDayPart = (org.jbpm.pvm.internal.cal.DayPart) result[1];
    	}
    	
    	long duration=endDate.getTime()-startDate.getTime()

    	def runningDate = dayPart.add(startDate, duration, true);
    	
    	// Nice start value, should always be too large.
    	
    	long step=duration/2
    	
    	while ((runningDate!=endDate) && (step>0)){    		
    		if (runningDate>endDate) {
    			duration=duration-step
    		} else {
    			duration=duration+step
    		}    		

    		runningDate = dayPart.add(startDate, duration, true);
    		step=step/2
    	}
    	
    	log.debug "runningDate: ${runningDate} endDate: ${endDate} duration: ${duration}"	
    	return duration
      }
    
    Double businessDurationInDays(Date startDate, Date endDate) {
    	long millis=businessDuration(startDate,endDate)
    	BigDecimal days = millis.toBigDecimal()/businessDayInMillis.toBigDecimal()
    	log.debug "The businessDayInMillis.toBigDecimal() is ${businessDayInMillis.toBigDecimal()}"
    	log.debug "The duration is ${millis}"
    	return days.doubleValue()
    }
    
    
}