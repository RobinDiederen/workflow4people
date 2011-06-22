package org.workflow4people.services
import org.codehaus.groovy.grails.commons.* 

class DialogService {

	def grailsApplication
	
    boolean transactional = true
      
    def edit(domainClass,params) {
		def domainClassInstance
		if (params.id && params.id !='null') {
			domainClassInstance = domainClass.get(params.id)
		} else {
			domainClassInstance = domainClass.newInstance()			
		}
		
        def defaultDomainClass = new DefaultGrailsDomainClass( domainClass )
		def domainPropertyName=defaultDomainClass.propertyName		
        def domainClassName=defaultDomainClass.getName()
        if (!domainClassInstance) {
            flash.message = "${domainPropertyName}.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "${domainClassName} not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
        	def returnMap=[:]
        	String key="${domainPropertyName}Instance"
        	returnMap.put(key,domainClassInstance)
            return returnMap
        }
    }
    	
	def submit(domainClass,params) {
			def g=grailsApplication.mainContext.getBean('org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib')
			def defaultDomainClass = new DefaultGrailsDomainClass( domainClass )
			def domainPropertyName=defaultDomainClass.propertyName		
			def domainClassName=defaultDomainClass.getName()
		
    		def id=params.id
    		def domainClassInstance
    		if (params.id && params.id != 'null') {
    			domainClassInstance = domainClass.get(params.id )
    		} else 
    		{
    			domainClassInstance = domainClass.newInstance()
    		}
    		domainClassInstance.properties = params
            
            def theRefreshNodes=null
            def successFlag=!domainClassInstance.hasErrors() && domainClassInstance.save(flush: true)
            def resultMessage
            def theErrorFields=[]
            if (successFlag) {
            	domainClassInstance.save(flush: true)
            	resultMessage="${domainClassName} #${params.id} : ${domainClassInstance.toString()} updated" 
            } else {
            	g.eachError(bean:domainClassInstance) {        		
            		theErrorFields+=it.field
            	}
            	resultMessage=g.renderErrors(bean:domainClassInstance)
            }
    		                     
    		def result = [
    		              	success:successFlag,
    		              	message:resultMessage ,
    		              	id:params.id,
    		              	name: domainClassInstance.toString(),	
    		              	refreshNodes:theRefreshNodes,
    		              	errorFields:theErrorFields
    		              ]              
             def res=[result:result]
             return res    		
    	}
	
	def delete(domainClass,params) {
		def g=grailsApplication.mainContext.getBean('org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib')
		def defaultDomainClass = new DefaultGrailsDomainClass( domainClass )
		def domainPropertyName=defaultDomainClass.propertyName		
		def domainClassName=defaultDomainClass.getName()
	
		def id=params.id
		def domainClassInstance = domainClass.get(params.id )
		domainClassInstance.properties = params
        
        def theRefreshNodes=null
        def successFlag=true
        def resultMessage
        try { 
        	domainClassInstance.delete()
        	resultMessage="${domainClassName} #${params.id} : ${domainClassInstance} deleted"
        	
        } catch (Exception e ){
        	successFlag=false
        	resultMessage="${domainClassName} #${params.id} : ${domainClassInstance} not deleted"
        }
		
		
        def theErrorFields=[]
                             
		def result = [
		              	success:successFlag,
		              	message:resultMessage ,
		              	id:params.id,
		              	name: domainClassInstance,	
		              	refreshNodes:theRefreshNodes,
		              	errorFields:theErrorFields
		              ]              
         def res=[result:result]
         return res    		
	}

	

}
