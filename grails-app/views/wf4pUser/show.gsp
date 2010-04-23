<html>
<head>
  <meta name="layout" content="main" />
  <meta name="tabname" content="process" />
  <title>User details for user &quot;${user.id}&quot;</title>
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
                                    <label for="customer">User id:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${user.id}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Given name:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${user.givenName}
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Family name:</label>
                                </td>
                                <td valign="top" class="value">
                                    ${user.familyName}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer">Business e-mail</label>
                                </td>
                                <td valign="top" class="value">
                                    ${user.businessEmail}
                                </td>
                            </tr>                            
                            
                     	</tbody>
                    </table>
                </div>
                
                <h1>Groups</h1>

                <div class="list" >
				    <table>
				      <thead>
				        <tr>
				          <th>Id</th>				          				          
				          <th>Name</th>
				        </tr>
				      </thead>
				      <tbody>
				        
				        <g:each status="i" in="${memberList}" var="member">
				        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				          <td>${member.id}</td>
				          <td>${member.name}</td>
				          				          
				          <td><g:link class="confirm" action="deletemember" params="[id:user.id,groupId:member.id]">[delete]</g:link></td>				          
				        </tr>
				        </g:each>
				      </tbody>
				    </table>
				</div>
			<div class="dialog">	
			<g:form action="addmember" method="post">
				<input type="hidden" name="userId" value="${user.id}" />
				Add group: <g:select name="newMember" optionKey="${{it.getId()}}" optionValue="name" from="${groupList}"/>
				
				<g:submitButton name="addmember" class="save" value="Add!" />
			</g:form>
			</div>
  </div>
</body>
</html>
