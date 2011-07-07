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


/**
 * <h3>Store document Endpoint</h3> 
 * SOAP service that stores a document
 * Automatically starts a workflow and assigns a documentId or handles a task as required
 * If the documentId is empty or missing, a new Id is assigned and a new workflow is started
 * If a task outcome is present, the given task is handled.
 * If no task outcome is present but a documentId is present, the document is simply stored.
 * @author Joost Horward
 */
class DocumentQueryEndpoint  {

	TaskService taskService
	ExecutionService executionService
	RepositoryService repositoryService

	def static namespace = "http://www.workflow4people.org/services"
	
	def documentService
	
	def invoke = { request ->
		log.debug("Processing DocumentQuery service request ${request.name()}")

		def outputBuilder = new StreamingMarkupBuilder()
				
		def query = request.request.documentQuery.query.text()
		def queryType = request.request.documentQuery.queryType.text()
		def querySort = request.request.documentQuery.sort.text()

		def queryOrder = request.request.documentQuery.order.text()
		
		def userName=request.request.documentQuery.user.text()
		boolean userDocumentsOnly=request.request.documentQuery.userDocumentsOnly.text()!="false"
		boolean groupDocumentsOnly=request.request.documentQuery.groupDocumentsOnly.text()!="false"
		int currentPage=1
		
		int maxPageLength=100
		if (request.request.documentQuery.paginate.size()>0) {
			currentPage=request.request.documentQuery.paginate.page.text().asType(Integer)
			maxPageLength=request.request.documentQuery.paginate.max.text().asType(Integer)
		}


		                 
		def documentHeaders
		int theSize=0
		int theTotalPages=0
		switch (queryType) {
			case "all":
				query=""
				// yes, that's right. No break. All is just another type of Lucene query now
			case "lucene":
				if (!querySort) querySort="SCORE"
				if (!queryOrder) queryOrder="auto"	
				def queryParams=['offset':(currentPage-1)*maxPageLength,'max':maxPageLength,'sort':querySort,'order':queryOrder,'analyzer':'wfp']
				
				def queryResult=documentService.luceneSearch(query,queryParams,userName,userDocumentsOnly,groupDocumentsOnly);
				theSize=queryResult.total
				theTotalPages=((theSize -1)/ maxPageLength) +1				
				
				documentHeaders = queryResult.results.collect {
		    		try {		    		  
		    		  documentService.getDocument(it.id).header
		    		} catch (Exception e) {
		    			""
		    		}	
		    	}				
				break
		}				
		
		def response = { DocumentQueryResponse(xmlns:namespace) 
			{
				documentList {
				  paginateResult {
					  page(currentPage)
					  totalPages(theTotalPages)
					  totalResults(theSize)					  
				  }
				  headers {
					  documentHeaders.each { 
					  	out << it 
					  }
				  }				
				}
			}		
		}
		return response
    }
}
