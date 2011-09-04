/*

 * Workflow4people
 * Copyright 2009-2011, Open-T B.V., and individual contributors as indicated
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

package org.workflow4people;
import org.hibernate.event.*
import org.apache.commons.logging.LogFactory
import grails.plugin.jms.*
/*
 * Event listener for Hibernate events in the Grails domain objects
 * @author Joost Horward
 */

class EventListener implements PostUpdateEventListener,PostInsertEventListener{
	def jmsService
	private static final log = LogFactory.getLog(this)
	
	void onPostUpdate(PostUpdateEvent postUpdateEvent) {
		def entity=postUpdateEvent.getEntity()
	    
		if (entity instanceof org.workflow4people.Workflow && !entity.noMessage) {	    
	      if (!entity.noMessage) {
	    	  def engineName=entity.workflowEngine.name
	    	  String queueName="wfp.${engineName}.out.workflow.update"    		  
    		  jmsService.send(queueName,[id:entity.id])    		  
	      }
	    }
		
		if (entity instanceof org.workflow4people.Task && !entity.noMessage) {		
		      if (!entity.noMessage) {
		    	  def engineName=entity.workflow.workflowEngine.name
		    	  String queueName="wfp.${engineName}.out.task.update"
	    		  jmsService.send(queueName,[id:entity.id])
		      }
	    }
		
	  }
	
	
	
	
	void onPostInsert(PostInsertEvent postInsertEvent) {

		def entity=postInsertEvent.getEntity()
	    if (entity instanceof org.workflow4people.Workflow && !entity.noMessage) {
	      if (!entity.noMessage) {
	    	  def engineName=entity.workflowEngine.name
	    	  String queueName="wfp.${engineName}.out.workflow.new"
    		  jmsService.send(queueName,[id:entity.id])
	      }
	    }
		if (entity instanceof org.workflow4people.Task && !entity.noMessage) {
		      if (!entity.noMessage) {
		    	  def engineName=entity.workflow.workflowEngine.name
		    	  String queueName="wfp.${engineName}.out.task.new"
	    		  jmsService.send(queueName,[id:entity.id])
		      }
		    }
		log.debug "EventListener: INSERT EVENT v3"
	}
	
	
	void onPostDelete(PostDeleteEvent postDeleteEvent) {
		def entity=postDeleteEvent.getEntity()
	    
		if (entity instanceof org.workflow4people.Workflow && !entity.noMessage) {
	      if (!entity.noMessage) {
	    	  def engineName=entity.workflowEngine.name
	    	  String queueName="wfp.${engineName}.out.workflow.delete"
    		  jmsService.send(queueName,[id:entity.id])
	      }
	    }
		
		if (entity instanceof org.workflow4people.Task && !entity.noMessage) {
		      log.debug "EventListener: DELETE WFP TASK EVENT"
		      if (!entity.noMessage) {
		    	  def engineName=entity.workflow.workflowEngine.name
		    	  String queueName="wfp.${engineName}.out.task.delete"
	    		  jmsService.send(queueName,[id:entity.id])
		      }
	    }
		
	  }
	
}
