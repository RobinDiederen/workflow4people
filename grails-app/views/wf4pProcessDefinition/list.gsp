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
    <g:if test="${params.processDefinitionName}">
	    <span class="menuButton"><g:link class="awesome small blue button" action="list">&laquo; Latest process definitions</g:link></span>
    </g:if>
    <span class="menuButton"><g:link class="awesome small blue button" action="create">Install new process</g:link></span>
  </div>

  <div class="list">
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>          
          <th>Version</th>
          <th>Description</th>
          <th>Instances</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${processDefinitionList}" status="i" var="processDefinition">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${processDefinition.id}</td>
          <td>${processDefinition.name?.encodeAsHTML()}</td>
          <td>
          	<g:if test="${!params.processDefinitionName}">
          		<g:link action="list" params="[processDefinitionName: processDefinition.name]" title="Show version history">${processDefinition.version}</g:link>
          	</g:if>
          	<g:else>
          		${processDefinition.version}
          	</g:else>
          </td>
          <td>${processDefinition.description?.encodeAsHTML()}</td>
          <td><g:link class="awesome small blue button" action="show" params="[processDefinitionId:processDefinition.id]">instances &nbsp;&raquo;</g:link>
          	  <g:link class="awesome small blue button" controller="wf4pHistoryProcessInstance" action="list" id="${processDefinition.id}">history &nbsp;&raquo;</g:link>
          </td>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  
    <div class="paginateButtons">
        <g:if test="${!params.processDefinitionName}">
            <g:paginate total="${processDefinitionTotal}" />
        </g:if>
        <g:else>
            <g:paginate total="${processDefinitionTotal}" params="[processDefinitionName: params.processDefinitionName]" />
        </g:else>
    </div>
  
  </div>
</body>
</html>
