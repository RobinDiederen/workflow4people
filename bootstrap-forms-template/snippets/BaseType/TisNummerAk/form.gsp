<form:input type="text" 
			class="${field.nillable ? '' : 'required'} fieldtype-${fieldTypeName} field-${name} ${field.dependencySource ? 'dependency-source' : ''}" 
			regexp="${pattern}" 
			minlength="${minLength}"
			maxlength="${maxLength}"
			 
			min="${minInclusive}" 
			max="${maxInclusive}"
			
			minexcl="${minExclusive}" 
			maxexcl="${maxExclusive}"
			
			depends-on="update-document.${field.dependsOn?.gpath}"
			dependency-type="${field.dependencyType}"
			dependency-parameter="${field.dependencyParameter}"
			
			gpath="document.${gpathExpr}"  value="\${document.${gpath}}" helpTitle="${label}" helpBody="${help}" title ="${alert}" 			
			
			/>
        
<f:javascript>
  
  $(document).ready(function () {

    $('#update-document\\.akKlant\\.tisNummer').change(function() {
          
      if ($('#update-document\\.akKlant\\.tisNummer').val() != '') {
        
        var jsonRequestObj = 
        {
          'tisNummer': $('#update-document\\.akKlant\\.tisNummer').val()
        };
        
        jQuery.ajax({
          url: '/forms/rest/tis/queryClientCompleet',
          type: "POST",
          data: JSON.stringify(jsonRequestObj),
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          beforeSend: function(x) {
            if (x && x.overrideMimeType) {
              x.overrideMimeType("application/j-son;charset=UTF-8");
            }
            startSpinner();
          },
          complete: function(x) {
            stopSpinner();
          },
          success: function(json) {
            $('#update-document\\.akKlant\\.geboortenaam').val(json.client.naam.geboortenaam);
            $('#update-document\\.akKlant\\.naamPartner').val(json.partner.naam.achternaam);
            $('#update-document\\.akKlant\\.adres').val(json.client.adres.straatnaam + ' ' + json.client.adres.huisnummer + ' ' + json.client.adres.huisnummerToevoeging);
            $('#update-document\\.akKlant\\.postcode').val(json.client.adres.postcode);
            $('#update-document\\.akKlant\\.woonplaats').val(json.client.adres.plaatsnaam);
            $('select[name="update-document\\.akKlant\\.geslacht"]').val(json.client.geslacht);
            $('#update-document\\.akKlant\\.geboortedatum').val(json.client.geboortedatum);
            $('#update-document\\.akKlant\\.bsn').val(json.client.bsn);
          }
        }); 
        
      }
      else {
        $("input[id ^= 'update-document\\.akKlant\\.']").val('');
      }
      
    });
  
  });
  
</f:javascript>
