package org.workflow4people.activiti;


import org.activiti.engine.impl.bpmn.parser.handler.AbstractBpmnParseHandler;
import org.activiti.engine.impl.history.handler.UserTaskAssignmentHandler;

import org.activiti.engine.impl.history.handler.UserTaskIdHandler;

import org.activiti.bpmn.model.BaseElement;
import org.activiti.bpmn.model.UserTask;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.impl.bpmn.parser.handler.UserTaskParseHandler;
import org.activiti.engine.delegate.TaskListener;

import org.workflow4people.SpringUtil;

public class WfpUserTaskParseHandler extends AbstractBpmnParseHandler<UserTask> {

	protected static final UserTaskAssignmentHandler USER_TASK_ASSIGNMENT_HANDLER = new UserTaskAssignmentHandler();
	
	  protected static final UserTaskIdHandler USER_TASK_ID_HANDLER = new UserTaskIdHandler();
	
	  protected Class< ? extends BaseElement> getHandledType() {
		return UserTask.class;
	  }
	
	  protected void executeParse(BpmnParse bpmnParse, UserTask element) {
		TaskDefinition taskDefinition = (TaskDefinition) bpmnParse.getCurrentActivity().getProperty(UserTaskParseHandler.PROPERTY_TASK_DEFINITION);
		println "We are parsing a task: ${taskDefinition}"
		
		
		
		//taskDefinition.addTaskListener(TaskListener.EVENTNAME_ASSIGNMENT, USER_TASK_ASSIGNMENT_HANDLER);
		
		taskDefinition.addTaskListener(TaskListener.EVENTNAME_CREATE, SpringUtil.getBean("activitiService").createTaskLister);
		taskDefinition.addTaskListener(TaskListener.EVENTNAME_COMPLETE, , SpringUtil.getBean("activitiService").completeTaskLister);
	  }	
}
