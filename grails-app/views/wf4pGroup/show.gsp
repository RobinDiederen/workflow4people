<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>Group details for group &quot;${group.name}&quot;</title>
</head>
<body>
<div class="body">
  
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
   
  
  <div class="nav">&nbsp;
        
  </div>  
                <div class="dialog">
                
                    <table>
                        <tbody>                      
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Group id:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${group.id}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Group name:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${group.name}
                                </td>
                            </tr>
                     	</tbody>
                    </table>
                </div>
                
				<h1>Group members</h1>
                <div class="list" >
                
				    <table>
				      <thead>
				        <tr>
				          <th>Id</th>
				          <th>Given name</th>
				          <th>Family name</th>
				          <th>Business e-mail</th>				          
				          <th>Action</th>
				        </tr>
				      </thead>
				      <tbody>
				        
				        <g:each status="i" in="${memberList}" var="member">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				          <td>${member.id}</td>
				          <td>${member.givenName}</td>
				          <td>${member.familyName}</td>
				          <td>${member.businessEmail}</td>				          
				          <td><g:link class="confirm" action="deletemember" params="[id:member.id,groupId:group.id]">[delete]</g:link></td>				          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>
			<div class="dialog">	
			<g:form action="addmember" method="post">
				<input type="hidden" name="groupId" value="${group.id}" />
				Add user: <g:select name="newMember" optionKey="${{it.getId()}}" optionValue="${{givenName} {familyName}}" from="${userList}"/>
				
				<g:submitButton name="addmember" class="save" value="Add!" />
			</g:form>
			</div>
  </div>
</body>
</html>
