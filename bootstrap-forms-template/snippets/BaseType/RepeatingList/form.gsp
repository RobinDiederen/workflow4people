<table id="table-document-${listGpath}" class="table table-striped table-bordered">
  
  <thead>
	  <tr>
	    <g:each in="${field.children}" var="theField">
	    <th>${theField.label}</th>
		  </g:each>
		  <th>Acties</th>
	  </tr>
  </thead>
  
  <tbody>
    <f:each in="*{document.${listGpath}}" var="${name}Instance" status="${name}Index">
    <tr id="tr-document-${listGpath}_*{${name}Index}">
      <g:each in="${field.children}" var="theField">
      <td>
        <w:snippet var="${theField}" name="form" />
      </td>
      </g:each>
      <td width="100">
	  <center>
	  <div class="dialog-horizontal-wrapper">
        <a parentid="table-document-${listGpath}" id="a-document-${listGpath}-insert_*{${name}Index}" href="/forms/form/insertNode/${workflow.name}/${form.name}?gpath=document.${gpathExpr.substring(0, gpathExpr.indexOf('['))}[*{${name}Index}]&node=${field.builderSnippet}" class="action action-insert help document-${listGpath}-insert" title="Toevoegen|Klik hier om een regel aan de producten lijst toe te voegen">&nbsp;</a>&nbsp;
        <a parentid="table-document-${listGpath}" id="a-document-${listGpath}-delete_*{${name}Index}" href="/forms/form/deleteNode/${workflow.name}/${form.name}?gpath=document.${gpathExpr.substring(0, gpathExpr.indexOf('['))}[*{${name}Index}]" class="action action-delete help document-${listGpath}-delete" title="Verwijderen|Klik hier om deze regel uit de producten lijst te verwijderen">&nbsp;</a>
        </div>
      </center>
      </td>
    </tr>
    </f:each>
  </tbody>

</table>
