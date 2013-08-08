package org.workflow4people.activiti;

import org.activiti.engine.impl.bpmn.parser.handler.AbstractBpmnParseHandler;
import org.activiti.engine.impl.history.handler.UserTaskAssignmentHandler;

import org.activiti.engine.impl.history.handler.UserTaskIdHandler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.UserTask;
import org.activiti.bpmn.model.Process
import org.activiti.engine.impl.bpmn.parser.BpmnParse;

import org.activiti.engine.impl.bpmn.parser.handler.ProcessParseHandler
import org.activiti.engine.impl.task.TaskDefinition;

import org.workflow4people.SpringUtil;
import org.activiti.engine.repository.ProcessDefinition
import org.activiti.engine.parse.BpmnParseHandler
import org.activiti.engine.runtime.Execution
import org.apache.commons.logging.LogFactory

public class WfpExecutionParseHandler extends AbstractBpmnParseHandler<Process> {
    private static final log = LogFactory.getLog(this)
    
    protected Class< ? extends BaseElement> getHandledType() {
        return Process.class;
    }
    
    protected void executeParse(BpmnParse bpmnParse, Process process) {
        ProcessDefinition  processDefinition = bpmnParse.getCurrentProcessDefinition()
       
        log.trace "We are parsing a process: ${processDefinition}"
        processDefinition.addExecutionListener(org.activiti.engine.impl.pvm.PvmEvent.EVENTNAME_END, SpringUtil.getBean("activitiService").endExecutionListener);
    }    
}
