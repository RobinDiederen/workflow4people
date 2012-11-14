	<div id="tiswarning" style="display:none; cursor: default"> 
        <h1>Vul eerst een TIS nummer in….</h1>
        <br/>
        <input type="button" id="tiswarning" value="Ok" /> 
        <br/>
	</div> 

<tr>
  	<td colspan="2">
      <form:input class="meander-calculator-trigger" gpath="document.calculator.hiccalc.ciz.autocalc" value="*{document.calculator.hiccalc.ciz.autocalc}" type="checkbox" title="Automatische berekening van klassen" />&nbsp;<span style="font-weight: bold;">Automatische berekening van klassen</span>
  	</td>
</tr>

<tr>
	<td colspan="2">
	  &nbsp;
	</td>
</tr>

<tr class="meander-calculator-input-manual">
	<td>
	  PV minuten
	</td>
	<td>
	  <form:input class="meander-calculator-trigger fieldtype-Numeric" gpath="document.calculator.hiccalc.ciz.manualpvminutes" value="*{document.calculator.hiccalc.ciz.manualpvminutes}" type="text" title="!" minlength="1" maxlength="4" min="0" max="9999" />
	</td>
</tr>
<tr class="meander-calculator-input-manual">
	<td>
	  VP minuten
	</td>
	<td>
	  <form:input class="meander-calculator-trigger fieldtype-Numeric" gpath="document.calculator.hiccalc.ciz.manualvpminutes" value="*{document.calculator.hiccalc.ciz.manualvpminutes}" type="text" title="!" minlength="1" maxlength="4" min="0" max="9999" />
	</td>
</tr>
<tr class="meander-calculator-input-manual">
	<td colspan="2">
	  &nbsp;
	</td>
</tr>

<tr>
	<td colspan="2">
	  <span style="font-weight: bold;">PV</span> klasse <span id="meander-calculator-result-pvClass">*{document.calculator.hiccalc.ciz.result.pvClass}</span> (<span id="meander-calculator-result-pvMin">*{document.calculator.hiccalc.ciz.result.pvMin}</span> minuten per week) <span id="meander-calculator-pv-extended" style="color: #B80000; font-weight: bold; display: none;">&nbsp; - Verschil met actieve PV indicatie groter dan 6 minuten!</span>
    <input name="update-document.calculator.hiccalc.ciz.result.pvMin" value="*{document.calculator.hiccalc.ciz.result.pvMin}" id="update-document.calculator.hiccalc.ciz.result.pvMin" type="hidden" />
    <input name="update-document.calculator.hiccalc.ciz.result.vpMin" value="*{document.calculator.hiccalc.ciz.result.vpMin}" id="update-document.calculator.hiccalc.ciz.result.vpMin" type="hidden" />
	</td>
</tr>
<tr>
	<td colspan="2">
	  <span style="font-style: italic;">Huidige PV indicatie bedraagt <form:output gpath="document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV" value="*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV.text()}" type="text" /> minuten per week.</span>
	</td>
</tr>
<tr>
	<td colspan="2">
	  <span style="font-weight: bold;">VP</span> klasse <span id="meander-calculator-result-vpClass">*{document.calculator.hiccalc.ciz.result.vpClass}</span> (<span id="meander-calculator-result-vpMin">*{document.calculator.hiccalc.ciz.result.vpMin}</span> minuten per week) <span id="meander-calculator-vp-extended" style="color: #B80000; font-weight: bold; display: none;">&nbsp; - Verschil met actieve VP indicatie groter dan 6 minuten!</span>
    <input name="update-document.calculator.hiccalc.ciz.result.pvClass" value="*{document.calculator.hiccalc.ciz.result.pvClass}" id="update-document.calculator.hiccalc.ciz.result.pvClass" type="hidden" />
    <input name="update-document.calculator.hiccalc.ciz.result.vpClass" value="*{document.calculator.hiccalc.ciz.result.vpClass}" id="update-document.calculator.hiccalc.ciz.result.vpClass" type="hidden" />
    <input name="update-document.calculator.hiccalc.ciz.result.totaalMin" value="*{document.calculator.hiccalc.ciz.result.totaalMin}" id="update-document.calculator.hiccalc.ciz.result.totaalMin" type="hidden" />
    <input name="update-document.calculator.hiccalc.ciz.result.vpMin" value="*{document.calculator.hiccalc.ciz.result.vpMin}" id="update-document.calculator.hiccalc.ciz.result.vpMin" type="hidden" />
	</td>
</tr>
<tr>
	<td colspan="2">
	  <span style="font-style: italic;">Huidige VP indicatie bedraagt <form:output gpath="document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP" value="*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP}" type="text" /> minuten per week.</span>
	</td>
