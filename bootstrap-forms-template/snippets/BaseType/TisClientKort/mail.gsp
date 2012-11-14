<tr>
    <td>TIS nummer</td>
    <td>
        <mmail:output type="text" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.tisNummer}"></mmail:output>                   
    </td>
</tr>

<tr>
    <td>Naam cli&#235;nt</td>
    <td>
        <mmail:output type="text" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.naam" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.naam.achternaam}, *{document.externeClientGegevens.tisClient.clientGegevens.client.naam.voorletters}"></mmail:output>
    </td>
</tr>

<tr>
    <td>Geboortedatum</td>
    <td>
        <mmail:output type="date" gpath="document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum" value="*{document.externeClientGegevens.tisClient.clientGegevens.client.geboortedatum}"></mmail:output>
    </td>
</tr>

<tr>
    <td>Huidige zorgproducten</td>
    <td>
        <table class="meander-tis-zorgproducten">
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
