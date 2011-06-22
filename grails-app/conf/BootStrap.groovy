import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.hibernate.event.def.*;
class BootStrap {

     def init = { servletContext ->
    println "Bootstrap"
    println "Authority count:  	${org.workflow4people.Authority.count()}"
     // workaround for GRAILS-4580
     ApplicationHolder.application.domainClasses.each { dc ->
         "println ${dc} - count: ${dc.clazz.count()}"
     }
/*    
       	org.workflow4people.Action.get(-1)
     	org.workflow4people.ApplicationConfiguration.get(-1)
     	org.workflow4people.Authority.get(-1)
     	org.workflow4people.BaseType.get(-1)
     	org.workflow4people.DayPart.get(-1)     	
     	org.workflow4people.Document.get(-1)
     	org.workflow4people.DocumentIndex.get(-1)
     	org.workflow4people.DocumentIndexField.get(-1)
     	org.workflow4people.DocumentType.get(-1)
     	org.workflow4people.Feature.get(-1)
     	org.workflow4people.FeaturePermission.get(-1)
     	org.workflow4people.Field.get(-1)
     	org.workflow4people.FieldList.get(-1)
     	org.workflow4people.FieldType.get(-1)
     	org.workflow4people.FieldTypeItem.get(-1)
     	org.workflow4people.Form.get(-1)
     	org.workflow4people.FormItem.get(-1)
     	org.workflow4people.FormPermission.get(-1)
     	org.workflow4people.Holiday.get(-1)
     	org.workflow4people.MinerQuery.get(-1)
     	org.workflow4people.Namespace.get(-1)
     	org.workflow4people.Person.get(-1)
     	org.workflow4people.Requestmap.get(-1)     	
     	org.workflow4people.Role.get(-1)
     	org.workflow4people.WorkflowDefinition.get(-1)
     	org.workflow4people.WorkflowPermission.get(-1)
  */   	
    def ctx = org.codehaus.groovy.grails.web.context.ServletContextHolder.servletContext.getAttribute(org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes.APPLICATION_CONTEXT);

    /*
    def springHelper=ctx.springHelper
    def cfg = springHelper.jbpmCfg;
    
    println "CFG= ${cfg}"
    
    def stack = [ new org.workflow4people.EventListener() , new DefaultLoadEventListener() ]

    cfg.EventListeners().setLoadEventListeners(stack);
    */
    
     }

     def destroy = {
     }
} 
