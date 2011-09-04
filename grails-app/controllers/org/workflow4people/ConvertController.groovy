package org.workflow4people
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_WF4P_ADMIN'])
class ConvertController {

    def index = { }
	
	def convert = { 
		FieldList.findAll().each { fieldList -> 
			print "Processing fieldList ${fieldList.name}"
			FieldType fieldType=new FieldType();
			fieldType.listParent=fieldList.parent
			fieldType.listParent.fieldType=fieldType
			fieldType.listParent.save(failOnError:true)
			fieldType.name=fieldList.name
			fieldType.namespace=fieldList.namespace
			fieldType.baseType=fieldList.baseType
			fieldType.label=fieldList.label
			fieldType.description=fieldList.description
			
			fieldType.alert=""
			fieldType.help=""
			fieldType.save(failOnError:true)		
			println " [Done]"
		}
    }
}
