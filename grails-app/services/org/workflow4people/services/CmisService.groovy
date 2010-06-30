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
import org.workflow4people.*
import groovy.lang.Binding;
/**
 * CMIS service class. 
 * Provides CMIS interface services  
 * 
 * @author Joost Horward
 */
class CmisService {

    boolean transactional = true
    
    /**
     * Create a new case folder in the DMS through CMIS
     * @param caseNumber
     * @return the CMIS Object ID
     */
    
    def createCase(def caseNumber) {
    	def ObjectId=""
    	try {
    	def cmisCasesUrl=ApplicationConfiguration.findByConfigKey('cmis.cases.url').configValue
    	def cmisUserName=ApplicationConfiguration.findByConfigKey('cmis.user.name').configValue
    	def cmisUserPassword=ApplicationConfiguration.findByConfigKey('cmis.user.password').configValue
    	def casePrefix=ApplicationConfiguration.findByConfigKey('cmis.cases.prefix').configValue
    	def url=cmisCasesUrl+"/children"
       	def conn = new URL(url).openConnection()
    	
    	String userPassword="${cmisUserName}:${cmisUserPassword}"
    	String encoding = new sun.misc.BASE64Encoder().encode (userPassword.getBytes());

       	conn.setRequestProperty("Authorization", "Basic " + encoding)
    	conn.setRequestProperty("Content-Type","application/atom+xml")
       	conn.requestMethod = "POST"
       	conn.doOutput = true

    	Writer writer=new OutputStreamWriter(conn.outputStream)
       	
       	def caseName="${casePrefix}${caseNumber}"

    def postdataCmis06="""<?xml version="1.0" encoding="UTF-8"?> 
    <entry xmlns="http://www.w3.org/2005/Atom" xmlns:app="http://www.w3.org/2007/app" xmlns:cmis="http://docs.oasis-open.org/ns/cmis/core/200901" > 
    <author><name>cmis</name></author> 
    <summary>${caseName}</summary> 
    <title>${caseName}</title> 
    <cmis:object>
    <cmis:properties>
    <cmis:propertyString cmis:name="BaseType"><cmis:value>folder</cmis:value></cmis:propertyString>
    <cmis:propertyString cmis:name="Name"><cmis:value>${caseName}</cmis:value></cmis:propertyString>
    <cmis:propertyId cmis:name="ObjectTypeId"><cmis:value>folder</cmis:value></cmis:propertyId>
    </cmis:properties>
    </cmis:object>
    </entry>
    """
    	
    def postdata="""<?xml version="1.0" encoding="UTF-8"?> 
    <entry xmlns="http://www.w3.org/2005/Atom" xmlns:app="http://www.w3.org/2007/app" 
    	xmlns:cmisra="http://docs.oasis-open.org/ns/cmis/restatom/200908/"
    	xmlns:cmis="http://docs.oasis-open.org/ns/cmis/core/200908/" > 
    <author><name>cmis</name></author> 
    <summary>${caseName}</summary> 
    <title>${caseName}</title> 
    <cmisra:object>
    <cmis:properties>
    <cmis:propertyId propertyDefinitionId="cmis:objectTypeId" displayName="Object Type Id" queryName="cmis:objectTypeId"><cmis:value>cmis:folder</cmis:value></cmis:propertyId>
    </cmis:properties>
    </cmisra:object>
    </entry>
    </entry>
    """	
    	
    	

    	writer.write(postdata)
    	writer.flush()
    	writer.close()

    	conn.connect()
        println "The response code is ${conn.responseCode}"
    	println "The response content is:"
    	def theContent= conn.content.text
    	println theContent

    	def slurper = new XmlSlurper()    	
        def response=slurper.parseText(theContent)
    	println response.object.properties.propertyString[1].value.text()

    	ObjectId=response.object.properties.propertyId.find{ it.@name=="ObjectId"}.value
    	println(ObjectId)

        conn.disconnect()
        
        
    	} catch (Exception e) {
    		println "CMIS error ${e}"
    	}
        
        return ObjectId
        
    }
    
    Binding binding(Document document) {		
		groovy.lang.Binding binding = new Binding()		
		binding.document=document
		return binding
	}
    
    
    def caseFolderUrl(def documentInstance) {
    	def cmisCasesFolderUrlTemplate=ApplicationConfiguration.findByConfigKey('cmis.cases.folder.url.template').configValue
    	
    	def cmisFolderUrl=new GroovyShell(binding(documentInstance)).evaluate("\""+cmisCasesFolderUrlTemplate+"\"")
    	return cmisFolderUrl
    }
    
    boolean getEnabled() {
    	String val= ApplicationConfiguration.findByConfigKey('cmis.enabled').configValue
    	return (val.toLowerCase()=="true" || val=="1")
    }
    
    
 
}
