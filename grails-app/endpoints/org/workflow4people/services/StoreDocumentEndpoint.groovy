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

import org.jbpm.api.ProcessInstanceQuery;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.task.*;
import org.jbpm.pvm.internal.session.*;
import org.jbpm.api.*
import org.codehaus.groovy.grails.commons.ApplicationHolder
import groovy.xml.StreamingMarkupBuilder
import java.util.Date;

import org.springframework.beans.factory.InitializingBean;

/**
 * Store document Endpoint 
 * SOAP service that stores a document
 * Automatically starts a workflow and assigns a documentId or handles a task as required
 * If the documentId is empty or missing, a new Id is assigned and a new workflow is started
 * If a task outcome is present, the given task is handled.
 * If no task outcome is present but a documentId is present, the document is simply stored.
 * @author Joost Horward
 */
class StoreDocumentEndpoint implements InitializingBean {
    def processEngine
	TaskService taskService
	ExecutionService executionService
	RepositoryService repositoryService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		repositoryService=processEngine.getRepositoryService()
		taskService=processEngine.getTaskService()
	}
	

	def static namespace = "http://www.workflow4people.org/services"
	
	def documentService
	
	def invoke = { request ->
		log.debug("Processing StoreDocument service request ${request.name()}")

		def outputBuilder = new StreamingMarkupBuilder()
				
		def document= request.request.document.children()[0]		                                                  
		
		def id=documentService.storeDocument(document) 
		def response = { StoreDocumentResponse(xmlns:namespace) 
			{
				documentId(id)
			}		
		}
		return response
    }
}
