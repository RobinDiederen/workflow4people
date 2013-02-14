//import com.sun.net.ssl.internal.ssl.Debug;
//import org.apache.commons.dbcp.BasicDataSource

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts
grails.config.locations = [ "classpath:wfp-config.groovy",
                             "file:${userHome}/.wfp/wfp-config.groovy"]

grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xxml: ['text/xxml', 'application/xxml'],
                      text: 'text-plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]
// The default codec used to encode data with ${}
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://localhost"
    }
    
    development {    	
	}
}

// log4j configuration
log4j = {
    warn  'org.codehaus.groovy.grails.web.servlet',  //  controllers
    'org.codehaus.groovy.grails.web.pages', //  GSP
    'org.codehaus.groovy.grails.web.sitemesh', //  layouts
    'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
    'org.codehaus.groovy.grails.web.mapping', // URL mapping
    'org.codehaus.groovy.grails.commons', // core / classloading
    'org.codehaus.groovy.grails.plugins', // plugins

    'org.springframework',
    'org.hibernate'
    warn 'org.codehaus.groovy.grails.orm.hibernate' // hibernate integration
    warn   'org.mortbay.log'    
   // debug 'grails.app.endpoint.org.workflow4people'
   // debug 'org.jbpm'
    warn 'import org.codehaus.groovy.grails.plugins.springsecurity'
    warn 'org.springframework.security'
    //debug 'grails.app.controller.org.workflow4people'
    //debug 'grails.app.service.org.workflow4people.services'
	warn "grails.app"
	warn "grails.app.controllers"
	debug "grails.app.services"
	warn "grails.app.endpoints"
	warn "grails.app.domain"
    
}


springws {
    wsdl {
        WorkflowService {
            // In this case the wsdl will be available at <grails.serverURL>/services/workflow4people.wsdl
            wsdlName= 'workflow4people'
            xsds= '/WEB-INF/workflow4people.xsd,/WEB-INF/workflow4people-documents.xsd'
            portTypeName = 'WorkflowPort'
            serviceName = 'WorkflowService'
            locationUri = "http://localhost:8081/workflow4people/services/"
            targetNamespace = 'http://www.workflow4people.org/services'
        }
    }
}

jquery {
    sources = 'jquery' // Holds the value where to store jQuery-js files /web-app/js/
    version = '1.4.2' // The jQuery version in use
}
	

grails.scan.interval=20000

security {
	grails.plugins.springsecurity.providerNames = [/*'ldapAuthProvider', */'daoAuthenticationProvider', 'anonymousAuthenticationProvider', 'rememberMeAuthenticationProvider']
	
	grails.plugins.springsecurity.useSecurityEventListener = true
	grails.plugins.springsecurity.active = true
	grails.plugins.springsecurity.password.algorithm = "SHA"
	
	grails.plugins.springsecurity.userLookup.userDomainClassName = "org.workflow4people.Person"
	grails.plugins.springsecurity.authority.className = "org.workflow4people.Authority"
	grails.plugins.springsecurity.userLookup.passwordPropertyName = "passwd"
	
	grails.plugins.springsecurity.ldap.active = false
	grails.plugins.springsecurity.ldap.authorities.retrieveDatabaseRoles = true
    grails.plugins.springsecurity.ldap.authorities.retrieveGroupRoles = false
    grails.plugins.springsecurity.ldap.context.server = "ldap://domaincontroller:389"
    grails.plugins.springsecurity.ldap.context.managerDn = "administrator"
    grails.plugins.springsecurity.ldap.context.managerPassword = "adminpw"
    grails.plugins.springsecurity.ldap.search.base = "dc=dc1,dc=dc2"
    grails.plugins.springsecurity.ldap.search.filter = "(sAMAccountName={0})"
    grails.plugins.springsecurity.ldap.search.searchSubtree = true
    grails.plugins.springsecurity.ldap.authorities.groupSearchBase = "dc=dc1,dc=dc2"
    grails.plugins.springsecurity.ldap.ldap.authorities.groupSearchFilter = "member={0}"
    grails.plugins.springsecurity.ldap.auth.useAuthPassword = true
}

cmis {
	baseUrl="mercury:8080/alfresco/s/cmis"
	//baseUrl="http://cmis.alfresco.com:80/service/cmis"
	username="admin"
	password="admin"
}

grails.naming.entries = ['jdbc/wf4p': [
	type: "javax.sql.DataSource", //required
		//auth: "Container", // optional
		description: "Data source for ...", //optional
		//properties for particular type of resource
	url: "jdbc:mysql://localhost:3306/wf4p",
	username: "wf4p",
	password: "wf4p",
	driverClassName: "com.mysql.jdbc.jdbc2.optional.MysqlConnectionPoolDataSource",
	maxActive: "8", //and so on
		maxIdle: "4"
	]
]
solr {
	url="http://localhost:8080/solr"
}

grails.plugins.twitterbootstrap.fixtaglib = true

wfp {
	apikey="CHANGETHIS"
}