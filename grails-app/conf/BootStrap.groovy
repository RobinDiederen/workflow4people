import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.hibernate.event.def.*;
class BootStrap {
	def setupService
     def init = { servletContext ->
      	
		 def ctx = org.codehaus.groovy.grails.web.context.ServletContextHolder.servletContext.getAttribute(org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes.APPLICATION_CONTEXT);
		 println "Hi. I'm in the bootstrap."
		 setupService.setup()

       
     }

     def destroy = {
     }
} 
