/*

 * Workflow4people
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
package org.workflow4people
import org.workflow4people.services.*;

/**
 * Delegation class for form templates
 * This takes care of interpreting the template.conf DSL that is in the root of a template definition folder.
 *
 * @author Joost Horward
 */

class TemplateConfigDelegate
{
	WorkflowDefinition workflowDefinition
	String templatePath
	String outputPath
	TemplateService templateService
	def model=[]

  def TemplateConfigDelegate(TemplateService theTemplateService,WorkflowDefinition theWorkflowDefinition,String theTemplatePath,String theOutputPath) {
	  workflowDefinition=theWorkflowDefinition
	  templateService=theTemplateService
	  templatePath=theTemplatePath
	  if (templatePath.charAt(templatePath.length()-1)!='/') {
			  templatePath+='/'
	  }
	  outputPath=theOutputPath
	  if (outputPath.charAt(outputPath.length()-1)!='/') {
		  outputPath+='/'
	  }
  }
	
  def getName() {
	return "Default name"
  }

  def getWorkflowName() {
	return workflowDefinition.name
  }

/*  def getFormName() {
	return "Default form name"
  }
*/
  def getFieldTypeName() {
	return "Default type name"
  }

  def getNamespaceName() {
	return "Default namespace name"
  }
  
  def common(Closure closure) {
	  println "Processing common..."
	  model = [ 'workflowDefinitions' : WorkflowDefinition.findaAll() ]
	  closure.workflow=workflowDefinition
	  closure()
  }
  
  def workflow(Closure closure) {
	  println "Processing workflow..."
	  model = [ 'workflowDefinitionInstance' : workflowDefinition ]
	  closure.workflow=workflowDefinition
	  closure()
  }
  
  
  def form(Closure closure) {
	  println "Processing forms ..."
	      
	  workflowDefinition.form.each { form ->
  	  	println "Processing form ${form.name} ..."
  		closure.formName=form.name
  		closure.form=form
  	  	model = [ 'workflowDefinitionInstance' : workflowDefinition, 'formInstance':form ]
  	    closure()          
  	}      
  }
  
  def fieldType(Closure closure) {
	  println "Processing fieldTypes ..."
	  FieldType.findAll().each { fieldType ->	  
  	  	println "Processing fieldType ${fieldType.name} ..."
  		closure.fieldTypeName=fieldType.name
  		closure.fieldType=fieldType
  	  	model = [ 'fieldTypeInstance' : fieldType]
  	    closure()          
  	}      
  }
  

  def namespace(Closure closure) {
	  println "Processing namespaces ..."
	  Namespace.findAll().each { namespace ->	 
	    if (namespace.generateXSDFile) {
  	  		println "Processing namespace ${namespace.filename} ..."
  	  		println "The namespace is ${namespace}"
  	  		closure.namespaceName=namespace.filename
  	  	    closure.namespace=namespace
  	  		model = [ 'namespaceInstance' : namespace]
            closure()
	    }
  	}
  }
  
  def template(String theTemplatePath,String theOutputPath) {
	println "Calling runtemplate  with ${templatePath+theTemplatePath}"
	// Make the target directory tree if it doesn't exist
	def fullOutputPath=outputPath+theOutputPath
	def lastSlashIndex=fullOutputPath.lastIndexOf('/')
	if (lastSlashIndex>-1) {
		def outputDir= new File(fullOutputPath.substring(0, lastSlashIndex))
  		outputDir.mkdirs() 
	}	
	new File(fullOutputPath).write(templateService.runTemplate(templatePath+theTemplatePath, model))
	}

def methodMissing(String name, args) {
  println "Method missing: ${name}, parameters: ${args}"  
  args.each { aname -> println "${aname}" }
}
}

