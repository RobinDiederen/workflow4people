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

package org.workflow4people.services
import org.workflow4people.*;
import org.springframework.context.ApplicationContextAware
import org.springframework.context.ApplicationContext
import org.codehaus.groovy.grails.web.context.ServletContextHolder as SCH
import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateEngine
import groovy.text.*;
import org.springframework.web.context.request.RequestContextHolder


public class TemplateService implements  ApplicationContextAware {
    	
    def applicationContext
    
	def wf4pConfigService
	GroovyPagesTemplateEngine groovyPagesTemplateEngine

    def sessionFactoryBean
    def sessionFactory

    void setApplicationContext(ApplicationContext inApplicationContext){
        applicationContext = inApplicationContext
        sessionFactoryBean = applicationContext.getBean('&sessionFactory')  
    }

	def servletContext = SCH.servletContext
	
    boolean transactional = true
    
    
    String runTemplate(String filename,model) {
		
		def gspFile=new File(filename)
    	
    	groovyPagesTemplateEngine.setApplicationContext(applicationContext)
    	groovyPagesTemplateEngine.setServletContext(servletContext)
    	groovyPagesTemplateEngine.setClassLoader(applicationContext.getClassLoader())
    	
    	Template t = groovyPagesTemplateEngine.createTemplate(gspFile)
    	StringWriter writer = new StringWriter();
        
        def requestAttributes = RequestContextHolder.getRequestAttributes()
        def originalOut = requestAttributes.getOut()
        
        requestAttributes.setOut(writer)

                      
                      
  	    t.make(model).writeTo(writer)
  	    def s= writer.toString()
  	    
  	    requestAttributes.setOut(originalOut)
		
		return s			
	}
	
	String runSnippetTemplate(def object,def snippetType) {		
		String className=object.class.name.substring(object.class.name.lastIndexOf('.')+1)
		log.debug "${className} ${object.name}"
    	def templatePath=ApplicationConfiguration.findByConfigKey('template.path').configValue
    	
    	def baseType
    	def fieldType=null
    	if (object.class==org.workflow4people.Field) {
    		baseType=object.fieldType.baseType
    		fieldType=object.fieldType
    	}
		
		if (object.class==org.workflow4people.FieldType) {
    		baseType=object.baseType
    		fieldType=object
    	}
		
		if (object.class==org.workflow4people.FieldList) {
    		baseType=object.baseType    		
    	}
		
		
		def model=[:]		
   		model=object.binding().getVariables()
		
		
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
    

}

