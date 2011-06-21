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
package org.workflow4people
import grails.plugins.springsecurity.Secured


import org.jbpm.api.task.*;
import org.jbpm.api.*;
import org.springframework.beans.factory.InitializingBean;
/**
 * Controller for WfpVariable domain class
 * 
 * @author Joost Horward
 */
@Secured(['ROLE_WF4P_ADMIN','ROLE_WF4P_PROCESS_ADMIN','ROLE_WF4P_DEVELOPER'])
class Wf4pVariableController implements InitializingBean{
	
	def processEngine
	ExecutionService executionService
	
	void afterPropertiesSet() {
		executionService=processEngine.getExecutionService()
		
	}

    def index = { }
    
    def create = {    
	}
	
	def edit = {    		
		def theVariable=executionService.getVariable(params.processInstanceId, params.variableName)    		
    	def theParams=['variableName':params.variableName,'variableValue':theVariable.toString(),'variableClassName':theVariable.class.name]
    	render(view:'create',model: ['variableName':params.variableName,'variableValue':theVariable,'variableClassName':theVariable.class.name])
	}
    
    def save = {
		println(params)
		switch (params.variableClassName) {		
		
		case 'java.lang.Byte':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue.asType(java.lang.Byte))
			break
		case 'java.lang.Character':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue.asType(java.lang.Character))
			break
		case 'java.lang.Date':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue.asType(java.lang.Date))
			break
		case 'java.lang.Double':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue.asType(java.lang.Double))
			break	
		case 'java.lang.Float':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue.asType(java.lang.Float))
			break			
		case 'java.lang.String':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue)
			break
		case 'java.lang.Integer':			
			executionService.setVariable(params.processInstanceId, params.variableName,params.variableValue.asType(java.lang.Integer))
			break
		case 'java.lang.Long':			
			executionService.setVariable(params.processInstanceId, params.variableName, params.variableValue.asType(java.lang.Long))
			break
		}		    		
		redirect(controller:'wf4pProcessInstance',action:'show',params:params)
    }
    
}
