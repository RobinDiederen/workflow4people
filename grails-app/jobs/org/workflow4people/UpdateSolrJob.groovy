package org.workflow4people
import  org.workflow4people.services.*
class UpdateSolrJob {
	def solrService
    def timeout = 5000l // execute job once in 5 seconds

    def execute() {
		solrService.reIndexByLastUpdated(Document)
		solrService.reIndexByLastUpdated(Task)
    }
}
