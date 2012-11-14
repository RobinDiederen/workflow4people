<tr>
    <td>TIS nummer cli&#235;nt</td>
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
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.bsn.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>BSN</td>
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
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.voorletters.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Voorletters cli&#235;nt</td>
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
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.tussenvoegsels.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Tussenvoegsels cli&#235;nt</td>
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
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.naam.achternaam.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Achternaam cli&#235;nt</td>
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
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Geslacht</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.geslacht}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.geslacht}"></mmail:output>
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

<tr>
    <td *{document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land.text().length() > 0 ? '''style="color: #B80000; font-weight: bold;"''' : "" }>Land</td>
    <td>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 40%;">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.adres.land}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.adres.land}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.telefoonnummer}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.telefoonnummer.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.telefoonnummer}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.client.naamgebruik}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naamgebruik.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.client.naamgebruik}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.voorletters}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.voorletters.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.voorletters}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.tussenvoegsels}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.tussenvoegsels.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.tussenvoegsels}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.huisarts.naam.achternaam}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.achternaam.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.huisarts.naam.achternaam}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.naam}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.naam.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.naam}"></mmail:output>
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
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientGegevens.zorgverzekering.polisnummer}"></mmail:output>
                </td>
                <td style="width: 60%;">
                  <f:if test="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.polisnummer.text().size() > 0}">
                    <mmail:output type="text" value="\${document.externeClientGegevens.tisClient.clientCorrecties.zorgverzekering.polisnummer}"></mmail:output>
                  </f:if>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr>
    <td style="vertical-align: top;">Huidige zorgproducten</td>
    <td colspan="2">
        <table>
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
        </table>
    </td>
</tr>
