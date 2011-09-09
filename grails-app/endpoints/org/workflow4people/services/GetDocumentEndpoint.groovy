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

package org.workflow4people.services
import org.workflow4people.*;

/*
import org.jbpm.api.ProcessInstanceQuery;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.task.*;
import org.jbpm.pvm.internal.session.*;
import org.jbpm.api.*

import org.springframework.beans.factory.InitializingBean;
*/
import org.codehaus.groovy.grails.commons.ApplicationHolder
import groovy.xml.StreamingMarkupBuilder

/**
 * Get document Endpoint 
 * SOAP service that retrieves a document based on it's documentId or the taskId of a related task
 * If taskId is used as the search key, the taskId is echoed into the document's header so it is ready to submit a task result 
 * @author Joost Horward
 */
class GetDocumentEndpoint {

	
	def workflowService
	def sessionFactory
	
	def static namespace = "http://www.workflow4people.org/services"
	
	def documentService
	
	def invoke = { request ->
		Document.withTransaction {
			
			def hibSession = sessionFactory.currentSession
			
		log.debug "Processing GetDocument service request ${request.name()}"
		def documentId
		def taskId=""
		def task
		if (request.request.documentId.text().size()>0) {
		  documentId = request.request.documentId.text().asType(Long)
		} else {
		  taskId = request.request.taskId.text()
		  task=workflowService.getTask(taskId)
		  if (task.active) {
			  log.debug "Task active :)" 
			  task=hibSession.merge(task)		  	
			  documentId=task.workflow.document.id
		  } else {
			  log.debug "Task not active ... :("
			  throw new Exception("Task already completed")
		  }
		}
		def xmlDocument=documentService.getDocument(documentId)
		
		// Store task details in document header.
		xmlDocument.header.taskId=taskId
		if (taskId.length()>0 && xmlDocument.header.task) {
			xmlDocument.header.task.id=task.id
			xmlDocument.header.task.name=task.name
			xmlDocument.header.task.description=task.description
			xmlDocument.header.task.outcome=""
			xmlDocument.header.task.dueDate=task.dueDate.format('yyyy-MM-dd')			
			xmlDocument.header.task.priority=task.priority
			xmlDocument.header.task.assignee=task.assignee?.username
			xmlDocument.header.task.status=task.status
			xmlDocument.header.task.statusUser=task.statusUser
		}

		def response = { GetDocumentResponse(xmlns:namespace) {
			document(xmlDocument)
			}		
		}
		return response
		}
    }
}