package org.workflow4people.services

import org.apache.commons.httpclient.*
import org.apache.commons.httpclient.methods.*
import org.apache.commons.codec.*
import org.workflow4people.*

class SoapService {

    boolean transactional = true
    
    /*
     * Call a SOAP service with a text format request, return text response
     */

    def textCall(String endpoint,soapRequest) {
    			
    		def url=ApplicationConfiguration.findByConfigKey('soap.endpoint.'+endpoint).configValue
    		
    		def method = new PostMethod(url)

    		def client = new HttpClient()

    		soapRequest = soapRequest.trim()
    		method.addRequestHeader("Content-Type","text/xml")
    		method.addRequestHeader("Accept","text/xml,application/xml;q=0.9")
    		method.setRequestEntity(new StringRequestEntity(soapRequest))
    		def statusCode = client.executeMethod(method)
    		println "STATUS CODE : ${statusCode}"
    		def resultsString = method.getResponseBodyAsString()
            if (statusCode != HttpStatus.SC_OK) {
                println "An error occurred in the returned SOAP message! (maybe a SOAPFault?)"
                throw new Exception("An error occurred in the returned SOAP message! (maybe a SOAPFault?)")
            }
    		method.releaseConnection()
    		//println resultsString
    		return resultsString    	
    }
       
}
