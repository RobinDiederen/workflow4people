package org.workflow4people.services
import grails.test.*
import org.workflow4people.*
import org.workflow4people.services.*
import grails.test.mixin.TestFor

@TestFor(DocumentService)
@Mock([Document,DocumentType,FieldType])
class DocumentServiceTests {	
	void setUp() {
		def fieldType=new FieldType(name:'test',description:'test',help:'test',alert:'test').save(failOnError:true)
		def documentType=new DocumentType(name:'test',description:'test',fieldType:fieldType).save(failOnError:true)
		def xmlDocument="""<?xml version="1.0" encoding="UTF-8"?><test:Test xmlns:test="http://www.workflow4people.org/schemas/test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
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

		def document=new Document(name:'test',xmlDocument:xmlDocument,documentType:documentType,dateCreated:dateCreated,lastUpdated:lastUpdated).save(failOnError:true)
	}
	
	void testCamelCase() {
		assert service.camelCase("TestString")=="testString"
	}
	
	void testGetDocument() {
		def sxmlDocument=service.getDocument(1)
		assert sxmlDocument.header.dateCreated=='2012-02-12T21:59:12'
		assert sxmlDocument.header.lastUpdated=='2013-02-24T19:47:39'
		assert sxmlDocument.header.taskId==""
		assert sxmlDocument.header.taskOutcome==""
	}
	
	void testBinding() {
		def document=Document.get(1)
		def b=service.binding(document)
		assert b.document==document
		assert b.doc.header.documentId.text()=="1"
	}
	
	
	
	
}
