package org.workflow4people.services

import java.security.*
import org.workflow4people.*

class ApiService {
	def grailsApplication
	/*
	 * generate REST service for domain class
	 * Conventions:
	 * GET /book/id    			-> get one  
	 * GET /book       			-> get list (respect params for paging)
	 * GET /book?q=				-> search (respect params for paging)
	 * GET /book?function=func	-> execute func()
	 * PUT /book/id    			-> update book
	 * 
	 * TODO:
	 * POST /book      -> create new book
	 * DELETE /book/id -> delete book
	 * 
	 */
    def rest(dc,params,request,key="id",searchquery=null,queryParams=[:]) {
		// Check for correct API key. If not, bail out.
		def apikey=grailsApplication.config.wfp.apikey		
		if (params.apikey!=apikey) {
			log.debug "bad API key: ${params.apikey}"
			return []
		}
		if (params.key) {
			key=params.key
		}
		
		log.debug "REST method ${request.method} - dc:${dc.name} params:${params}"
		def obj
		try {
			switch (request.method) {
				case "GET":
					if(params.id && params.id!=""){
						if (key=="id") {
							obj=dc.get(params.id)
						} else {
							obj=dc.find("from ${dc.name} where ${key}=:id",[id:params.id])
						}
						
					} else {
						if (searchquery) {
							def items=dc.findAll(searchquery,queryParams,params)
							def count=dc.executeQuery("select count(*) as cnt ${searchquery}",queryParams,[:])[0]
							obj=[items:items,count:count]							
						} else if (params.function && params.function!=""){
							obj=dc."${params.function}"(params)
						} else {
							def items=dc.findAll(params)
							def count=dc.count()
							obj=[items:items,count:count]
						}
					}
					return obj?obj:[]				
				break
			case "PUT":
				if(params.id && params.id!=""){
					if (key=="id") {
						obj=dc.get(params.id)
					} else {
						obj=dc.find("from ${dc.name} where ${key}=:id",[id:params.id])
					}
					log.debug "Saving in obj ${obj.id} JSON: ${request.JSON}"
					obj.properties=request.JSON
					obj.save(flush:true,failOnError:true)
					
				} 
				return obj?obj:[]
			break
			
			}
		} catch(Exception e) {
			if(grailsApplication.config.bookstore.debug) {
				return e
			} else {
				return []
			}
		} 
    }
	
	def verifyApiKey(params) {
		def apikey=grailsApplication.config.wfp.apikey
		if (params.apikey!=apikey) {
			log.debug "bad API key: ${params.apikey}"
			return false
		}
		return true
	}
	
	
	/**
	* Converteer byte array naar hexadecimale string
	* @param byteArray
	* @return hexadecimale string
	*/
	
	def byteToHex(byteArray) {
		String hexString=""
		byteArray.eachByte { b ->
				hexString+=String.format("%02X",b)
		}
		return hexString
	}

	
	def encodePassword(password) {
		byte[] bytesOfMessage = password.getBytes("UTF-8");
		
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] thedigest = md.digest(bytesOfMessage);
		return byteToHex(thedigest)
	}
	
	def newTicket() {
		def random=new Random()
		def chars='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
		def ticket =""
		for (i in 1..32) {
				def digit=random.nextInt(chars.length());
				ticket+=chars[digit]
				}
		return ticket
	}
	
}
