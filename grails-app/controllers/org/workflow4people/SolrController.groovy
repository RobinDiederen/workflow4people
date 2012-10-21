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
	// Goed startpunt: 9790100000000
	def submitReIndex = { ReIndexDialog dialog ->
		runAsync {
			solrService.reIndexAll(dialog.startIsbn)
		}
		//def res =[result:['success':true,message:"Reindex vanaf ISBN ${dialog.startIsbn} van maximaal ${dialog.limit} boeken gestart"]]

		//render  res as JSON
		redirect(action:'status')
		
	}
	
	
	
	def reindexBooks = {
		println "Reindexing books ..."
		//Book.unindex()
		//Book.reindex()
		runAsync {
			solrService.reIndexAll("9790100000000")
		}
		//searchIndexService.reIndex(Book)
		//render (view:'done')
		render(view:'status')
	}
	
	def status() {
		//Show progress bar
		solrService.updateStats()
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
	
	
}
