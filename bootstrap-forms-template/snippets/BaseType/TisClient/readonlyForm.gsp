<tr>
    <td>TIS nummer cli&#235;nt</td>
    <td style="min-width: 450px;">
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer}"></form:output>                   
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.text().size() > 0}">
                    <span style="color:red;" >Correcties</span><br />De aanvrager heeft aangegegeven dat een of meer TIS gegevens niet correct zijn. De aanvullingen/wijzigingen staan hier onder vermeld.
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.bsn.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>BSN</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.bsn" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.bsn}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.bsn.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.bsn" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.bsn}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Voorletters cli&#235;nt</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Tussenvoegsels cli&#235;nt</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Achternaam cli&#235;nt</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Geboortedatum</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="date" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum.text().size() > 0}">
                    <form:output type="date" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Geslacht</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.geslacht" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.geslacht}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Straatnaam</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisnummer</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisnummer toevoeging</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Postcode</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Plaats</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Land</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.land" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.land}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.telefoonnummer.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Telefoonnummer</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.telefoonnummer" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.telefoonnummer}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.telefoonnummer.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.telefoonnummer" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.telefoonnummer}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naamgebruik.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Naamgebruik</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naamgebruik" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naamgebruik}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naamgebruik.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.client.naamgebruik" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naamgebruik}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.voorletters.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisarts voorletters</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.voorletters}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.voorletters.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.voorletters" value="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.voorletters}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.tussenvoegsels.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisarts tussenvoegsels</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.tussenvoegsels}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.tussenvoegsels.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.tussenvoegsels" value="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.tussenvoegsels}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.achternaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Huisarts achternaam</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.achternaam}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.achternaam.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.achternaam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.achternaam}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.naam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Zorgverzekering</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.naam" value="\${document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.naam}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.naam.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.naam" value="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.naam}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.polisnummer.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Polisnummer</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.polisnummer" value="\${document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.polisnummer}"></form:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.polisnummer.text().size() > 0}">
                    <form:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.polisnummer" value="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.polisnummer}"></form:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td style="vertical-align: top;">Huidige zorgproducten</td>
    <td colspan="2">
        <f:javascript>
          
          $(document).ready(function () {

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
                "sUrl": "/forms/js/jquery/dataTables/localisation/dataTables.\en.txt"
              }		
            });
          });
        </f:javascript>
        
        <table cellpadding="1" cellspacing="1" border="0" class="display" id="meander-tis-client-current-zorgproducten-table">
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
            <f:each in="\${document.externeClientGegevens.tisClient.clientGegevens.zorgopdrachten.zorgopdracht}" var="zorgOpdracht">
                <f:each in="\${zorgOpdracht.zorgproducten.zorgproduct}" var="zorgProduct">
                    <tr>
                        <td>*{zorgOpdracht.afdeling}</td>
                        <td>*{zorgProduct.productNummer}</td>
                        <td>*{zorgProduct.ingangsDatum}</td>
                        <td>*{zorgProduct.eindDatum}</td>
                        <td>*{zorgProduct.aantal}</td>
                        <td>*{zorgProduct.eenheid}</td>
                        <td>*{zorgProduct.tijdsEenheid}</td>
                        <td>*{zorgProduct.zctCode}</td>
                    </tr>
                </f:each>
            </f:each>
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
