<w:snippet type="Default" name="labelwrapper" label="Aanvrager" >
*{document.${formItem.field.gpath}.user.displayName.text()} (*{document.${formItem.field.gpath}.user.name.text()})
</w:snippet>

<w:snippet type="Default" name="labelwrapper" label="E-mail" >
*{document.${formItem.field.gpath}.user.email.text()}
</w:snippet>

<w:snippet type="Default" name="labelwrapper" label="Datum" >
*{new java.text.SimpleDateFormat(g.message(code: 'output.date.format')).format(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(document.${formItem.field.gpath}.dateCreated.text()))}
</w:snippet>


<f:if test="*{document.header.task.id.text().length()!=0}">
<%--
<w:snippet type="Default" name="labelwrapper" label="Taak status" >
*{taskStatuses[document.header.task.status]}<f:if test="*{document.header.task.statusUser.text().size()!=0}"> (door *{document.header.task.statusUser})</f:if>
</w:snippet>
--%>
<w:snippet type="Default" name="labelwrapper" label="Uiterste datum" >
*{new java.text.SimpleDateFormat(g.message(code: 'output.date.format')).format(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(document.header?.task?.dueDate?.text()))}
</w:snippet>
</f:if>