</tr>

<tr class="meander-calculator-input-auto">
  
  <td colspan="2">
    
    <f:javascript>
      $(document).ready(function() {
	      $('.accordion').accordion({
	        active: false,
	        autoHeight: false,
	        collapsible: true,
	        header: 'h3'
	      });
	      
   		$('#tiswarning').click(function() { 
            $.unblockUI(); 
            return false; 
        }); 
        
        <f:if test="\${document.calculator.hiccalc.ciz.autocalc == 'true'}">
        
        $('.meander-calculator-input-manual').toggle();
        
        </f:if>
        <f:else>
        
        $('.meander-calculator-input-auto').toggle();
        
        </f:else>
                      
        $('#hidden-document\\.calculator\\.hiccalc\\.ciz\\.autocalc').change(function() {
          $('.meander-calculator-input-manual').toggle();
          $('.meander-calculator-input-auto').toggle();
        });
        
        $('.meander-calculator-trigger').change(function() {
          if (this.id.indexOf('.hiccalc.ciz.handelingen.handeling') != -1 && this.id.indexOf('.checked') != -1) {
            var iHandeling = this.id.substring(this.id.indexOf('[') + 1, this.id.indexOf(']'));
            
            var checked = $('#update-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + iHandeling + '\\]\\.checked').val();
            var type = $('#hidden-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + iHandeling + '\\]\\.type').val();
            var categorie = $('#hidden-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + iHandeling + '\\]\\.categorie').val();

            var activiteitCountElement = $('#meander-calculator-handeling-activiteit-type_' + type + '-categorie_' + categorie.replace(/\./g, '\\.').replace(/\ /g, '\\ ') + '-count');
            if (eval(checked) == true) {
              activiteitCountElement.html(parseInt(activiteitCountElement.html()) - 1);
            }
            else {
              activiteitCountElement.html(parseInt(activiteitCountElement.html()) + 1);
            }
          }
          
          //create json object
          var jsonRequestObj = 
            {
              'autocalc': $('#update-document\\.calculator\\.hiccalc\\.ciz\\.autocalc').val(),
              'manualpvminutes': $('#update-document\\.calculator\\.hiccalc\\.ciz\\.manualpvminutes').val(),
              'manualvpminutes': $('#update-document\\.calculator\\.hiccalc\\.ciz\\.manualvpminutes').val(),
              'handelingen': []
            };
          
          for(var i = 0; i < *{document.calculator.hiccalc.ciz.handelingen.handeling.size()}; i++) {
            if ($('#update-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + i + '\\]\\.checked').val() == 'true') {
              jsonRequestObj.handelingen.push({ 
                    'type': $('#hidden-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + i + '\\]\\.type').val(),
                    'tijd': $('#hidden-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + i + '\\]\\.tijd').val(),
                    'frequentie': $('#update-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + i + '\\]\\.frequentie').val(),
                    'multiplier': $('#hidden-document\\.calculator\\.hiccalc\\.ciz\\.handelingen\\.handeling\\[' + i + '\\]\\.multiplier').val()
              });
            }
          }
          
          //json call
          jQuery.ajax({
            url: '/forms/rest/hic/berekenZorg',
            type: "POST",
            data: JSON.stringify(jsonRequestObj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function(x) {
              if (x && x.overrideMimeType) {
                x.overrideMimeType("application/j-son;charset=UTF-8");
              }
            },
            success: function(result) {
              $('#meander-calculator-result-pvMin').html(result.pvMin);
              $('#meander-calculator-result-pvClass').html(result.pvClass);
              $('#meander-calculator-result-vpMin').html(result.vpMin);
              $('#meander-calculator-result-vpClass').html(result.vpClass);
              
              $('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.pvMin').val(result.pvMin);
              $('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.vpMin').val(result.vpMin);
              $('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.pvClass').val(result.pvClass);
              $('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.vpClass').val(result.vpClass);
              $('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.totaalMin').val(result.totaalMin);
              
              checkForUitbreiding();
            }
          });
        });
      });
      
      function checkForUitbreiding() {
        $('#meander-calculator-pv-extended').hide();
        $('#meander-calculator-vp-extended').hide();
        
        var pvMin = parseFloat($('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.pvMin').val());
        var vpMin = parseFloat($('#update-document\\.calculator\\.hiccalc\\.ciz\\.result\\.vpMin').val());
        
        var currentPvMin = -1;
        if ($('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatiePV').val() != '') {
          currentPvMin = parseFloat($('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatiePV').val());
        }
        var currentVpMin = -1;
        if ($('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatieVP').val() != '') {
          currentVpMin = parseFloat($('#update-document\\.externeClientGegevens\\.tisClient\\.clientGegevens\\.actieveIndicaties\\.aantalMinutenEerstAflopendeIndicatieVP').val());
        }
        
        if ((currentPvMin == -1) || (currentVpMin == -1)) {
          $.blockUI({ message: $('#tiswarning'), css: { width: '275px' } }); 
        }
        
        if (((currentPvMin - 6) > pvMin) || ((currentPvMin + 6) < pvMin)) {
          $('#meander-calculator-pv-extended').show();
        }
        if (((currentVpMin - 6) > vpMin) || ((currentVpMin + 6) < vpMin)) {
          $('#meander-calculator-vp-extended').show();
        }
      }
    </f:javascript>
    <style>
      .fieldtype-Numeric {
        width: 40px;
      }
    </style>
    
    <f:set var="isFirstHandelingType" value="${true}" />
    <f:set var="previousHandelingType" value="" />
    <f:set var="isFirstHandelingCategorie" value="${true}" />
    <f:set var="previousHandelingCategorie" value="" />
    
    <f:each in="*{document.calculator.hiccalc.ciz.handelingen.handeling}" var="handeling" status="iHandeling">
      
      <f:if test="*{handeling.type != previousHandelingType}">
        <f:set var="isFirstHandelingCategorie" value="${true}" />
        <f:if test="*{!isFirstHandelingType}">
          
              </table>
            </div>
          </div>
        </div>
        </f:if>
        
        <div>&nbsp;</div>
        <h2>*{handeling.type.text().toUpperCase()} activiteiten</h2>
        <div class="accordion">
        
        <f:set var="isFirstHandelingType" value="*{false}" />
      </f:if>
      
      <f:if test="*{handeling.categorie != previousHandelingCategorie}">
        <f:if test="*{!isFirstHandelingCategorie}">
          
              </table>				
            </div>
          </div>
          
        </f:if>
      
        <f:set var="handelingCountInCategory" value="0" />
        <f:each in="*{document.calculator.hiccalc.ciz.handelingen.handeling}" var="tempHandeling" status="iTempHandeling">
          <f:if test="*{(tempHandeling.type.text() == handeling.type.text()) && (tempHandeling.categorie.text() == handeling.categorie.text()) && (tempHandeling.checked.text() == 'true')}">
            <f:set var="handelingCountInCategory" value="*{Integer.valueOf(handelingCountInCategory) + 1}" />
          </f:if>
        </f:each>
        
        <div>
          <h3><a href="#">*{handeling.activiteit} (<span id="meander-calculator-handeling-activiteit-type_*{handeling.type}-categorie_*{handeling.categorie}-count">*{handelingCountInCategory}</span>)</a></h3>
          <div>
	          <table>
		          <tr>
			          <th style="width: 50px; text-align: left;">Selecteer</th>
			          <th style="width: 300px; text-align: left;">Omschrijving</th>
			          <th style="width: 50px; text-align: left;">Minuten</th>
			          <th style="width: 100px; text-align: left;">Aantal / week</th>
		          </tr>
		         
        <f:set var="isFirstHandelingCategorie" value="*{false}" /> 
      </f:if>
      
      <tr>
	      <td style="text-align: center;">
	        <form:input class="meander-calculator-trigger" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].checked" value="*{handeling.checked}" type="checkbox" title="*{handeling.beschrijving}" />
          <input name="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].type" value="*{handeling.type}" id="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].type" type="hidden" />
          <input name="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].categorie" value="*{handeling.categorie}" id="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].categorie" type="hidden" />
          <input name="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].tijd" value="*{handeling.tijd}" id="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].tijd" type="hidden" />
          <input name="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].multiplier" value="*{handeling.multiplier}" id="hidden-document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].multiplier" type="hidden" />
	      </td>
	      <td style="text-align: left;">
          <form:output class="" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].beschrijving" value="*{handeling.beschrijving}" type="text" />
        </td>
	      <td style="text-align: center;">
          <form:output class="" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].tijd" value="*{handeling.tijd}" type="text" />
        </td>
	      <td style="text-align: center;">
	        <form:input class="meander-calculator-trigger fieldtype-Numeric" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].frequentie" value="*{handeling.frequentie}" type="text" title="!" minlength="1" maxlength="4" min="0" max="70" alert="0....70" />
	      </td>
      </tr>
      
      <f:set var="isFirstHandelingType" value="*{false}" />
      <f:set var="previousHandelingType" value="*{handeling.type}" />
      <f:set var="previousHandelingCategorie" value="*{handeling.categorie}" />
      
    </f:each>
    
    <f:if test="*{!isFirstHandelingType}">
    
    	    </table>				
        </div>
      </div>
    </div>
    </f:if>
      
  </td>
</tr>
