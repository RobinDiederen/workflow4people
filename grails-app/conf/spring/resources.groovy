//import org.workflow4people.util.*;
import org.open_t.dialog.*;
import org.apache.activemq.*
import org.codehaus.groovy.grails.orm.hibernate.HibernateEventListeners

import org.activiti.spring.ProcessEngineFactoryBean
import org.activiti.engine.runtime.ProcessInstance
import org.activiti.engine.task.Task
import grails.util.GrailsNameUtils
import grails.util.Environment
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.codehaus.groovy.grails.commons.ControllerArtefactHandler
import org.workflow4people.activiti.WfpUserTaskParseHandler

//import org.springframework.core.io.Resource
//import org.grails.activiti.ActivitiConstants
//import org.grails.activiti.serializable.SerializableVariableType


// Place your Spring DSL code here

beans = {
	myPropertyEditorRegistrar(MyPropertyEditorRegistrar.class) {}
	
	jmsConnectionFactory(ActiveMQConnectionFactory) {
		brokerURL = "tcp://localhost:61616"
	}
	
	ddsConnectionFactory(ActiveMQConnectionFactory) {
		brokerURL = "tcp://localhost:61617"
	}

	eventListener(org.workflow4people.EventListener) {
		jmsService = ref("jmsService")

	}
	
	hibernateEventListeners(HibernateEventListeners) {
	    listenerMap = ['post-commit-insert':eventListener,'post-commit-update':eventListener]
	                   
	}
	
	
	cmisServiceProxy(org.springframework.aop.scope.ScopedProxyFactoryBean) {
		targetBeanName = 'cmisService'
		proxyTargetClass = true
   }
	
   /* activiti */
	wfpUserTaskParseHandler(org.workflow4people.activiti.WfpUserTaskParseHandler)
	
	activitiProcessEngineConfiguration(org.activiti.spring.SpringProcessEngineConfiguration) {
		processEngineName = "activiti"
		if (grails.util.GrailsUtil.environment=="test") {
			databaseType = "h2"
		} else {
			databaseType = "mysql"
		}
		
		
		databaseSchemaUpdate = "true"
		deploymentName = "ActivitiAutoDeploy"
		  
		//deploymentResources = CH.config.activiti.deploymentResources?:ActivitiConstants.DEFAULT_DEPLOYMENT_RESOURCES
		jobExecutorActivate = false
		history = "audit"
		mailServerHost = "localhost"
		mailServerPort = 25
		mailServerUsername = ""
		mailServerPassword = ""
		mailServerDefaultFrom = "info@open-t.nl"
		dataSource = ref("dataSource")
		
		// These add event listeners for process instance and task creation
		
		postBpmnParseHandlers = [
			//wfpUserTaskParseHandler(org.workflow4people.activiti.WfpUserTaskParseHandler),
			//wfpUserTaskParseHandler2(org.workflow4people.activiti.WfpUserTaskParseHandler)
			ref("wfpUserTaskParseHandler")
			//org.workflow4people.activiti.WfpProcessParseHandler
		]
		
		
		transactionManager = ref("transactionManager")

			  // Define custom serializable types for fix issue with serialization
			  //customPreVariableTypes = [new SerializableVariableType()]
		 }
		  
			activitiProcessEngine(org.activiti.spring.ProcessEngineFactoryBean) {
				processEngineConfiguration = ref("activitiProcessEngineConfiguration")
			}
  
		  activitiRuntimeService(activitiProcessEngine:"getRuntimeService")
		  activitiRepositoryService(activitiProcessEngine:"getRepositoryService")
		  activitiTaskService(activitiProcessEngine:"getTaskService")
		  activitiManagementService(activitiProcessEngine:"getManagementService")
		  activitiIdentityService(activitiProcessEngine:"getIdentityService")
		  activitiHistoryService(activitiProcessEngine:"getHistoryService")
		  activitiFormService(activitiProcessEngine:"getFormService")
				  
}
