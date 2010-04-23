<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Process instances for process ${processDefinition.name} (${processDefinition.id})</title>
</head>
<body>
<div class="body">
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
  
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
    <span class="menuButton"><a class="processes" href="${createLink(controller:'wf4pProcessDefinition')}">Process Definitions</a></span>
    <span class="menuButton"><a class="new" href="${createLink(action:'create',params:[processName:processDefinition.name,processId:processDefinition.id])}">New process instance</a></span>
    <span><g:isLoggedIn><span class="user"><g:loggedInUserInfo field="username"/></span> 
    <span class="logout"><a href="/workflow4people/logout">logout<a/></span></g:isLoggedIn></span>
        
  </div>
  <div class="list">
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>State</th>
          <th>Ended</th>
          <th>Executions</th>
          <th>Active activities</th>
          <th>-</th>
          <th>Details</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${processInstanceList}" status="i" var="instance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${instance.getId()}</td>
          <td>${instance.state}</td>
          <td>${instance.isEnded()}</td>

          <td>${instance.executionsMap}</td>          
          <td>${instance.findActiveActivityNames()}</td>
          <td></td>

 		  <td><g:link action="show" params="[processInstanceId:instance.id]">Details &gt;&gt;&gt;</g:link></td>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  </div>
</body>
</html>
