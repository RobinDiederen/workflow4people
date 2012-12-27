<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Process Definitions</title>
</head>
<body>
  <div class="body">
  	<div class="navbar">
			<div class="navbar-inner">			
				<ul class="nav">	        	
    				<g:if test="${params.processDefinitionName}">
	    				<li><g:link class="awesome small blue button" action="list">&laquo; Latest process definitions</g:link></li>
    				</g:if>
    				<li><g:link class="awesome small blue button" action="create">Install new process</g:link></li>
  			</div>
	</div>
  <div class="list">
  <h4>Process definitions</h4>
    <table class="table table-striped table-bordered">
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
          <td><div class="btn-group"><g:link class="btn btn-small" action="show" params="[processDefinitionId:processDefinition.id]">instances &nbsp;&raquo;</g:link>
          	  <g:link class="btn btn-small" controller="wf4pHistoryProcessInstance" action="list" id="${processDefinition.id}">history &nbsp;&raquo;</g:link></div>
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
