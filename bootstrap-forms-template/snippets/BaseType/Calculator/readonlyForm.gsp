<f:if test="\${document.calculator.hiccalc.ciz.autocalc == 'false'}">

  <tr>
	  <td>
	    PV minuten
	  </td>
	  <td>
	    <form:output class="fieldtype-Numeric" gpath="document.calculator.hiccalc.ciz.manualpvminutes" value="*{document.calculator.hiccalc.ciz.manualpvminutes}" type="text" />
	  </td>
  </tr>
  <tr>
	  <td>
	    VP minuten
	  </td>
	  <td>
	    <form:output class="fieldtype-Numeric" gpath="document.calculator.hiccalc.ciz.manualvpminutes" value="*{document.calculator.hiccalc.ciz.manualvpminutes}" type="text" />
	  </td>
  </tr>
  <tr>
	  <td colspan="2">
	    &nbsp;
	  </td>
  </tr>
  
</f:if>

<tr>
	<td colspan="2">
	  <span style="font-weight: bold;">PV</span> klasse <span id="meander-calculator-result-pvClass">*{document.calculator.hiccalc.ciz.result.pvClass}</span> (<span id="meander-calculator-result-pvMin">*{document.calculator.hiccalc.ciz.result.pvMin}</span> minuten per week) <span style="color: #B80000; font-weight: bold; *{(((Float.valueOf(document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV.text()) - 6) > Float.valueOf(document.calculator.hiccalc.ciz.result.pvMin.text())) || ((Float.valueOf(document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV.text()) + 6) < Float.valueOf(document.calculator.hiccalc.ciz.result.pvMin.text()))) ? "" : "display: none;"}">&nbsp; - Verschil met actieve PV indicatie groter dan 6 minuten!</span>
	</td>
</tr>
<tr>
	<td colspan="2">
	  <span style="font-style: italic;">Huidige PV indicatie bedraagt <form:output gpath="document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV" value="*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV}" type="text" /> minuten per week.</span>
	</td>
</tr>
<tr>
	<td colspan="2">
	  <span style="font-weight: bold;">VP</span> klasse <span id="meander-calculator-result-vpClass">*{document.calculator.hiccalc.ciz.result.vpClass}</span> (<span id="meander-calculator-result-vpMin">*{document.calculator.hiccalc.ciz.result.vpMin}</span> minuten per week) <span style="color: #B80000; font-weight: bold; *{(((Float.valueOf(document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP.text()) - 6) > Float.valueOf(document.calculator.hiccalc.ciz.result.vpMin.text())) || ((Float.valueOf(document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP.text()) + 6) < Float.valueOf(document.calculator.hiccalc.ciz.result.vpMin.text()))) ? "" : "display: none;"}">&nbsp; - Verschil met actieve VP indicatie groter dan 6 minuten!</span>
	</td>
</tr>
<tr>
	<td colspan="2">
	  <span style="font-style: italic;">Huidige VP indicatie bedraagt <form:output gpath="document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP" value="*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP}" type="text" /> minuten per week.</span>
	</td>
</tr>

