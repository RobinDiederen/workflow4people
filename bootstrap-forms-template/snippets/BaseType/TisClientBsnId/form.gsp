<tr>
    <td>TIS nummer (cli&#235;ntnummer)</td>
    <td style="min-width: 450px;">
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <input class="meander-tis-client-tisNummer-value required" maxlength="6" name="update-document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer" title="Het TIS nummer van de cli&#235;nt mag niet leeg zijn." type="text" />&nbsp;<a class="help-icon help action" title="TIS nummer cli&#235;nt|Vul het TIS nummer van de cli&#235;nt in." href="#">&nbsp;</a>
                    
                    <f:javascript>
                    
                      $(document).ready(function () {
						
						<f:if test="\${document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer.text().size() <= 0}">            
							$('.meander-tis-client-correction-switcher').toggle();
							$('.meander-tis-client-correction-switcher').hide();
							$('.tr-meander-tis-client-value').hide();
						</f:if>
						<f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.text().size() > 0}">
							$('.meander-tis-client-toggle').toggle();
							$('.meander-tis-client-correction-switcher').show();
							$('.tr-meander-tis-client-value').show();
						</f:if>
						                      
		                    recentDocumentsTable=$('#meander-tis-client-recent-documents-table').dataTable( {
		                      "bProcessing": true,
		                      "bServerSide": true,
		                      "bInfo": false,
		                      "sAjaxSource": "/forms/search/myformsJSON?newtarget=true",
		                      "sPaginationType": "full_numbers",
		                      "bFilter": false,
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
                        	$('.meander-tis-client-correction-switcher').toggle();
            				$('.meander-tis-client-correction-switcher').hide();
                        	$('.tr-meander-tis-client-value').hide();                        
                        </f:if>                      
                        <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.text().size() > 0}">                        
	                        $('.meander-tis-client-toggle').toggle();
   							$('.meander-tis-client-correction-switcher').show();
	                        $('.tr-meander-tis-client-value').show();                        
                        </f:if>
                        
                        $('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').change(function() {

                        <f:if test="\${document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer.text().size() <= 0}">                        
                        	$('.meander-tis-client-correction-switcher').toggle();
                        	$('.meander-tis-client-correction-switcher').hide();
                        	$('.tr-meander-tis-client-value').hide();                        
                        </f:if> 
                          
                          $('.meander-tis-client-value').html('');
                              
                              if ($('.meander-tis-client-correction-switcher').css('display') == 'table-cell') {
                                $('.meander-tis-client-correction-switcher').toggle();
                              }
                              
                              if ($('.meander-tis-client-toggle').css('display') == 'block') {
                                $('.meander-tis-client-toggle').toggle();
                              }
                              $('.meander-tis-client-correction').val('');
                              $("tr[id ^= 'tr-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.'] td.name").removeAttr('style');
                              
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
                                    $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.straatnaam').html(json.client.adres.straatnaam);
                                    $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.huisnummer').html(json.client.adres.huisnummer);
                                    $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.huisnummerToevoeging').html(json.client.adres.huisnummerToevoeging);
                                    $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.postcode').html(json.client.adres.postcode);
                                    $('#output-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.adres\\.plaatsnaam').html(json.client.adres.plaatsnaam);
                               		
                               		$('.tr-meander-tis-client-value').show();
                               		     
                                  }
                                });
                                
                                if ($('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.client\\.tisNummer').val() == '') {
                                    $('.meander-tis-client-correction-switcher').toggle();
            						$('.meander-tis-client-correction-switcher').hide();
                        			$('.tr-meander-tis-client-value').hide(); 	
                                }
                                
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
                    
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.bsn" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.bsn}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.bsn" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.geboortenaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.geboortenaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.geboortenaam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.geslacht" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.geslacht}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.geslacht" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.land" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.adres.land}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.adres.land" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.telefoonnummer" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.telefoonnummer}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.telefoonnummer" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.client.naamgebruik" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naamgebruik}" id="update-document.externeClientGegevens.tisClient.clientGegevens.client.naamgebruik" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.voorletters" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.naam.voorletters}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.voorletters" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.tussenvoegsels" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.naam.tussenvoegsels}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.tussenvoegsels" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.achternaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.naam.achternaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.naam.achternaam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.partner.geboortedatum" value="*{document.externeClientGegevens.tisClient.clientGegevens.partner.geboortedatum}" id="update-document.externeClientGegevens.tisClient.clientGegevens.partner.geboortedatum" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.voorletters" value="*{document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.voorletters}" id="update-document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.voorletters" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.tussenvoegsels" value="*{document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.tussenvoegsels}" id="update-document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.tussenvoegsels" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.achternaam" value="*{document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.achternaam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.achternaam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.naam" value="*{document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.naam}" id="update-document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.naam" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.polisnummer" value="*{document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.polisnummer}" id="update-document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.polisnummer" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV" value="*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV}" id="update-document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV" type="hidden" />
                  <input name="update-document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP" value="*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP}" id="update-document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP" type="hidden" />
                    
                </td>
                <td style="width: 50%;" class="meander-tis-client-correction-switcher">
                    <button id="meander-tis-client-correction-switch" class="button ui-button ui-widget ui-state-default ui-corner-all" onclick="$('.meander-tis-client-toggle').toggle(); return false;">Correctie doorgeven</button>&nbsp;<a class="help-icon help action" title="Correctie in TIS gegevens doorgeven|Klik deze kop aan om correcties de TIS gegevens door te geven. De correcties worden meegestuurd met de aanvraag." href="#">&nbsp;</a>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.bsn" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.bsn.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>BSN nummer</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.bsn" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.bsn}"></form:output>
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="50" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.bsn" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.bsn}" helpTitle="BSN" helpBody="Vul hier het juiste BSN nummer in." title="Vul hier het juiste BSN nummer in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Voorletters</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}"></form:output>
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
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Tussenvoegsels</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels}"></form:output>
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
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Achternaam</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}"></form:output>
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

<tr id="tr-document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Straatnaam</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam}"></form:output>
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="50" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam}" helpTitle="Straatnaam" helpBody="Vul hier de juiste straatnaam in." title="Vul hier de juiste straatnaam in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisnummer</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer}"></form:output>
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="10" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer}" helpTitle="Huisnummer" helpBody="Vul hier het juiste huisnummer in." title="Vul hier het juiste huisnummer in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisnummer toevoeging</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging}"></form:output>
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="10" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging}" helpTitle="Huisnummer toevoeging" helpBody="Vul hier de juiste toevoeging in." title="Vul hier de juiste toevoeging in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Postcode</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode}"></form:output>
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="10" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode}" helpTitle="Postcode" helpBody="Vul hier de juiste postcode in." title="Vul hier de juiste postcode in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr-document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam" class="tr-meander-tis-client-value">
    <td class="name" *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Plaats</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam}"></form:output>
                </td>
                <td style="width: 50%;">
                    <div class="meander-tis-client-toggle" style="display: none;">
                        <form:input type="text" class="meander-tis-client-correction" maxlength="50" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam}" helpTitle="Plaats" helpBody="Vul hier de juiste plaats in." title="Vul hier de juiste plaats in."></form:input>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>
