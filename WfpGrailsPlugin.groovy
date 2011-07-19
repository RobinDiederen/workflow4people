
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class WfpGrailsPlugin {
    // the plugin version
    def version = "0.7.0"
    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "1.3.5 > *"
    // the other plugins this plugin depends on
    def dependsOn = [jquery:"1.4.3.2",springws:"0.5.0.1",searchable:"0.5.5",'background-thread':"1.6","jetty":"1.2-SNAPSHOT"]
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
            "grails-app/views/error.gsp"
    ]

    // TODO Fill in these fields
    def author = "Joost Horward"
    def authorEmail = ""
    def title = "Workflow4people/workflow engine"
    def description = '''\\
Brief description of the plugin.
'''

    // URL to the plugin's documentation
    def documentation = "http://www.workflow4people.org"

    def doWithWebDescriptor = { xml ->
        // TODO Implement additions to web.xml (optional), this event occurs before 
    }

    def doWithSpring = {
        // TODO Implement runtime spring config (optional)
		/*
		def config = ConfigurationHolder.config
		
			  def springSecurityConfig = SpringSecurityUtils.securityConfig
		
			  
		
			  springSecurityConfig.providerNames = config.grails.plugins.springsecurity.providerNames
		
			  
		
			  springSecurityConfig.useSecurityEventListener = config.grails.plugins.springsecurity.useSecurityEventListener
		
			  springSecurityConfig.active = config.grails.plugins.springsecurity.active
		
			  springSecurityConfig.password.algorithm = config.grails.plugins.springsecurity.password.algorithm
		
			  
		
			  springSecurityConfig.userLookup.userDomainClassName = config.grails.plugins.springsecurity.userLookup.userDomainClassName
		
			  springSecurityConfig.authority.className = config.grails.plugins.springsecurity.authority.className
		
			  springSecurityConfig.userLookup.passwordPropertyName = config.grails.plugins.springsecurity.userLookup.passwordPropertyName
		
			  
		
			  springSecurityConfig.ldap.active = config.grails.plugins.springsecurity.ldap.active
		
			  springSecurityConfig.ldap.authorities.retrieveDatabaseRoles = config.grails.plugins.springsecurity.ldap.authorities.retrieveDatabaseRoles
		
			  springSecurityConfig.ldap.authorities.retrieveGroupRoles = config.grails.plugins.springsecurity.ldap.authorities.retrieveGroupRoles
		
			  springSecurityConfig.ldap.context.server = config.grails.plugins.springsecurity.ldap.context.server
		
			  springSecurityConfig.ldap.context.managerDn = config.grails.plugins.springsecurity.ldap.context.managerDn
		
			  springSecurityConfig.ldap.context.managerPassword = config.grails.plugins.springsecurity.ldap.context.managerPassword
		
			  springSecurityConfig.ldap.search.base = config.grails.plugins.springsecurity.ldap.search.base
		
			  springSecurityConfig.ldap.search.filter = config.grails.plugins.springsecurity.ldap.search.filter
		
			  springSecurityConfig.ldap.search.searchSubtree = config.grails.plugins.springsecurity.ldap.search.searchSubtree
		
			  springSecurityConfig.ldap.authorities.groupSearchBase = config.grails.plugins.springsecurity.ldap.authorities.groupSearchBase
		
			  springSecurityConfig.ldap.ldap.authorities.groupSearchFilter = config.grails.plugins.springsecurity.ldap.ldap.authorities.groupSearchFilter
		
			  springSecurityConfig.ldap.auth.useAuthPassword = config.grails.plugins.springsecurity.ldap.auth.useAuthPassword
			  */
    }

    def doWithDynamicMethods = { ctx ->
        // TODO Implement registering dynamic methods to classes (optional)
    }

    def doWithApplicationContext = { applicationContext ->
        // TODO Implement post initialization spring config (optional)
    }

    def onChange = { event ->
        // TODO Implement code that is executed when any artefact that this plugin is
        // watching is modified and reloaded. The event contains: event.source,
        // event.application, event.manager, event.ctx, and event.plugin.
    }

    def onConfigChange = { event ->
        // TODO Implement code that is executed when the project configuration changes.
        // The event is the same as for 'onChange'.
    }
}
