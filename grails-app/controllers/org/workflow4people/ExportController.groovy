package org.workflow4people
import org.workflow4people.services.*
import groovy.xml.StreamingMarkupBuilder

import grails.converters.*
class ExportController {
	def importExportService
    def index = {
		
		def field=Field.get(442)
		def form=Form.get(15)
		//def field=Field.get(1)
		
		def response = importExportService.domainObjectToXml(form)
		//render response as XML
		//render(contentType:"text/xml") { response }
		//render { response }
		
		StreamingMarkupBuilder outputBuilder = new StreamingMarkupBuilder()
		def xmlDocument= outputBuilder.bind(response)
		
		/*
		render {
			div(id:"myDiv", "some text inside the div")
		}
		*/
		[xmlDocument:xmlDocument]
		
		//render form as XML
		//render form as XML
	}
	
}
