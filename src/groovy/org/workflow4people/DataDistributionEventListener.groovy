package org.workflow4people
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

import org.hibernate.event.*
import org.apache.commons.logging.LogFactory
import grails.plugin.jms.*
import org.apache.activemq.Message
import org.apache.activemq.ScheduledMessage
/*
 * Event listener for Hibernate events in the Grails domain objects
 * @author Joost Horward
 */

class DataDistributionEventListener implements PostUpdateEventListener,PostInsertEventListener{
	def jmsService
	def documentService
	private static final log = LogFactory.getLog(this)
	
	void onPostUpdate(PostUpdateEvent postUpdateEvent) {
		
		def entity=postUpdateEvent.getEntity()		
		log.debug "onPostUpdate - entity: ${entity.class.name} id: ${entity.id}"
		
		if (entity instanceof org.workflow4people.Document) {	    
			String queueName="wfp.dds.out.document.update"    		  
    		jmsService.send(queueName,[id:entity.id,document:documentService.getDocument(entity.id)]) { 
				Message msg ->
				msg.setProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY,5000)
			}
		

			
			
			log.debug "onPostUpdate completed - entity: ${entity.class.name} id: ${entity.id}"
	    }
	
	  }
	
	void onPostInsert(PostInsertEvent postInsertEvent) {

		def entity=postInsertEvent.getEntity()
		log.debug "onPostInsert - entity: ${entity.class.name} id: ${entity.id}"
		
	    if (entity instanceof org.workflow4people.Document) {
			String queueName="wfp.dds.out.document.new"
			jmsService.send(queueName,[id:entity.id,document:documentService.getDocument(entity.id)]) { 
				Message msg ->
				msg.setProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY,5000)
			}			
			log.debug "onPostInsert completed - entity: ${entity.class.name} id: ${entity.id}"
			
	    }
	
	}
	
	
	void onPostDelete(PostDeleteEvent postDeleteEvent) {
		def entity=postDeleteEvent.getEntity()
		log.debug "onPostDelete - entity: ${entity.class.name} id: ${entity.id}"
		
		if (entity instanceof org.workflow4people.Document) {
			String queueName="wfp.dds.out.workflow.delete"
    		jmsService.send(queueName,[id:entity.id	]) { 
				Message msg ->
				msg.setProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY,5000)
			}
			log.debug "onPostDelete completed - entity: ${entity.class.name} id: ${entity.id}"
			
	    }
		
	  }
}
