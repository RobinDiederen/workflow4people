package org.workflow4people.services
import org.workflow4people.*;

class FormGeneratorService {
	static scope="session"
	def templateService
	def templateConfigDelegate
	def backgroundService
	def sessionFactory
    
    boolean transactional = false

    def generate(def workflowDefinitionId) {
		def workflowDefinitionInstance = WorkflowDefinition.get( workflowDefinitionId )
		
  	  	def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue;
  	  	if (templatePath.charAt(templatePath.length()-1)!='/') {
		  templatePath+='/'
  	  	}
  	  	
    	def outputPath=ApplicationConfiguration.findByConfigKey('template.outputPath').configValue;  	  	
  	  	def templateText=new File(templatePath+"template.conf").text
  	    //templateConfigDelegate = new TemplateConfigDelegate(templateService,workflowDefinitionInstance,templatePath,outputPath)
  	  	
  	  	//def template=new GroovyShell().evaluate(templateText)

  	  	//log.debug "Generating forms package ..."
  	  	//template.delegate=templateConfigDelegate
  	  	
  	  	backgroundService.execute("Generating forms ...", {
  	  		  	  		
  	  		templateConfigDelegate = new TemplateConfigDelegate(templateService,workflowDefinitionInstance,templatePath,outputPath)
  	  	
  	  		def template=new GroovyShell().evaluate(templateText)

  	  		log.debug "Generating forms package ..."
  	  		template.delegate=templateConfigDelegate

  	  		
  	  		
  	  		
  	  		template()
  	  		
  	  	});
    	log.debug ("Done.")
        
  	 		 
		

    }
	
	def getProgress() {
		return templateConfigDelegate.progress
	}
	
	
	
	
}
