import org.workflow4people.util.*;
import org.apache.activemq.*
import org.codehaus.groovy.grails.orm.hibernate.HibernateEventListeners
// Place your Spring DSL code here

beans = {
	myPropertyEditorRegistrar(MyPropertyEditorRegistrar.class) {}
	
	jmsConnectionFactory(ActiveMQConnectionFactory) {
		brokerURL = "tcp://localhost:61616"
	}

	eventListener(org.workflow4people.EventListener) {
		jmsService = ref("jmsService")

	}
	
	hibernateEventListeners(HibernateEventListeners) {
	    listenerMap = ['post-commit-insert':eventListener,'post-commit-update':eventListener]
	                   
	}	
}

