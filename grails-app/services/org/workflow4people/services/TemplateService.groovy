/*
 * Copyright 2009-2010, Open-T B.V., and individual contributors as indicated
 * by the @author tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License
 * version 3 published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.

 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses
 */

package org.workflow4people.services
import org.workflow4people.*;
import org.springframework.context.ApplicationContextAware
import org.springframework.context.ApplicationContext
import org.codehaus.groovy.grails.web.context.ServletContextHolder as SCH
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.context.support.WebApplicationContextUtils
import grails.util.GrailsWebUtil


import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateEngine
import groovy.text.*;
import org.springframework.web.context.request.RequestContextHolder


public class TemplateService implements  ApplicationContextAware {
    	
    def applicationContext
    
	def wf4pConfigService
	def backgroundService
	def templateConfigDelegate
	GroovyPagesTemplateEngine groovyPagesTemplateEngine
	

    def sessionFactoryBean
    def sessionFactory
    def globalModel
    
    //static scope="session"

    void setApplicationContext(ApplicationContext inApplicationContext){
        applicationContext = inApplicationContext
        sessionFactoryBean = applicationContext.getBean('&sessionFactory')  
    }
    

    

	def servletContext = SCH.servletContext
	
    boolean transactional = false
    
    
    String runTemplate(String filename,model) {
		
		// This is a bit of a hack. We store the model in the TemplateService singleton so that subsequent runSnippetTemplate calls can re-use the model.
		// Obviously, the consequence is that only one template generation process can run at any given time. 
		// One would expect simply to make this service session-scoped, but that doesn't work, probably because of the background thread that it's running in.
				
		globalModel=model
		def gspFile=new File(filename)
    	
    	groovyPagesTemplateEngine.setApplicationContext(applicationContext)
    	groovyPagesTemplateEngine.setServletContext(servletContext)
    	groovyPagesTemplateEngine.setClassLoader(applicationContext.getClassLoader())
    	
    	Template t = groovyPagesTemplateEngine.createTemplate(gspFile)
    	StringWriter writer = new StringWriter();
                      
  	    t.make(model).writeTo(writer)
  	    def s= writer.toString()
  	    
		
		return s
	
	}
	
	String runSnippetTemplate(def object,def snippetType,def extraModel=[:]) {		
		String className=object.class.name.substring(object.class.name.lastIndexOf('.')+1)
		log.debug "running snippet for ${className}"
    	def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue
    	
    	def baseType
    	def fieldType=null
    	if (object.class==org.workflow4people.Field) {
    		baseType=object.fieldType.baseType
    		fieldType=object.fieldType
    	}
		
		if (object.class==org.workflow4people.FormItem) {			
			baseType=object.field.fieldType.baseType
    		fieldType=object.field.fieldType		
		}
		
		if (object.class==org.workflow4people.FieldType) {
    		baseType=object.baseType
    		fieldType=object
    	}
		
		if (object.class==org.workflow4people.FieldList) {
    		baseType=object.baseType    		
    	}
		
		
		def model=[:]+globalModel+extraModel		
   		model+=object.binding().getVariables()
		
		def snippetPath
		if(fieldType) {
			snippetPath=templatePath+'/snippets/FieldType/'+fieldType.name+'/'+snippetType+'.gsp'
			if (!new File(snippetPath).exists()) {
				snippetPath=templatePath+'/snippets/BaseType/'+baseType.name+'/'+snippetType+'.gsp'
			}
		} else {
			snippetPath=templatePath+'/snippets/BaseType/'+baseType.name+'/'+snippetType+'.gsp'
		}
		
		log.debug "The snippet path is: ${snippetPath}"
		
		return runTemplate(snippetPath,model)
	}
	
	String runGenericSnippetTemplate(String templateType,def snippetType,def extraModel=[:]) {		
		
		log.debug "running common snippet for type ${templateType}"
    	def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue
    	
		def model=[:]+globalModel+extraModel		
   		
		def	snippetPath=templatePath+'/snippets/'+templateType+'/'+snippetType+'.gsp'
		
		log.debug "The snippet path is: ${snippetPath}"
		
		return runTemplate(snippetPath,model)
	}
	
	
	
	 def generate(def workflowDefinitionId) {			
  		def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue;
  	  	if (templatePath.charAt(templatePath.length()-1)!='/') {
		  templatePath+='/'
  	  	}
  	  	
    	def outputPath=ApplicationConfiguration.findByConfigKey('template.outputPath').configValue;  	  	
  	  	def templateText=new File(templatePath+"template.conf").text
  	  	
  	  	backgroundService.execute("Generating forms ...", {
  	  		
  	        def servletContext2  = ServletContextHolder.getServletContext()
  	        def applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext2)
  	        def requestAttributes = GrailsWebUtil.bindMockWebRequest(applicationContext)
  	        
  	        def servletContext = requestAttributes.request.servletContext
  	        def request = requestAttributes.request
  	  			  	  		
			def workflowDefinitionInstance = WorkflowDefinition.get( workflowDefinitionId )

  	  		templateConfigDelegate = new TemplateConfigDelegate(this,workflowDefinitionInstance,templatePath,outputPath)
  	  	
  	  		def template=new GroovyShell().evaluate(templateText)

  	  		log.debug "Generating forms package ..."
  	  		template.delegate=templateConfigDelegate
  	  		try {
  	  			template()
  	  			templateConfigDelegate.msg "Processing completed"
  	  			templateConfigDelegate.total=100
  	  			templateConfigDelegate.current=100	  	       
  	  			templateConfigDelegate.completed=true
  	  		} catch (Exception e) {
  	  			templateConfigDelegate.msg "An error has occurred"
  	  			templateConfigDelegate.mlog e.message
  	  		}
  	        
	  	  	
  	  	});
     }
	
	 
	 def getProgress() {
		 
			return templateConfigDelegate?.progress
		 
		}
		
	
    

}

