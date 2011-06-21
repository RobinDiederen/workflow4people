package org.workflow4people.services
import org.codehaus.groovy.grails.commons.* 
import javax.xml.transform.*;
import javax.xml.transform.stream.*;

class DialogService {

	def grailsApplication
	def sessionFactory
	
    boolean transactional = true
      
    def edit(domainClass,params) {
		def domainClassInstance
		if (params.id && params.id !='null') {
		    if (params.id.contains("_")){
				params.id=params.id.split("_")[1]
		    }
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
    	
	def submit(domainClass,params,instance=null) {
			def g=grailsApplication.mainContext.getBean('org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib')
			def defaultDomainClass = new DefaultGrailsDomainClass( domainClass )
			def domainPropertyName=defaultDomainClass.propertyName		
			def domainClassName=defaultDomainClass.getName()
		
    		def id=params.id
    		def domainClassInstance
    		if (instance) {
    			domainClassInstance=instance
    		} else {
	    		if (params.id && params.id != 'null') {
	    		    if (params.id.contains("_")){
	    					params.id=params.id.split("_")[1]
	    			}
	    			domainClassInstance = domainClass.get(params.id )
	    		} else 
	    		{
	    			domainClassInstance = domainClass.newInstance()
	    		}
	    		domainClassInstance.properties = params
    		}
			
            def theRefreshNodes=null
            
            def successFlag=!domainClassInstance.hasErrors() && domainClassInstance.save(flush: true)
            
            def resultMessage
            def theErrorFields=[]
            if (successFlag) {
            	domainClassInstance.save(flush: true)
            
            	 def session = sessionFactory.getCurrentSession()
            	session.flush()
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
        def theName = domainClassInstance.toString()
        try { 
        	domainClassInstance.delete()
        	resultMessage="${domainClassName} #${params.id} : ${theName} deleted"
        	
        } catch (Exception e ){
        	successFlag=false
        	resultMessage="${domainClassName} #${params.id} : ${theName} not deleted"
        }
		
		
        def theErrorFields=[]
                             
		def result = [
		              	success:successFlag,
		              	message:resultMessage ,
		              	id:params.id,
		              	name: theName,	
		              	refreshNodes:theRefreshNodes,
		              	errorFields:theErrorFields
		              ]              
         def res=[result:result]
         return res    		
	}

	def prettyPrint(String inputXml) {
	     Source xmlInput = new StreamSource(new StringReader(inputXml));
	     StreamResult xmlOutput = new StreamResult(new StringWriter());

	      // Configure transformer
	     Transformer transformer = TransformerFactory.newInstance().newTransformer(); // An identity transformer
	     
	     transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	     transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
	     transformer.transform(xmlInput, xmlOutput);
	     return xmlOutput.getWriter().toString()
	    	     
	}

}