<f:if test="\${document.calculator.hiccalc.ciz.autocalc == 'true'}">

  <tr>
    
    <td colspan="2">
      
      <f:javascript>
        $(document).ready(function() {
	        $('.accordion').accordion({
	          active: false,
	          autoHeight: false,
	          collapsible: true,
	          header: 'h3'
	        });
        
          function checkForUitbreiding() {
            $('#meander-calculator-pv-extended').hide();
            $('#meander-calculator-vp-extended').hide();
            
            var pvMin = parseFloat('*{document.calculator.hiccalc.ciz.result.pvMin}');
            var vpMin = parseFloat('*{document.calculator.hiccalc.ciz.result.vpMin}');
            
            var currentPvMin = parseFloat('*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV.text().size() > 0 ? document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatiePV.text() : "-1" }');
            var currentVpMin = parseFloat('*{document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP.text().size() > 0 ? document.externeClientGegevens.tisClient.clientGegevens.actieveIndicaties.aantalMinutenEerstAflopendeIndicatieVP.text() : "-1" }');
            
            if ((currentPvMin == -1) || (currentVpMin == -1)) {
              alert('Vul eerst het tisnummer van de client in!');
            }
            
            if (((currentPvMin - 6) > pvMin) || ((currentPvMin + 6) < pvMin)) {
              $('#meander-calculator-pv-extended').show();
            }
            if (((currentVpMin - 6) > vpMin) || ((currentVpMin + 6) < vpMin)) {
              $('#meander-calculator-vp-extended').show();
            }
          }
          
          checkForUitbreiding();
        });
    </f:javascript>
      
      <f:set var="isFirstHandelingType" value="${true}" />
      <f:set var="previousHandelingType" value="" />
      <f:set var="handelingCountInPreviousType" value="0" />
      <f:set var="isFirstHandelingCategorie" value="${true}" />
      <f:set var="previousHandelingCategorie" value="" />
      
      <f:each in="*{document.calculator.hiccalc.ciz.handelingen.handeling}" var="handeling" status="iHandeling">
        
        <f:set var="handelingCountInType" value="0" />
        <f:set var="handelingCountInCategory" value="0" />
        <f:each in="*{document.calculator.hiccalc.ciz.handelingen.handeling}" var="tempHandeling" status="iTempHandeling">
          <f:if test="*{(tempHandeling.type.text() == handeling.type.text()) && (tempHandeling.checked.text() == 'true')}">
            <f:set var="handelingCountInType" value="*{Integer.valueOf(handelingCountInType) + 1}" />
          </f:if>
          <f:if test="*{(tempHandeling.type.text() == handeling.type.text()) && (tempHandeling.categorie.text() == handeling.categorie.text()) && (tempHandeling.checked.text() == 'true')}">
            <f:set var="handelingCountInCategory" value="*{Integer.valueOf(handelingCountInCategory) + 1}" />
          </f:if>
        </f:each>
        
        <f:if test="\${handeling.type != previousHandelingType}">
        
          <f:set var="isFirstHandelingCategorie" value="${true}" />
          <f:if test="*{!isFirstHandelingType}">
            <f:if test="\${Integer.valueOf(handelingCountInPreviousType) > 0}">
                </table>
              </div>
            </div>
            </f:if>
          </div>
          </f:if>
          
          <div>&nbsp;</div>
          <h2>*{handeling.type.text().toUpperCase()} activiteiten</h2>
          <div class="accordion">
          
          <f:set var="isFirstHandelingType" value="*{false}" />
        </f:if>
        
        <f:if test="\${Integer.valueOf(handelingCountInCategory) > 0}">
        
          <f:if test="*{handeling.categorie != previousHandelingCategorie}">
            <f:if test="*{!isFirstHandelingCategorie}">
              
                  </table>				
                </div>
              </div>
              
            </f:if>
            
            <div>
              <h3><a href="#">*{handeling.activiteit} (*{handelingCountInCategory})</a></h3>
              <div>
                <table>
                  <tr>
	                  <th style="width: 300px; text-align: left;">Omschrijving</th>
	                  <th style="width: 50px; text-align: left;">Minuten</th>
	                  <th style="width: 75px; text-align: left;">Aantal / week</th>
                  </tr>
                 
            <f:set var="isFirstHandelingCategorie" value="*{false}" /> 
              
          </f:if>
          
        </f:if>
        
        <f:if test="*{handeling.checked == 'true'}">
          <tr>
            <td style="text-align: left;">
              <form:output class="" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].beschrijving" value="*{handeling.beschrijving}" type="text" />
            </td>
            <td style="text-align: center;">
              <form:output class="" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].tijd" value="*{handeling.tijd}" type="text" />
            </td>
            <td style="text-align: center;">
              <form:output class="" gpath="document.calculator.hiccalc.ciz.handelingen.handeling[*{iHandeling}].frequentie" value="*{handeling.frequentie}" type="text" />
            </td>
          </tr>
        </f:if>
        
        <f:set var="isFirstHandelingType" value="*{false}" />
        <f:set var="previousHandelingType" value="*{handeling.type}" />
        <f:set var="handelingCountInPreviousType" value="*{handelingCountInType}" />
        <f:set var="previousHandelingCategorie" value="*{handeling.categorie}" />
          
        
      </f:each>
      
      <f:if test="\${!isFirstHandelingType && (Integer.valueOf(handelingCountInType) > 0)}">
      
      	    </table>				
          </div>
        </div>
      </div>
      </f:if>
        
    </td>
  </tr>
  
</f:if>
