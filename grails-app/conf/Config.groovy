import com.sun.net.ssl.internal.ssl.Debug;
//import org.apache.commons.dbcp.BasicDataSource

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts
grails.config.locations = [ "classpath:${appName}-config.properties",
                             "classpath:${appName}-config.groovy",
                             "file:${userHome}/.grails/${appName}-config.properties",
                             "file:${userHome}/.grails/${appName}-config.groovy"]

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
    warn 'grails.app.endpoint.org.workflow4people'
    warn 'org.jbpm'
    warn 'import org.codehaus.groovy.grails.plugins.springsecurity'
    warn 'org.springframework.security'
    debug 'org.workflow4people'
    debug 'org.workflow4people.services'
    
}


springws {
    wsdl {
        WorkflowService {
            // In this case the wsdl will be available at <grails.serverURL>/services/workflow4people.wsdl
            wsdlName= 'workflow4people'
            xsds= '/WEB-INF/workflow4people.xsd,/WEB-INF/workflow4people-documents.xsd'
            portTypeName = 'WorkflowPort'
            serviceName = 'WorkflowService'
            locationUri = "http://localhost:8080/workflow4people/services/"
            targetNamespace = 'http://www.workflow4people.org/services'
        }
    }
}
	

