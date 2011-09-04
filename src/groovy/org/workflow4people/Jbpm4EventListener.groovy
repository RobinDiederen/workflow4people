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
import grails.plugin.jms.*
import org.workflow4people.SpringUtil;
import org.apache.commons.logging.LogFactory

/*
 * Event listener for Hibernate events in the JBPM domain objects
 * @author Joost Horward
 */
public class Jbpm4EventListener implements PostUpdateEventListener,PostInsertEventListener,PostDeleteEventListener{
	def jmsService
	private static final log = LogFactory.getLog(this)
	

	void onPostUpdate(PostUpdateEvent postUpdateEvent) {
		log.debug "Jbpm4EventListener: UPDATE EVENT (${postUpdateEvent.getEntity()})"		
		def entity=postUpdateEvent.getEntity()
		if (entity instanceof org.jbpm.pvm.internal.model.ExecutionImpl) {
			SpringUtil.getBean("jmsService").send("wfp.jbpm4.in.workflow.update",[id:entity.getId()])
		} 
		else if (entity instanceof org.jbpm.pvm.internal.task.TaskImpl) {
			SpringUtil.getBean("jmsService").send("wfp.jbpm4.in.task.update",[id:entity.getId()])			
		}
	  }
	
	void onPostInsert(PostInsertEvent postInsertEvent) {
		log.debug "Jbpm4EventListener: INSERT EVENT (${postInsertEvent.getEntity()} ${postInsertEvent.getEntity().getClass().getName()})"
		def entity=postInsertEvent.getEntity()
		if (entity instanceof org.jbpm.pvm.internal.model.ExecutionImpl) {
			SpringUtil.getBean("jmsService").send("wfp.jbpm4.in.workflow.new",[id:entity.getId()])
		} 
		else if (entity instanceof org.jbpm.pvm.internal.task.TaskImpl) {
			SpringUtil.getBean("jmsService").send("wfp.jbpm4.in.task.new",[id:entity.getId()])			
		}
		
	  }
	
	void onPostDelete(PostDeleteEvent postDeleteEvent) {
		log.debug "Jbpm4EventListener: DELETE EVENT (${postDeleteEvent.getEntity()})"		
		def entity=postDeleteEvent.getEntity()
		if (entity instanceof org.jbpm.pvm.internal.model.ExecutionImpl) {
			SpringUtil.getBean("jmsService").send("wfp.jbpm4.in.workflow.delete",[id:entity.getId()])
		} 
		else if (entity instanceof org.jbpm.pvm.internal.task.TaskImpl) {
			SpringUtil.getBean("jmsService").send("wfp.jbpm4.in.task.delete",[id:entity.getId()])			
		}
	  }
	
	
}
