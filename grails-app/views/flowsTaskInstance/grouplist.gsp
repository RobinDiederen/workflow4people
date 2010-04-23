<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Task instances for pooled actor '${params.pooledActorId}'</title>
</head>
<body>
 <div class="body">
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
    <span class="menuButton">Pooled Actor: <g:select name="pooledActorId" from="${knownPooledActors}" onChange="location.href='?pooledActorId='+this.value" value="${params.pooledActorId}"/></span>       
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
          <td>${taskInstance.getAvailableTransitions()}</td>
          <td><a href="${createLink(action:'assignactor',params:[taskInstanceId:taskInstance.getId()])}">[assign]</a></td>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  </div>
</body>
</html>
