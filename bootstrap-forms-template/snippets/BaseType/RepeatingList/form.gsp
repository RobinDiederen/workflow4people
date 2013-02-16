<f:javascript>
  $(document).ready(function() {
    
    var maxDocument${listGpath} = *{document.${listGpath}.size() - 1};
    
    $('.document-${listGpath}-insert').click( function() {
      maxDocument${listGpath}++;
	    var listIndex = this.id.substring(this.id.indexOf('_') + 1, this.id.length);
      
      $.getJSON(this.href, function(data) {
        var clonedTr = $('#tr-document-${listGpath}_' + listIndex).clone(true);
        clonedTr.find('*[id]').andSelf().each(function() {
          if ($(this).attr('id').indexOf('[') >= 0) {
            $(this).attr('id', $(this).attr('id').replace('[' + listIndex + ']', '[' + maxDocument${listGpath}.toString() + ']'));
          
            if (typeof $(this).attr('name') != 'undefined' && $(this).attr('name') != false) {
              $(this).attr('name', $(this).attr('name').replace('[' + listIndex + ']', '[' + maxDocument${listGpath}.toString() + ']'));
            }
          }
          
          if ($(this).attr('id').indexOf('_') >= 0) {
            $(this).attr('id', $(this).attr('id').substring(0, $(this).attr('id').indexOf('_') + 1) + maxDocument${listGpath}.toString());
            
            if (typeof $(this).attr('name') != 'undefined' && $(this).attr('name') != false) {
              $(this).attr('name', $(this).attr('name').substring(0, $(this).attr('name').indexOf('_') + 1) + maxDocument${listGpath}.toString());
            }
            
            if (typeof $(this).attr('href') != 'undefined' && $(this).attr('href') != false) {
              $(this).attr('href', $(this).attr('href').replace('[' + listIndex + ']', '[' + $('#table-document-${listGpath} tbody tr').length.toString() + ']'));
            }
          }
        });
        $('#table-document-${listGpath} tbody').append(clonedTr);
        
        $('#table-document-zorgProducten tbody').find('.fieldtype-Date').each(function() {
          $(this)
            .removeClass('hasDatepicker')
		        .unbind()
		        .datepicker("destroy");
          var updateId = $(this).attr('id').replace("hidden-","update-").replace(/\./g, "\\.").replace(/\[/g, "\\[").replace(/\]/g, "\\]");
          $(this).datepicker({showOn:'focus', altField: '#' + updateId, altFormat: "yy-mm-dd"}).focus();
        });
      });
      
      return false;
    });
  
    $('.document-${listGpath}-delete').click( function() {
	    if ($('#table-document-${listGpath} tbody tr').length > 1) {
	      var listIndex = this.id.substring(this.id.indexOf('_') + 1, this.id.length);
	      
	      $.getJSON(this.href, function(data) {
	        $('#tr-document-${listGpath}_' + listIndex).remove();
	      });
	    }
	    
	    return false;
    });
  
  });
</f:javascript>

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
        <a id="a-document-${listGpath}-insert_*{${name}Index}" href="/forms/form/jsonAppendNode/${workflow.name}/${form.name}?gpath=document&node=${field.builderSnippet}" class="action action-insert help document-${listGpath}-insert" title="Toevoegen|Klik hier om een regel aan de producten lijst toe te voegen">&nbsp;</a>&nbsp;
        <a id="a-document-${listGpath}-delete_*{${name}Index}" href="/forms/form/jsonDeleteNode/${workflow.name}/${form.name}?gpath=document.${gpathExpr.substring(0, gpathExpr.indexOf('['))}[*{${name}Index}]" class="action action-delete help document-${listGpath}-delete" title="Verwijderen|Klik hier om deze regel uit de producten lijst te verwijderen">&nbsp;</a>
        </div>
      </center>
      </td>
    </tr>
    </f:each>
  </tbody>

</table>
