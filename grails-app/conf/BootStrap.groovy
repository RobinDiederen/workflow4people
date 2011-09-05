import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.hibernate.event.def.*;
class BootStrap {

     def init = { servletContext ->
      	
    def ctx = org.codehaus.groovy.grails.web.context.ServletContextHolder.servletContext.getAttribute(org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes.APPLICATION_CONTEXT);

       
     }

     def destroy = {
     }
} 
