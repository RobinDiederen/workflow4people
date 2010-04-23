<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Task instances for actor '${params.actorId}'</title>
</head>
<body>
<div class="body">
  <div class="nav">     
    <span class="menuButton">Actor: <g:select name="actorId" from="${knownActors}" onChange="location.href='?actorId='+this.value" value="${params.actorId}"/></span>      
  </div>
  
 
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
        <tr>
          <th>Process name</th>
          <th>Process #</th>
          <th>Task name</th>
          <th>Task #</th>
          <th>Start date</th>
          <th>Due date</th>
          <th>Priority</th>
          <th>Description</th>
          <th>Signalling</th>
          <th>Transitions</th>
          <th>Actions</th>
          <th>Pooled actors</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${taskInstances}" status="i" var="taskInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${taskInstance.getProcessInstance().getProcessDefinition().getName()}</td>
          <td>${taskInstance.getProcessInstance().getId()}</td>
          <td>${taskInstance.getName()}</td>
          <td>${taskInstance.getId()}</td>
          <td>${taskInstance.getStart()}</td>
          <td>${taskInstance.getDueDate()}</td>
          <td>${taskInstance.getPriority()}</td>
          <td>${taskInstance.getDescription()}</td>
          <td>${taskInstance.isSignalling()}</td>
          <td><g:each in="${taskInstance.getAvailableTransitions()}" var="transition" >
          <a href="${createLink(action:'end',params:[taskInstanceId:taskInstance.getId(),transitionName:transition.getName()])}">[${transition.getName()}]</a>&nbsp;
          </g:each>
          </td>
          
          
          <td><a href="${createLink(action:'assignactor',params:[taskInstanceId:taskInstance.getId()])}">[reassign]</a></td>
          <td>${taskInstance.getPooledActors()}</td>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  </div>
</body>
</html>
