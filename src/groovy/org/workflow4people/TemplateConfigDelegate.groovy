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
	def total=0
	def current=0
	def gLogMessage=""
	def message="Initializing..."
	def completed=false
	
  def mlog (logMessage) { 
		gLogMessage+="<br />"+logMessage
	}
  
  def msg (theMessage) {
	  message=theMessage
	  println message
	  mlog message
  }
	
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

  def getProgress() {
		return [total:total,current:current,message:message,log:gLogMessage,completed:completed]
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
	  msg "Processing common..."
      total=1
      current=1
	  model = [ 'workflowDefinitions' : WorkflowDefinition.findaAll() ]
	  closure.workflow=workflowDefinition
	  closure()
	  mlog "Processing common completed"
  }
  
  def workflow(Closure closure) {
	  msg "Processing workflow..."
	  total=1
      current=1
	  model = [ 'workflowDefinitionInstance' : workflowDefinition,'workflow' : workflowDefinition ]
	  closure.workflow=workflowDefinition
	  closure()
	  mlog "Processing workflow completed"
  }
  
  
  def form(Closure closure) {
	  msg "Processing forms ..."
	  current=0
	  total=workflowDefinition.form.size()
	  println "The total is ${total}"
	  workflowDefinition.form.each { form ->
  	  	msg "Processing form ${form.name} ..."
  		closure.formName=form.name
  		closure.form=form
  	  	model = [ 'workflowDefinitionInstance' : workflowDefinition,'workflow' : workflowDefinition, 'formInstance':form,'form':form ]
  	    closure()
  	  	mlog "Procesed form ${form.name}"
  	  	current++
  	}
	mlog "Processing forms completed"
  }
  
  def fieldType(Closure closure) {
	  msg "Processing fieldTypes ..."
	  current=0
	  total=FieldType.count()
	  FieldType.findAll().each { fieldType ->	  
  	  	msg "- Processing fieldType ${fieldType.name}"
  		closure.fieldTypeName=fieldType.name
  		closure.fieldType=fieldType
  	  	model = [ 'fieldTypeInstance' : fieldType]
  	    closure()
  	  	current++
  	  	//	mlog "-- Processed fieldType ${fieldType.name}"
  	}
	mlog "Processing fieldTypes completed"
  }
  

  def namespace(Closure closure) {
	  msg "Processing namespaces ..."
	  
      total=Namespace.count()
      current=0
	  
	  Namespace.findAll().each { namespace ->	 
	    if (namespace.generateXSDFile) {
  	  		msg "Processing namespace ${namespace.uri} into ${namespace.filename}"
  	  		closure.namespaceName=namespace.filename
  	  	    closure.namespace=namespace
  	  		model = [ 'namespaceInstance' : namespace]
            closure()
  	  		mlog "Processed namespace ${namespace.uri}"
  	  		current++
	    } else {
	    	mlog "Skipped namespace ${namespace.uri}"
	    }
  	}
	mlog "Processing namespaces completed"
  }
  
  def template(String theTemplatePath,String theOutputPath,options=[]) {
	mlog "- Running template ${templatePath+theTemplatePath}"
	
	// Make the target directory tree if it doesn't exist
	def fullOutputPath=outputPath+theOutputPath
	def lastSlashIndex=fullOutputPath.lastIndexOf('/')
	if (lastSlashIndex>-1) {
		def outputDir= new File(fullOutputPath.substring(0, lastSlashIndex))
  		outputDir.mkdirs() 
	}	
	def s=templateService.runTemplate(templatePath+theTemplatePath, model)
	if (!options.contains("noPretty")) {
		//disabled it for now
		//s=templateService.prettyPrint(s)
	}
	if (!options.contains("noReplace")) {
		s=s.replace("<f:","<g:");
		s=s.replace("</f:","</g:");
		s=s.replace('*{',"\${");
		s=s.replace("<ccmis:","<cmis:");
		s=s.replace("</ccmis:","</cmis:");
		
	}
	
	new File(fullOutputPath).write(s)
	}

def methodMissing(String name, args) {
  println "Method missing: ${name}, parameters: ${args}"  
  args.each { aname -> println "${aname}" }
}
}

