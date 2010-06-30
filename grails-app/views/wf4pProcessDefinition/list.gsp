<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Process Definitions</title>
</head>
<body>
  <div class="body">
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
  <div class="nav">
    <span class="menuButton"><g:link class="awesome small blue button" action="create">Install new process</g:link></span>
  </div>

  <div class="list">
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>          
          <th>Version</th>

          <%--  TODO put this back when jBPM starts to support persistance of this field
          <th>Description</th>
          --%>
          <th>Instances</th>
                    
        </tr>
      </thead>
      <tbody>
        <g:each in="${processDefinitionList}" status="i" var="processDefinition">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${processDefinition.id}</td>
          <td>${processDefinition.name?.encodeAsHTML()}</td>
          <td>${processDefinition.version}</td>          
          <%--  TODO put this back when jBPM starts to support persistance of this field           
          <td>${processDefinition.description?.encodeAsHTML()}</td> 
          --%>
          <td><g:link class="awesome small blue button" action="show" params="[processDefinitionId:processDefinition.id]">instances &nbsp;&raquo;</g:link>
          	  <g:link class="awesome small blue button" controller="wf4pHistoryProcessInstance" action="list" id="${processDefinition.id}">history &nbsp;&raquo;</g:link>
          
          </td>          
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  
    <div class="paginateButtons">
                	<g:paginate total="${processDefinitionTotal}" />
    </div>
  
  </div>
</body>
</html>
