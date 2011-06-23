package org.workflow4people

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ApplicationHolder

class RestController {

    def index = { }
    
    //def restget = { }
    
    def restpost = {
    	def responseMap = [:]
    	
    	if (request.method == "POST") {
          println "REST server has been initialized through the REST service using the POST method\n"

          def input = request.JSON
          def inputJSON = input as JSON
          def action = params.serviceaction

          boolean foundService = false

          ApplicationHolder.application.serviceClasses.find { def serviceClass ->
              try {
                  def field = serviceClass.clazz.getField("wfpService")
                  if (field && field.get(null).equals(params.service)) {
                      foundService = true
                      
                      println "RESTP - instantiate the service class '${serviceClass.clazz.getName()}' ..."
                      def serviceClassInstance = this.class.classLoader.loadClass(serviceClass.clazz.getName()).newInstance()
                      
                      try {
                          println "RESTP - invoke method '${action}' on '${serviceClass.clazz.getName()}' instance ..."
                          def serviceResult = serviceClassInstance."${action}"(inputJSON as String)
                          println "RESTP - render result as JSON."
                          render serviceResult as JSON
                      }
                      catch (NoSuchMethodException e) {
                          println "RESTP - action '${action}' of service '${params.service}' does not exist!"
                      }
                      return true
                  }
                  else {
                      //wrong service class..., go to next service class...
                      return false
                  }
              }
              catch (Exception e) {
                  if (foundService) {
                      println "RESTP - error while invoking service method (${e})"
                  }
                  else {
                      //wrong service class..., go to next service class...
                      return false
                  }
              }
          }

			if (!foundService) {
				throw Exception("Service '${params.service}' does not exist!")
			}

    	} else {
    		println "Wrong request method received, should be POST, requested method was " + request.method + "\n"
    	}
    }
}
