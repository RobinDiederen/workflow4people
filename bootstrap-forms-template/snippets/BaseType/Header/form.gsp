<table>
<tr>
  <td><f:message code="header.requester"/></td>
  <td>*{document.${formItem.field.gpath}.user.displayName.text()} (*{document.${formItem.field.gpath}.user.name.text()})</td>
</tr>

<tr>
  <td><f:message code="header.email"/></td>
  <td>*{document.${formItem.field.gpath}.user.email.text()}</td>
</tr>

<f:if test="*{document.header.task.id.text().length()==0}">
	<tr>
	  <td><f:message code="header.form.onbehalfof"/></td>
	  <td><form:input type="text" gpath="document.header.onbehalfof" value="*{document.header.onbehalfof}" /></td>
	</tr>
</f:if>

<f:if test="*{document.header.task.id.text().length()!=0}">
	<tr>
	  <td><f:message code="header.form.onbehalfof"/></td>
	  <td>*{document.header.onbehalfof}</td>
	</tr>
</f:if>

<f:if test="*{document.header.task.id.text().length()!=0}">
	<tr>
	  	<td><f:message code="header.request.date"/></td>
	  	<td>*{new java.text.SimpleDateFormat(g.message(code: 'output.date.format')).format(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(document.${formItem.field.gpath}.dateCreated.text()))}
	  </td>
	</tr>
</f:if>

<f:if test="*{document.header.task.id.text().length()!=0}">
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr class="section-head">
		<td colspan="2" style="font-weight:bold;"><f:message code="header.task.label"/></td>
	</tr>
	<tr>
  		<td><f:message code="header.task.status"/></td>
  		<td><form:select options="*{taskStatuses}" gpath="document.header.task.status" value="*{document.header.task.status}" /><f:if test="*{document.header.task.statusUser.text().size()!=0}"> (door *{document.header.task.statusUser})</f:if></td>
	</tr>
	<tr>
  		<td><f:message code="header.task.duedate"/></td>
  		<td><form:input class="fieldtype-Date" type="date" gpath="document.header.task.dueDate" value="*{document.header.task.dueDate}" /></td>
	</tr>
</f:if>

<f:if test="*{document.header.task.id.text().length()==0}">
	<input type="hidden" id="update-document.header.task.status" name="update-document.header.task.status" value="task-new" />
</f:if>
</table>