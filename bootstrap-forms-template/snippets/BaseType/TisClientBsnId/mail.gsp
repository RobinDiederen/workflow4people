<tr>
    <td>TIS nummer (cli&#235;ntnummer)</td>
    <td style="min-width: 450px;">
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer}"></mmail:output>                   
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
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.bsn.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>BSN nummer</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.bsn}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.bsn.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.bsn}"></mmail:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Voorletters</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters}"></mmail:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Tussenvoegsels</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.tussenvoegsels}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels}"></mmail:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Achternaam</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam}"></mmail:output>
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
                    <mmail:output type="date" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum.text().size() > 0}">
                    <mmail:output type="date"value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geboortedatum}"></mmail:output>
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
                    <mmail:output type="text" class="meander-tis-client-value" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.straatnaam}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.straatnaam}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummer}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummer}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.huisnummerToevoeging}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.huisnummerToevoeging}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.postcode}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.postcode}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.plaatsnaam}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.plaatsnaam}"></mmail:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>
