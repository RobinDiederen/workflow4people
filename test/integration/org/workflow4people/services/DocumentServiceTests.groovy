package org.workflow4people.services

import grails.test.*
import org.workflow4people.*
import org.workflow4people.services.*
import grails.test.mixin.TestFor
import org.apache.activemq.*
import static org.junit.Assert.*
import org.junit.*

class DocumentServiceTests {
	def xmlDocument
	
	def jmsMap
	def jmsMessage
	def documentService
	
	def transactional=false
	
	@Before
	void setUp() {
		println "Hello. This is the setup part of DocumentServiceTests"
		Document.findAll().each { doc ->
			println "document ${doc.id}:${doc.name}"
		}
		
		DocumentType.findAll().each { doc ->
			println "documentType ${doc.id}:${doc.name}"
		}
		
		/*
		// Fake isDirty is needed - mocked domain classes lack this
		Document.metaClass.isDirty =
		{ return true }
		
		// Fake getPersistentValue is needed - mocked domain classes lack this
		Document.metaClass.getPersistentValue =
		{ return "0.1" }
		
		/*
		grails.plugin.jms.JmsService.metaClass.send =
		{ return null }
		*/
		// Mock the JMS service
		/*
		def mock = mockFor(grails.plugin.jms.JmsService)
		mock.demand.send(1..10)  {map,message,jmsTemplateName,postProcessor ->
			println "JMS Service send: ${map}, message: ${message}"
			jmsMap=map
			jmsMessage=message
			return null}
		
		documentService.jmsService=mock.createMock()
		*/
		
		def apc= new ApplicationConfiguration(configKey:'cmis.enabled',configValue:"false").save(failOnError:true,flush:true)
		def apc2= new ApplicationConfiguration(configKey:'identity.group.home.default',configValue:"test").save(failOnError:true,flush:true)
		def apc3= new ApplicationConfiguration(configKey:'calendar.businessDayInMinutes',configValue:"450").save(failOnError:true,flush:true)
		def apc4= new ApplicationConfiguration(configKey:'calendar.businessWeekInMinutes',configValue:"2250").save(failOnError:true,flush:true)
		def apc5= new ApplicationConfiguration(configKey:'calendar.businessMonthInDays',configValue:"22").save(failOnError:true,flush:true)
		def apc6= new ApplicationConfiguration(configKey:'calendar.businessYearInDays',configValue:"220").save(failOnError:true,flush:true)
		
		
		def holiday= new Holiday(title:'test',fromDate:new Date(),toDate:new Date()).save(failOnError:true,flush:true)
		
		
		def fieldType=new FieldType(name:'test',description:'test',help:'test',alert:'test').save(failOnError:true,flush:true)
		def documentType=new DocumentType(name:'test',description:'test',fieldType:fieldType).save(failOnError:true,flush:true)
		
		def folderFieldType=new FieldType(name:'folder',description:'test',help:'test',alert:'test').save(failOnError:true,flush:true)
		
		def folderDocumentType=new DocumentType(name:'Folder',folder:true,description:'test',fieldType:folderFieldType).save(failOnError:true,flush:true)
		def workflowEngine=new WorkflowEngine(name:'jbpm4',title:'jbpm4',description:'jbpm').save(failOnError:true,flush:true)
		def workflowDefinition=new WorkflowDefinition(name:'StoringMelding',title:'test',description:'test',documentType:documentType,workflowEngine:workflowEngine,publish:true,run:true).save(failOnError:true,flush:true)
		
		xmlDocument="""<?xml version="1.0" encoding="UTF-8"?><test:Test xmlns:test="http://www.workflow4people.org/schemas/test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <doc:header xmlns:doc="http://www.workflow4people.org/schemas/documents">
			    <doc:documentId>1</doc:documentId>
			    <doc:documentType>test</doc:documentType>
			    <doc:documentStatus>Some status</doc:documentStatus>
			    <doc:documentKey/>
			    <doc:documentDescription>Test</doc:documentDescription>
			    <doc:workflowName>StoringMelding</doc:workflowName>
			    <doc:taskId/>
			    <doc:taskOutcome/>
			    <doc:processInstanceId>1000</doc:processInstanceId>
			    <doc:dateCreated>2013-02-17T12:32:41</doc:dateCreated>
			    <doc:lastUpdated>2013-02-17T13:49:53</doc:lastUpdated>
			    <doc:completionDate>2010-01-01T00:00:00</doc:completionDate>
			    <doc:processingDays>0</doc:processingDays>
			    <doc:user>
			      <doc:name>test</doc:name>
			      <doc:displayName>Test User</doc:displayName>
			      <doc:email>test@open-t.nl</doc:email>
			    </doc:user>
			    <doc:onbehalfof/>
			    <doc:group/>
			    <doc:comments>      
			    </doc:comments>
			    <doc:forms/>
			    <doc:files/>
			    <doc:cmis>
			      <doc:folderObjectId/>
			      <doc:folderUrl/>
			      <doc:path>/Sites/test/documentLibrary/test/1</doc:path>
			    </doc:cmis>
			    <doc:task>
			      <doc:id/>
			      <doc:name/>
			      <doc:description/>
			      <doc:outcome></doc:outcome>
			      <doc:dueDate/>
			      <doc:priority/>
			      <doc:assignee/>
			      <doc:status/>
			      <doc:statusUser/>
			    </doc:task>
			  </doc:header>
			  <test:testString>testValue</test:testString>  
			</test:Test>
			"""
		//def documentType=DocumentType.get(1)
		def dateCreated=Date.parse("yyyyMMddhhmmss","20120212215912")
		def lastUpdated=Date.parse("yyyyMMddhhmmss","20130224194739")

		def document=new Document(user:"john",
								  groupId:'testgroup',
								  name:'test',
								  documentDescription:'Test description',
								  cmisFolderObjectId:'12',
								  cmisPath:'/test',
								  xmlDocument:xmlDocument,
								  documentType:documentType,
								  dateCreated:dateCreated,
								  lastUpdated:lastUpdated).save(failOnError:true,flush:true)
								  
	}
  

    @After
    void tearDown() {
        // Tear down logic here
    }

   
	@Test
	void testCreateDocument() {		
		def sxmlDocument=documentService.getDocument(1)
		sxmlDocument.header.documentId=""
		//documentService.setDocument(sxmlDocument)
		documentService.createDocument(sxmlDocument)
		
		Document.findAll().each { doc ->
			println "document ${doc.id}"
		}
		println "Taking a nap ..."
		Thread.sleep(3000)
		println "Bye!"
	}
}
