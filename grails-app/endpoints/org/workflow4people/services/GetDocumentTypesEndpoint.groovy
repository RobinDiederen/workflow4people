package org.workflow4people.services

import org.workflow4people.*

class GetDocumentTypesEndpoint {
  
	def static namespace = "http://www.workflow4people.org/services" 
	
	def invoke = { request ->
    log.debug("Processing GetDocumentTypes service request")
		
		def documentTypeIds = []
		
		def workflowDefinitions = WorkflowDefinition.findAllByPublish(true)
		workflowDefinitions.each { workflowDefinition ->
		  documentTypeIds.add(workflowDefinition.documentType.id)
		}
		
		def documentTypeList = DocumentType.withCriteria {
		  'in'('id', documentTypeIds)
      order('description', 'asc')
		}
		
		def response = 
		  {
		    GetDocumentTypesResponse(xmlns: namespace) {
		      documentTypes {
    	      documentTypeList.each { aDocumentType -> 
    				  documentType {
    					  name aDocumentType.name
							  description aDocumentType.description
						  }
					  }
					}
				}
			}
      
    return response
  }
  
}
