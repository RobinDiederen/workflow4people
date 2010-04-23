<?xml version="1.0" ?>
<taskInstanceList>
<g:each in="${tasks}" var="${task}" >
  <taskInstance>
    <processName>${task.getProcessInstance().getProcessDefinition().getName()}</processName>
    <processId>${task.getProcessInstance().getId()}</processId>
    <id>${task.getId()}</id>
    <name>${task.getName()}</name>          
    <start>${task.getStart()}</start>
    <dueDate>${task.getDueDate()}</dueDate>
    <priority>${task.getPriority()}</priority>
    <description>${task.getDescription()}</description>
    <isSignalling>${task.isSignalling()}</isSignalling>
	<transitions><g:each in="${task.getAvailableTransitions()}" var="transition" >
      <transition>${transition.getName()}</transition></g:each>
    </transitions>    
  </taskInstance>
</g:each>
</taskInstanceList>
