<tr>
    <td>TIS nummer cli&#235;nt</td>
    <td style="min-width: 450px;">
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <input class="meander-tis-client-tisNummer-value required" maxlength="6" name="update-document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer" title="Het TIS nummer van de cli&#235;nt mag niet leeg zijn." type="text" />&nbsp;<a class="help-icon help action" title="TIS nummer cli&#235;nt|Vul het TIS nummer van de cli&#235;nt in." href="#">&nbsp;</a>
                    <f:javascript>
                      
                      $(document).ready(function () {
							$('.disabled').hide();
		                    
		                    currectZorgproductenTable=$('#meander-tis-client-current-zorgproducten-table').dataTable( {
		                      "bFilter": false,
		                      "bJQueryUI": true,
		                      "bInfo": false,
		                      "aoColumnDefs": [
			                      { "bSortable": false, "aTargets": [ 0 ] } ,
			                      { "bSortable": false, "aTargets": [ 1 ] } ,
			                      { "bSortable": false, "aTargets": [ 2 ] } ,
			                      { "bSortable": false, "aTargets": [ 3 ] } ,
			                      { "bSortable": false, "aTargets": [ 4 ] } ,
			                      { "bSortable": false, "aTargets": [ 5 ] } ,
			                      { "bSortable": false, "aTargets": [ 6 ] } ,
			                      { "bSortable": false, "aTargets": [ 7 ] }
		                      ],
                          "bLengthChange": false,
                          "bPaginate": false,
                          "iDisplayLength": 10,
		                      "oLanguage": {
                            "sUrl": "/forms/js/jquery/dataTables/localisation/dataTables.${java.util.Locale.getDefault().getLanguage()}.txt"
                          }		
	                      } );
                      
		                    recentDocumentsTable=$('#meander-tis-client-recent-documents-table').dataTable( {
		                      "bProcessing": true,
		                      "bServerSide": true,
		                      "sAjaxSource": "/forms/search/myformsJSON?newtarget=true",
		                      "sPaginationType": "full_numbers",
		                      "bFilter": false,
		                      "bInfo": false,
		                      "bJQueryUI": true,
		                      "aaSorting": [[4,'desc']],
		                      "aoColumnDefs": [
			                      { "bSortable": false, "aTargets": [ 1 ] } ,
			                      { "bSortable": false, "aTargets": [ 6 ] }
		                      ],
                          "bLengthChange": false,
                          "bPaginate": false,
                          "iDisplayLength": 10,
		                      "oLanguage": {
                            "sUrl": "/forms/js/jquery/dataTables/localisation/dataTables.${java.util.Locale.getDefault().getLanguage()}.txt"
                          },
		
		                      "fnServerData": function ( sSource, aoData, fnCallback ) {
			                      /* Add some extra data to the sender */
			                      var fullQuery = "tisNummer:" + $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').val();
                            var date6MonthsBackFromNow = new Date((new Date()).getTime() - (182*24*60*60*1000));
                            var tomorrow = new Date((new Date()).getTime() + (24*60*60*1000));
			                      if (fullQuery != "") {
                              fullQuery += " AND ";
                            }
			                      fullQuery += "dateCreated:[" + date6MonthsBackFromNow.getFullYear() + "-" + ((date6MonthsBackFromNow.getMonth()+1) < 10 ? "0" : "") + (date6MonthsBackFromNow.getMonth()+1) + "-" + (date6MonthsBackFromNow.getDate() < 10 ? "0" : "") + (date6MonthsBackFromNow.getDate()) + " TO " + tomorrow.getFullYear() + "-" + ((tomorrow.getMonth()+1) < 10 ? "0" : "") + (tomorrow.getMonth()+1) + "-" + (tomorrow.getDate() < 10 ? "0" : "") + (tomorrow.getDate()) + "]";
			
			                      aoData.push( { "name": "query", "value": fullQuery } );
			
			                      $.getJSON( sSource, aoData, function (json) { 
				                      /* Do whatever additional processing you want on the callback, then tell DataTables */
				                      fnCallback(json)
			                      } );
		                      }
		
	                      } );
                      
                        <f:if test="\${document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer.text().size() <= 0}">
                        
                        $('.tr-meander-tis-client-value').hide();
                        $('.meander-tis-client-correction-switcher').toggle();
                        
                        </f:if>
                      
                        <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.text().size() > 0}">
                        
                        $('.meander-tis-client-toggle').toggle();
                        
                        </f:if>
                        
                        $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').change(function() {
                          
                          $('.meander-tis-client-value').html('');
                          $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatiePV').html('?');
                          $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatieVP').html('?');
                          currectZorgproductenTable.fnClearTable();
                          recentDocumentsTable.fnClearTable();
                              
                          if ($('.meander-tis-client-correction-switcher').css('display') == 'table-cell') {
                            $('.meander-tis-client-correction-switcher').toggle();
                          }
                          
                          if ($('.meander-tis-client-toggle').css('display') == 'block') {
                            $('.meander-tis-client-toggle').toggle();
                          }
                          $('.meander-tis-client-correction').val('');
                          $("tr[id ^= 'tr-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.'] td.name").removeAttr('style');
                          
                          $('.tr-meander-tis-client-value').hide();
                          if ($('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').val() != '') {
                              
                            var jsonRequestObj = 
                            {
                              'tisNummer': $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').val()
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
                                
                                if (json.client.tisNummer) {
                                  $('.meander-tis-client-correction-switcher').toggle();
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').val(json.client.tisNummer);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.bsn').val(json.client.bsn);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naam\\.voorletters').val(json.client.naam.voorletters);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.clinet\\.naam\\.tussenvoegsels').val(json.client.naam.tussenvoegsels);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naam\\.geboortenaam').val(json.client.naam.achternaam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naam\\.achternaam').val(json.client.naam.achternaam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.geboortedatum').val(json.client.geboortedatum);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.geslacht').val(json.client.geslacht);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.straatnaam').val(json.client.adres.straatnaam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.huisnummer').val(json.client.adres.huisnummer);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.huisnummerToevoeging').val(json.client.adres.huisnummerToevoeging);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.postcode').val(json.client.adres.postcode);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.plaatsnaam').val(json.client.adres.plaatsnaam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.land').val(json.client.adres.land);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.telefoonnummer').val(json.client.telefoonnummer);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naamgebruik').val(json.client.naamgebruik);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.partner\\.naam\\.voorletters').val(json.partner.naam.voorletters);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.partner\\.naam\\.tussenvoegsels').val(json.partner.naam.tussenvoegsels);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.partner\\.naam\\.achternaam').val(json.partner.naam.achternaam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.partner\\.geboortedatum').val(json.partner.geboortedatum);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.huisarts\\.naam\\.voorletters').val(json.huisarts.naam.voorletters);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.huisarts\\.naam\\.tussenvoegsels').val(json.huisarts.naam.tussenvoegsels);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.huisarts\\.naam\\.achternaam').val(json.huisarts.naam.achternaam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.zorgverzekering\\.naam').val(json.zorgverzekering.naam);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.zorgverzekering\\.polisnummer').val(json.zorgverzekering.polisnummer);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatiePV').val(json.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV);
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatieVP').val(json.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.bsn').html(json.client.bsn);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naam\\.voorletters').html(json.client.naam.voorletters);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naam\\.tussenvoegsels').html(json.client.naam.tussenvoegsels);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naam\\.achternaam').html(json.client.naam.achternaam);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.geboortedatum').html($.datepicker.formatDate('*{g.message(code: 'output.date.format.jquery')}', new Date(json.client.geboortedatum)));
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.geslacht').html(json.client.geslacht);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.straatnaam').html(json.client.adres.straatnaam);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.huisnummer').html(json.client.adres.huisnummer);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.huisnummerToevoeging').html(json.client.adres.huisnummerToevoeging);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.postcode').html(json.client.adres.postcode);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.plaatsnaam').html(json.client.adres.plaatsnaam);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.land').html(json.client.adres.land);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.telefoonnummer').html(json.client.telefoonnummer);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.naamgebruik').html(json.client.naamgebruik);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.huisarts\\.naam\\.voorletters').html(json.huisarts.naam.voorletters);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.huisarts\\.naam\\.tussenvoegsels').html(json.huisarts.naam.tussenvoegsels);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.huisarts\\.naam\\.achternaam').html(json.huisarts.naam.achternaam);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.zorgverzekering\\.naam').html(json.zorgverzekering.naam);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.zorgverzekering\\.polisnummer').html(json.zorgverzekering.polisnummer);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatiePV').html(json.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV);
                                  $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatieVP').html(json.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP);
                                  
                                  $.each(json.zorgopdrachten, function(zorgOpdrachtenIndex, zorgopdracht) {
                                    $('.meander-tis-zorgproducten-data')
                                      .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].ingangsDatum\" value=\"' + zorgopdracht.ingangsDatum + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].ingangsDatum\" type=\"hidden\" />'))
                                      .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].eindDatum\" value=\"' + zorgopdracht.eindDatum + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].eindDatum\" type=\"hidden\" />'))
                                      .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].afdeling\" value=\"' + zorgopdracht.afdeling + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].afdeling\" type=\"hidden\" />'))
                                      .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].categorie\" value=\"' + zorgopdracht.categorie + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].categorie\" type=\"hidden\" />'));
                                    
                                    $.each(zorgopdracht.zorgproducten, function(zorgProductenIndex, zorgproduct) {
                                      $('.meander-tis-zorgproducten-data')
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].ingangsDatum\" value=\"' + zorgproduct.ingangsDatum + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].ingangsDatum\" type=\"hidden\" />'))
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].eindDatum\" value=\"' + zorgproduct.eindDatum + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].eindDatum\" type=\"hidden\" />'))
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].productNummer\" value=\"' + zorgproduct.productNummer + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].productNummer\" type=\"hidden\" />'))
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].aantal\" value=\"' + zorgproduct.aantal + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].aantal\" type=\"hidden\" />'))
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].eenheid\" value=\"' + zorgproduct.eenheid + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].eenheid\" type=\"hidden\" />'))
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].tijdsEenheid\" value=\"' + zorgproduct.tijdsEenheid + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].tijdsEenheid\" type=\"hidden\" />'))
                                        .append($('<input name=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].zctCode\" value=\"' + zorgproduct.zctCode + '\" id=\"update-document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht[' + zorgOpdrachtenIndex + '].zorgproducten.zorgproduct[' + zorgProductenIndex + '].zctCode\" type=\"hidden\" />'));
                                      
                                      currectZorgproductenTable.fnAddData( [ zorgopdracht.afdeling, 
                                        zorgproduct.productNummer, 
                                        zorgproduct.ingangsDatum, 
                                        zorgproduct.eindDatum, 
                                        zorgproduct.aantal, 
                                        zorgproduct.eenheid,
                                        zorgproduct.tijdsEenheid,
                                        zorgproduct.zctCode ] );
                                    });
                                  });
                                  recentDocumentsTable.fnDraw();
                                  $('.tr-meander-tis-client-value').show();
                                }
                                else {
                                  $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').val('');
                                }
                                
                              }
                            });
                          }
                        });
                        
                        $('.meander-tis-client-correction').change(function() {
                          
                          var updateId = $(this).attr('id');
                          
                          var trId = '';
                          if (updateId.substring(0, 6) == 'update') {
                            trId = updateId.replace('update-', 'tr-').replace(/\./g, '\\.').replace('clientCorrecties', 'clientGegevens');
                          }
                          else {
                            trId = updateId.replace('hidden-', 'tr-').replace(/\./g, '\\.').replace('clientCorrecties', 'clientGegevens');
                          }
                          
                          if ($(this).val().length > 0) {
                            $('#' + trId + ' td.name').css('color', '#B80000');
                            $('#' + trId + ' td.name').css('font-weight', 'bold');
                          }
                          else {
                            $('#' + trId + ' td.name').removeAttr('style');
                          }
                        });
                      
                      });
                      
                    </f:javascript>
                    
                </td>
                <td style="width: 50%;" class="meander-tis-client-correction-switcher">
                  <button id="meander-tis-client-correction-switch" class="button ui-button ui-widget ui-state-default ui-corner-all" onclick="$('.meander-tis-client-toggle').toggle(); return false;">Correctie doorgeven</button>&nbsp;<a class="help-icon help action" title="Correctie in TIS gegevens doorgeven|Klik deze kop aan om correcties de TIS gegevens door te geven. De correcties worden meegestuurd met de aanvraag." href="#">&nbsp;</a>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Voorletters cli&#235;nt</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}"></form:output>
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" type="hidden" />
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.voorletters" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.naam.voorletters}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.voorletters" type="hidden" />
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="50" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters}" helpTitle="Voorletters cli&#235;nt" helpBody="Vul hier de juiste voorletters in." title="Vul hier de juiste voorletters in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Tussenvoegsels cli&#235;nt</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels}"></form:output>
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" type="hidden" />
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.tussenvoegsels" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.naam.tussenvoegsels}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.tussenvoegsels" type="hidden" />
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="10" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels}" helpTitle="Tussenvoegsels cli&#235;nt" helpBody="Vul hier de juiste tussenvoegsels in." title="Vul hier de juiste tussenvoegsels in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Achternaam cli&#235;nt</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}"></form:output>
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.geboortenaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.geboortenaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.geboortenaam" type="hidden" />
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" type="hidden" />
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.achternaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.naam.achternaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.achternaam" type="hidden" />
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="50" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam}" helpTitle="Achternaam cli&#235;nt" helpBody="Vul hier de juiste achternaam in." title="Vul hier de juiste achternaam in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Geboortedatum</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="date" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum}"></form:output>
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" type="hidden" />
                    <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.geboortedatum" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.geboortedatum}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.geboortedatum" type="hidden" />
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="date" class="meander-tis-client-correction fieldtype-Date" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum}" helpTitle="Geboortedatum" helpBody="Vul hier de juiste geboortedatum in." title="Vul hier de juiste geboortedatum in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr class="disabled">
  <td class="meander-tis-zorgproducten-data" style="vertical-align: top;">Huidige zorgproducten</td>
  <td> 
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="meander-tis-client-current-zorgproducten-table">
      <thead>
        <tr>
          <th>Afdeling</th>
          <th>Product</th>
          <th>Ingang</th>
          <th>Einde</th>
          <th>Aantal</th>
          <th>Eenheid</th>
          <th>Tijdseenheid</th>
          <th>ZCT Code</th>
        </tr>
      </thead>
      <tbody>
      </tbody>
      <tfoot>
        <tr>
          <th>Afdeling</th>
          <th>Product</th>
          <th>Ingang</th>
          <th>Einde</th>
          <th>Aantal</th>
          <th>Eenheid</th>
          <th>Tijdseenheid</th>
          <th>ZCT Code</th>
        </tr>
      </tfoot>
    </table>
  </td>
