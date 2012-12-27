package org.workflow4people
import grails.plugins.springsecurity.Secured

import grails.converters.JSON
import grails.converters.*
import org.workflow4people.services.*


@Secured(['ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_ADMIN','ROLE_WF4P_DEVELOPER'])
class SolrController {
	
	def searchableService
	def sessionFactory
	def executorService
	def solrService
	

    def index() { }
	
	
	def reIndex = {
		[dialog:new ReIndexDialog()]
	}
	//
	def submitReIndex = { ReIndexDialog dialog ->
		runAsync {
			if (dialog.itemType=="Document") {
				solrService.reIndexAll(Document,dialog.startId)
			}
			if (dialog.itemType=="Task") {
				solrService.reIndexAll(Task,dialog.startId)
			}
		}

		redirect(action:'status')
		
	}
	
	
	def status() {
		//Show progress bar
		solrService.updateStats(Document)
		render(view:'status')
	}
	
	def progress() {
		//Get total & current record
		def progressMap = solrService.progress
				
		//Calculate percentage
		int percentage = 0
		if (progressMap.total > 0) {
			percentage = (progressMap.current / progressMap.total) * 100
		}
		progressMap.put("percentage", percentage)
		
		//The JSON-data is used/requested by the importCovers view (Progress bar)
		render progressMap as JSON
	}
	
	def abort() {
		//Abort import
		println "ABORT"
		solrService.abort()
		def res=[]
		render res as JSON
	}
	
	def overview ={
		def taskStats=solrService.getStats(Task)
		def documentStats=solrService.getStats(Document)
		[taskStats:taskStats,documentStats:documentStats]
	}
	
}
