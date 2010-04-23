<html>
<head>
  <meta name="layout" content="main" />  
  <title>Group list</title>
</head>
<body>
<div class="body">
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>  
  <div class="nav">
  	
    <span class="menuButton"><a class="new" href="${createLink(action:'create')}">New group</a></span>    
  </div>
  <div class="list">
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Type</th>          
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${groupList}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${group.id}</td>
          <td>${group.name}</td>
          <td>${group.type}</td>
 		  <td>
 		  <g:link action="show" params="['id':group.id]">[show details]</g:link>
 		  <g:link class="confirm" action="delete" params="['id':group.id]">[delete]</g:link>
 		  </td>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  </div>
</body>
</html>
