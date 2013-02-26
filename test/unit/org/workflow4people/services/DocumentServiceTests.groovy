package org.workflow4people.services
import grails.test.*
import org.workflow4people.*
import org.workflow4people.services.*
import grails.test.mixin.TestFor

@TestFor(DocumentService)
@Mock([Document,DocumentType,FieldType,DocumentHistory])
class DocumentServiceTests {
	def xmlDocument	
	void setUp() {
		// Fake isDirty is needed - mocked domain classes lack this
		Document.metaClass.isDirty =
		{ return true }
		
		// Fake getPersistentValue is needed - mocked domain classes lack this
		Document.metaClass.getPersistentValue =
		{ return "0.1" }
		
		/*defineBeans {
			jmsService(grails.plugin.jms.JmsService)
			
			
		  }
		*/
		//def jmsService = new grails.plugin.jms.JmsService()
		/*def jmsService = mockFor(grails.plugin.jms.JmsService, true)
		def wasCalled = false
		jmsService.send(0..2) { x,y -> 
			//I like to have an assert in here to test what's being passed in so I can ensure wiring is correct
			wasCalled = true
			null //this is what the method will now return
		}
		*/
		def fieldType=new FieldType(name:'test',description:'test',help:'test',alert:'test').save(failOnError:true)
		def documentType=new DocumentType(name:'test',description:'test',fieldType:fieldType).save(failOnError:true)
		xmlDocument="""<?xml version="1.0" encoding="UTF-8"?><test:Test xmlns:test="http://www.workflow4people.org/schemas/test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
			  <doc:header xmlns:doc="http://www.workflow4people.org/schemas/documents">
			    <doc:documentId>1</doc:documentId>
			    <doc:documentType>test</doc:documentType>
			    <doc:documentStatus>Some status</doc:documentStatus>
			    <doc:documentKey/>
			    <doc:documentDescription>Test</doc:documentDescription>
			    <doc:workflowName>test</doc:workflowName>
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
	
	void testCamelCase() {
		assert service.camelCase("TestString")=="testString"
	}
	/**
	 * Test the getDocument method
	 */
	void testGetDocument() {
		def sxmlDocument=service.getDocument(1)
		//assert sxmlDocument.header.dateCreated=='2012-02-12T21:59:12'
		//assert sxmlDocument.header.lastUpdated=='2013-02-24T19:47:39'
		assert sxmlDocument.header.taskId==""
		assert sxmlDocument.header.taskOutcome==""
		assert sxmlDocument.header.user.name=="john"
		assert sxmlDocument.header.group=="testgroup"
		assert sxmlDocument.header.documentDescription=="Test description"
				
		assert sxmlDocument.header.cmis.folderObjectId=="12"
		assert sxmlDocument.header.cmis.path=="/test"
		
		shouldFail(RuntimeException) {
			def nxmlDocument=service.getDocument(0)
		}
	}
	
	/**
	 * Test the binding method
	 */
	void testBinding() {
		def document=Document.get(1)
		def b=service.binding(document)
		assert b.document==document
		assert b.doc.header.documentId.text()=="1"
	}
	/*
	void testSetDocument() {
		def sxmlDocument=service.getDocument(1)
		assert sxmlDocument.header.user.name=="john"
		sxmlDocument.header.processingDays="17"
		service.setDocument(sxmlDocument)
		def doc=Document.get(1)
		assert doc.processingDays==17
		def rdocument=service.getDocument(1)
		assert rdocument.header.processingDays.text()=="17"
	}
	*/
	
	
}
