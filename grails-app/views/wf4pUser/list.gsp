<html>
<head>
  <meta name="layout" content="main" />  
  <title>User list</title>
</head>
<body>
<div class="body">
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>  
  <div class="nav">
    <span class="menuButton"><a class="new" href="${createLink(action:'create')}">New user</a></span>    
  </div>
  <div class="list">
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>Given name</th>
          <th>Family name</th>
          <th>Business Email</th>          
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${userList}" status="i" var="user">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${user.id}</td>
          <td>${user.givenName}</td>
          <td>${user.familyName}</td>
		  <td>${user.businessEmail}</td>         
 		  <td><g:link action="show" params="['id':user.id]">[show details]</g:link>&nbsp;<g:link action="edit" params="['id':user.id]">[edit]</g:link>&nbsp;<g:link class="confirm" action="delete" params="['id':user.id]">[delete]</g:link>
 		  </td>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  </div>
</body>
</html>