</tr>

<tr class="tr-meander-tis-client-value">
  <td colspan="3">
</tr>

<tr class="tr-meander-tis-client-value">
  <td class="meander-tis-client-recent-documents" style="vertical-align: top;">Recente aanvragen</td>
  <td> 
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="meander-tis-client-recent-documents-table">
      <thead>

	      <tr>
		      <th width="50px">ID</th>
		      <th width="100px"><f:message code="description" /></th>
		      <th width="100px"><f:message code="type" /></th>
		      <th width="100px"><f:message code="status" /></th>
		      <th width="100px"><f:message code="create.date" /></th>
		      <th width="100px"><f:message code="user" /></th>			
		      <th width="100px"><f:message code="actions" /></th>

	      </tr>
      </thead>
      <tbody>
	      <tr>
		      <td colspan="7" class="dataTables_empty">Loading data from server</td>
	      </tr>
      </tbody>
      <tfoot>

	      <tr>
		      <th>ID</th>
		      <th><f:message code="description" /></th>
		      <th><f:message code="type" /></th>
		      <th><f:message code="status" /></th>
		      <th><f:message code="create.date" /></th>
		      <th><f:message code="user" /></th>			
		      <th><f:message code="actions" /></th>

	      </tr>
      </tfoot>
    </table>
  </td>
</tr>
