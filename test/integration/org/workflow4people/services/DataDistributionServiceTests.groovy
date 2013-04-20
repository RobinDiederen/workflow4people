package org.workflow4people.services

import grails.test.*
import org.workflow4people.*
import org.workflow4people.services.*
import grails.test.mixin.TestFor
import org.apache.activemq.*
import static org.junit.Assert.*
import org.junit.*

class DataDistributionServiceTests {
	def xmlDocument
	
	def jmsMap
	def jmsMessage
	def documentService
	def setupService
	
	def activeMQService
	
	def transactional=false
	
	@Before
	void setUp() {
		println "Hello. This is the setup part of DataDistributionTests"
		activeMQService.init()
		Document.findAll().each { doc ->
			println "document ${doc.id}:${doc.name}"
		}
		
		DocumentType.findAll().each { doc ->
			println "documentType ${doc.id}:${doc.name}"
		}
		
		def apc= new ApplicationConfiguration(configKey:'cmis.enabled',configValue:"false").save(failOnError:true,flush:true)
		def apc2= new ApplicationConfiguration(configKey:'identity.group.home.default',configValue:"test").save(failOnError:true,flush:true)
		def apc3= new ApplicationConfiguration(configKey:'calendar.businessDayInMinutes',configValue:"450").save(failOnError:true,flush:true)
		def apc4= new ApplicationConfiguration(configKey:'calendar.businessWeekInMinutes',configValue:"2250").save(failOnError:true,flush:true)
		def apc5= new ApplicationConfiguration(configKey:'calendar.businessMonthInDays',configValue:"22").save(failOnError:true,flush:true)
		def apc6= new ApplicationConfiguration(configKey:'calendar.businessYearInDays',configValue:"220").save(failOnError:true,flush:true)
		
		def apc7= new ApplicationConfiguration(configKey:'wfp.id',configValue:"test").save(failOnError:true,flush:true)
		
		
		
		def dp1=new DayPart(dayName:"Monday",fromTime:"09:00",toTime:"12:00").save(failOnError:true,flush:true)
		def dp2=new DayPart(dayName:"Monday",fromTime:"12:30",toTime:"17:00").save(failOnError:true,flush:true)
		
		def dp3=new DayPart(dayName:"Tuesday",fromTime:"09:00",toTime:"12:00").save(failOnError:true,flush:true)
		def dp4=new DayPart(dayName:"Tuesday",fromTime:"12:30",toTime:"17:00").save(failOnError:true,flush:true)
		
		def dp5=new DayPart(dayName:"Wednesday",fromTime:"09:00",toTime:"12:00").save(failOnError:true,flush:true)
		def dp6=new DayPart(dayName:"Wednesday",fromTime:"12:30",toTime:"17:00").save(failOnError:true,flush:true)
		
		def dp7=new DayPart(dayName:"Thursday",fromTime:"09:00",toTime:"12:00").save(failOnError:true,flush:true)
		def dp8=new DayPart(dayName:"Thursday",fromTime:"12:30",toTime:"17:00").save(failOnError:true,flush:true)
		
		def dp9=new DayPart(dayName:"Friday",fromTime:"09:00",toTime:"12:00").save(failOnError:true,flush:true)
		def dp10=new DayPart(dayName:"Friday",fromTime:"12:30",toTime:"17:00").save(failOnError:true,flush:true)
		
		
		
		def holiday= new Holiday(title:'test',fromDate:new Date(),toDate:new Date()).save(failOnError:true,flush:true)
		
		
		def fieldType=new FieldType(name:'test',description:'test',help:'test',alert:'test').save(failOnError:true,flush:true)
		def documentType=new DocumentType(name:'test',description:'test',fieldType:fieldType).save(failOnError:true,flush:true)
		
		def documentType2=new DocumentType(name:'StoringMelding',description:'test',fieldType:fieldType).save(failOnError:true,flush:true)
		def documentType3=new DocumentType(name:'ddsdemo',description:'test',fieldType:fieldType).save(failOnError:true,flush:true)
		
		
		def folderFieldType=new FieldType(name:'folder',description:'test',help:'test',alert:'test').save(failOnError:true,flush:true)
		
		def folderDocumentType=new DocumentType(name:'Folder',folder:true,description:'test',fieldType:folderFieldType).save(failOnError:true,flush:true)
		def workflowEngine=new WorkflowEngine(name:'jbpm4',title:'jbpm4',description:'jbpm').save(failOnError:true,flush:true)
		def workflowDefinition=new WorkflowDefinition(name:'StoringMelding',title:'test',description:'test',documentType:documentType,workflowEngine:workflowEngine,publish:true,run:true).save(failOnError:true,flush:true)
		def workflowDefinition2=new WorkflowDefinition(name:'ddsdemo',title:'ddsdemo',description:'test',documentType:documentType,workflowEngine:workflowEngine,publish:true,run:true).save(failOnError:true,flush:true)
		
		setupService.addUser("test","test","Test user","admin@open-t.nl",["ROLE_WF4P_ADMIN"]);
		setupService.addUser("john","test","John","john@open-t.nl",["Servicedesk","Customer service"]);
		
		
		xmlDocument="""<?xml version="1.0" encoding="UTF-8"?><test:Test xmlns:test="http://www.workflow4people.org/schemas/test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <doc:header xmlns:doc="http://www.workflow4people.org/schemas/documents">
			    <doc:documentId>1</doc:documentId>
			    <doc:documentType>StoringMelding</doc:documentType>
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
		
		xmlDocument="""<?xml version="1.0" encoding="UTF-8"?>	
<DDSDemo xmlns:m="http://www.workflow4people.org/schemas/model"
xmlns:doc="http://www.workflow4people.org/schemas/documents"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.workflow4people.org/schemas/model" xsi:schemaLocation="http://www.workflow4people.org/schemas/model ddsdemo.xsd">
		

	<doc:header>
	<doc:documentId>1</doc:documentId>
 	<doc:documentType>ddsdemo</doc:documentType>
	<doc:documentStatus>In behandeling</doc:documentStatus>
	<doc:documentKey></doc:documentKey>
	<doc:documentDescription></doc:documentDescription>
	<doc:workflowName>ddsdemo</doc:workflowName>
	<doc:taskId></doc:taskId>
	<doc:taskOutcome></doc:taskOutcome>
	<doc:processInstanceId></doc:processInstanceId>
	<doc:dateCreated>2010-01-01T00:00:00</doc:dateCreated>
	<doc:lastUpdated>2010-01-01T00:00:00</doc:lastUpdated>
	<doc:completionDate>2010-01-01T00:00:00</doc:completionDate>
	<doc:processingDays>0</doc:processingDays>
	  <doc:user>
			      <doc:name>test</doc:name>
			      <doc:displayName>Test User</doc:displayName>
			      <doc:email>test@open-t.nl</doc:email>
			    </doc:user>
	<doc:onbehalfof></doc:onbehalfof>
	<doc:group></doc:group>
	<doc:comments></doc:comments>
	<doc:forms></doc:forms>
	<doc:files></doc:files>
	<doc:cmis>
		<doc:folderObjectId></doc:folderObjectId>
		<doc:folderUrl></doc:folderUrl>
		<doc:path></doc:path>
	</doc:cmis>
	<doc:task>
		<doc:id></doc:id>
		<doc:name></doc:name>
		<doc:description></doc:description>
		<doc:outcome></doc:outcome>
		<doc:dueDate></doc:dueDate>
		<doc:priority></doc:priority>
		<doc:assignee></doc:assignee>
		<doc:status></doc:status>
		<doc:statusUser></doc:statusUser>
	</doc:task>
	<doc:remote>
		<doc:originator>tipp</doc:originator>
		<doc:recipients><doc:id>azm</doc:id><doc:id>tipp</doc:id></doc:recipients>
		<doc:cancelRecipients></doc:cancelRecipients>
		<doc:master>tipp</doc:master>
		<doc:masterDocumentId>tipp_1</doc:masterDocumentId>	
		<doc:remoteOutcome></doc:remoteOutcome>
	</doc:remote>
</doc:header>

	<m:respons></m:respons>

	<m:omschrijving></m:omschrijving>

	<m:ziekenhuis></m:ziekenhuis>

	<m:adres>
		
			<m:straatnaam></m:straatnaam>
		
			<m:huisnummer></m:huisnummer>
		
			<m:postcode>1234 AA</m:postcode>
		
			<m:plaatsnaam></m:plaatsnaam>
		
			<m:landnaam>Nederland</m:landnaam>
		
</m:adres>	
									
				
		
</DDSDemo>
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
		def wfpQueue=activeMQService.getQueue("wfpBroker","wfp.engine.jbpm4")
		println "WFP queue size: ${wfpQueue.getQueueSize()}"

		def eventTopic=activeMQService.getTopic("wfpBroker","wfp.event")
		println "Event topic size: ${eventTopic.getQueueSize()}"
	



		def sxmlDocument=documentService.getDocument(1)
		sxmlDocument.header.documentId=""
		//documentService.setDocument(sxmlDocument)
		documentService.createDocument(sxmlDocument)
		
		Document.findAll().each { doc ->
			println "document ${doc.id}"
		}
		log.debug "Taking a nap ..."
		Thread.sleep(6000)
		log.debug "Bye!"


		println "Event topic size: ${eventTopic.getQueueSize()}"
		println "Event enqueue count: ${eventTopic.getEnqueueCount()}"
		println "Event dequeue count: ${eventTopic.getDequeueCount()}"

		def ddsQueue=activeMQService.getQueue("ddsBroker","wfp.remote.tx")
		println "DDS queue size: ${ddsQueue.getQueueSize()}"
		println "DDS enqueue count: ${ddsQueue.getEnqueueCount()}"
		println "DDS dequeue count: ${ddsQueue.getDequeueCount()}"


		println "WFP queue size: ${wfpQueue.getQueueSize()}"
		println "WFP enqueue count: ${wfpQueue.getEnqueueCount()}"
		println "WFP dequeue count: ${wfpQueue.getDequeueCount()}"
		
		
		
//		println ddsQueue.browseMessages()


		println "Messages in DDS queue:"
		def compositeData = ddsQueue.browse()
		println "Size:${compositeData.size()}"
		compositeData.each { println it }
	
		
	}
}
