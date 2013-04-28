package org.workflow4people.services
import org.codehaus.groovy.grails.commons.*
class ImportExportService {
	def grailsApplication
	
    boolean transactional = true

    def domainObjectToXml(domainClassInstance) {
		//def title=dc.getName();
		//def dc=grailsApplication.getClassForName(params.objectClass).get(params.objectId)		
		def dc=domainClassInstance.getClass()
		def defaultDomainClass = new DefaultGrailsDomainClass( dc )
		
		defaultDomainClass.persistentProperties.each() { property ->
			def value=domainClassInstance."${property.name}"
			def type=value.getClass().name
		}
		
		def buildmap = { "object" () 
			{
				"properties" ( {
					defaultDomainClass.persistentProperties.each() { property ->
						def value=domainClassInstance."${property.name}"
						"${property.name}"(type:"${property?.type.name}", value)
				}
			})
		}
		}
		
		
		
		
		
		return buildmap
		
    }
}
