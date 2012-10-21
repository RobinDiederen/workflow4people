package org.workflow4people
import  org.workflow4people.services.*
class UpdateSolrJob {
	def solrService
    def timeout = 60000l // execute job once in 60 seconds

    def execute() {
		solrService.reIndexByLastUpdated(Document)
    }
}
