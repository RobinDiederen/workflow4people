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

import java.io.*;

import org.w3c.tidy.Tidy

public class TemplateService implements  ApplicationContextAware {
    	
    def applicationContext
    
	def wf4pConfigService
	def backgroundService
	def dialogService
	
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
		
		//globalModel=model
		def gspFile=new File(filename)
    	
    	groovyPagesTemplateEngine.setApplicationContext(applicationContext)
    	groovyPagesTemplateEngine.setServletContext(servletContext)
    	groovyPagesTemplateEngine.setClassLoader(applicationContext.getClassLoader())
    	
    	//TODO make this configurable
    	groovyPagesTemplateEngine.reloadEnabled=true
    	groovyPagesTemplateEngine.cacheResources=true
    	
    	
    	Template t = groovyPagesTemplateEngine.createTemplate(gspFile)
    	StringWriter writer = new StringWriter();
                      
  	    t.make(model).writeTo(writer)
  	    def s= writer.toString()
  	    
		return s
	
	}
	

	String runSnippetTemplate(def object,def snippetType,def extraModel=[:]) {		
		String className=object.class.name.substring(object.class.name.lastIndexOf('.')+1)
		log.debug "running snippet for ${className} ${object.toString()}"
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
		
			
		//def model=[:]+globalModel+extraModel
		def model=[:]+extraModel
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
		
		if (!new File(snippetPath).exists()) {
			snippetPath=templatePath+'/snippets/Default/'+snippetType+'.gsp'
		}
		dialogService.check(new File(snippetPath).exists(),"templateService.snippetnotfound",[snippetPath])
		
		log.debug "The snippet path is: ${snippetPath}"
		
		return runTemplate(snippetPath,model)
	}
	
	String runGenericSnippetTemplate(String templateType,def snippetType,def extraModel=[:]) {		
		
		log.debug "running common snippet for type ${templateType}"
    	def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue
    	
		//def model=[:]+globalModel+extraModel		
		def model=extraModel
		def	snippetPath=templatePath+'/snippets/'+templateType+'/'+snippetType+'.gsp'
		
		log.debug "The snippet path is: ${snippetPath}"
		
		return runTemplate(snippetPath,model)
	}
	
	
	
	 def generate(def workflowDefinitionId,params=[:]) {
		 
		groovyPagesTemplateEngine.clearPageCache()
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

  	  		templateConfigDelegate = new TemplateConfigDelegate(this,workflowDefinitionInstance,templatePath,outputPath,params)
  	  	
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
				//String s=getStackTrace(e)
  	  			templateConfigDelegate.msg "An error has occurred: ${e.message}"
  	  			templateConfigDelegate.mlog e.message
  	  		}
  	        
	  	  	
  	  	});
     }
	 
	 def getFormTemplateNames(){
			def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue;
	  	  	if (templatePath.charAt(templatePath.length()-1)!='/') {
			  templatePath+='/'
	  	  	}
	  	  	def dir = new File(templatePath+'form')
	  	  	def templateNames=[]
	  	  	dir.eachFile { file ->
	  	  		if (file.name.endsWith(".gsp")) {	  	  			
	  	  			templateNames+=file.name.replace(".gsp","")
	  	  		}
	  	  	}
	  	  	return templateNames?.sort()
	 }
	 
	 def getSnippetConfig(name){
		 def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue;
			 if (templatePath.charAt(templatePath.length()-1)!='/') {
		   templatePath+='/'
			 }
			 
			 def configPath = templatePath+'snippets/FieldType/'+name+"/snippet.conf"
			 def configFile=new File(configPath)
			 if (!configFile.exists()) {
				 configPath = templatePath+'snippets/BaseType/'+name+"/snippet.conf"
				 configFile=new File(configPath)
			 }
			 
			 if (configFile.exists()) {
			 	def config = new ConfigSlurper().parse(configFile.toURL())
				 return config
			 } else {
			 	return null
			 }
	 }
	 
	

	 def generateProcess(def workflowDefinitionId) {
		 
		 groovyPagesTemplateEngine.clearPageCache()
		 
	  		def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue;
	  	  	if (templatePath.charAt(templatePath.length()-1)!='/') {
			  templatePath+='/'
	  	  	}
	  	  	
	    	def outputPath=ApplicationConfiguration.findByConfigKey('process.template.outputPath').configValue;  	  	
	  	  	def templateText=new File(templatePath+"process-template.conf").text
	  	  	
	  	  	backgroundService.execute("Generating process ...", {
	  	  		
	  	        def servletContext2  = ServletContextHolder.getServletContext()
	  	        def applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext2)
	  	        def requestAttributes = GrailsWebUtil.bindMockWebRequest(applicationContext)
	  	        
	  	        def servletContext = requestAttributes.request.servletContext
	  	        def request = requestAttributes.request
	  	  			  	  		
				def workflowDefinitionInstance = WorkflowDefinition.get( workflowDefinitionId )

	  	  		templateConfigDelegate = new TemplateConfigDelegate(this,workflowDefinitionInstance,templatePath,outputPath)
	  	  	
	  	  		def template=new GroovyShell().evaluate(templateText)

	  	  		log.debug "Generating process ..."
	  	  		template.delegate=templateConfigDelegate
	  	  		try {
	  	  			template()
	  	  			templateConfigDelegate.msg "Processing completed"
	  	  			templateConfigDelegate.total=100
	  	  			templateConfigDelegate.current=100	  	       
	  	  			templateConfigDelegate.completed=true
	  	  		} catch (Exception e) {
	  	  			templateConfigDelegate.msg "An error has occurred: ${e.message}"
	  	  			templateConfigDelegate.mlog e.message
	  	  		}
	  	        
		  	  	
	  	  	});
	     }

	 
	 
	 
	 def getProgress() {
		 
			return templateConfigDelegate?.progress
		 
		}
	
	 def prettyPrint(String inputHTML) {
		 Tidy tidy = new Tidy();
         
         tidy.setXHTML(true);       
		 ByteArrayOutputStream xhtmlByteOutStream = new ByteArrayOutputStream();             
		 tidy.parse(new ByteArrayInputStream(inputHTML.getBytes()),xhtmlByteOutStream);
		 return xhtmlByteOutStream.toString()
		 
	}
	 String getStackTrace(Exception e) {
		 ByteArrayOutputStream os = new ByteArrayOutputStream();
		 PrintStream ps = new PrintStream(os);
		 e.printStackTrace(ps)
		 return os.toString("UTF8");
	 }
    

}

