package org.workflow4people

import grails.converters.JSON
import org.workflow4people.services.*


class ApiController {

	def apiService
	def grailsApplication
	def solrService
	
	def beforeInterceptor = {
		if (!apiService.verifyApiKey(params)) {
			return false
		}
	}
	
	def error() {
		def json=[]
		render json as JSON
	}
	
	def document() {
		grails.converters.JSON.use("deep")
		def json=apiService.rest(Document,params,request)		
		render json as grails.converters.JSON
	}
	
}
