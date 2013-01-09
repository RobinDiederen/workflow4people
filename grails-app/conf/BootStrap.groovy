import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.hibernate.event.def.*;
import org.springframework.transaction.support.*
import java.lang.reflect.Modifier
import org.springframework.transaction.TransactionDefinition
import grails.util.GrailsNameUtils
class BootStrap {
	def setupService
	def grailsApplication
     def init = { servletContext ->
      	
		 //def ctx = org.codehaus.groovy.grails.web.context.ServletContextHolder.servletContext.getAttribute(org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes.APPLICATION_CONTEXT);
		 println "Hi. I'm in the bootstrap."
		 setupService.setup()
		 
		 // see http://jira.grails.org/browse/GRAILS-7093	
		 def ctx = grailsApplication.mainContext
		 
			 def withTransactionImpl = {
			   Map sharedVars, Map properties = [propagation: "required"], Closure callable ->
				 
				 def propsMapping = [isolation: "isolationLevelName", propagation: "propagationBehaviorName"]
				 synchronized(sharedVars) {
				   if (sharedVars.isEmpty()) {
					 /* Lazy init of shared variables. */
					 propsMapping.keySet().each {
					   propName ->
						 sharedVars[propName + "Mapping"] = [:]
					 }
		 
					 def modifier = Modifier.FINAL | Modifier.STATIC | Modifier.PUBLIC
					 /* Build NAME -> CONSTANT NAME mappings. */
					 def constants = (TransactionDefinition.class.declaredFields as List).findAll {
					   field ->
						 if ((field.modifiers & modifier) == modifier) {
						   def constant = field
						   propsMapping.keySet().each {
							 propName ->
							   if (constant.name.startsWith(TransactionTemplate["PREFIX_" + propName.toUpperCase()])) {
								 def key = constant.name.replace(TransactionTemplate["PREFIX_" + propName.toUpperCase()], "")
								 key = key.replace("_", "-").toLowerCase()
								 sharedVars[propName + "Mapping"][GrailsNameUtils.getPropertyNameForLowerCaseHyphenSeparatedName(key)] = constant.name
							   }
						   }
						 }
					 }
					 
				   }
				 }
				 
				 //println "sharedVars ${sharedVars}"
				 def template = new TransactionTemplate(ctx.getBean('transactionManager'))
				 properties.entrySet().each {
				   property ->
					 if (propsMapping.containsKey(property.key)) {
					   def newKey = propsMapping[property.key]
					   template[newKey] = sharedVars[property.key + "Mapping"][property.value]
					 } else {
					   template[property.key] = property.value
					 }
				 }
		 
				 template.execute(
				   {status ->
					 callable.call(status)
				   } as TransactionCallback)
			 }
		 
			 withTransactionImpl = withTransactionImpl.curry([:])
			 def withNewTransactionImpl = {
			   Map properties = [:], Closure callable ->
				 properties.propagation = "requiresNew"
				 withTransactionImpl(properties, callable)
			 }
		 
			 grailsApplication.domainClasses.each {
			   domainClass ->
				 domainClass.metaClass.static.withTransaction = withTransactionImpl
				 domainClass.metaClass.static.withNewTransaction = withNewTransactionImpl
			 }
		 
		 
		 

       
     }

     def destroy = {
     }
} 
