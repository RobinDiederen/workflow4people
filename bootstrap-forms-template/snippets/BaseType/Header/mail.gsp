<tr>
  <td>Aanvrager</td>
  <td>*{document.${formItem.field.gpath}.user.displayName.text()} (*{document.${formItem.field.gpath}.user.name.text()})</td>
</tr>
<tr>
  <td>E-mail</td>
  <td>*{document.${formItem.field.gpath}.user.email.text()}</td>
</tr>
<tr>
  <td>Namens</td>
  <td>*{document.${formItem.field.gpath}.onbehalfof.text()}</td>
</tr>
<tr>
  <td>Aanvraag datum</td>
  <td>*{new java.text.SimpleDateFormat(g.message(code: 'output.date.format')).format(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(document.${formItem.field.gpath}.dateCreated.text()))}</td>
</tr>
<tr>
  <td>Huidige status</td>
  <td>*{document.${formItem.field.gpath}.documentStatus.text()}</td>
</tr>