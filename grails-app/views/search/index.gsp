
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="document.search" default="Search" /></title>
    </head>
    <body>
        <g:set var="haveQuery" value="${params.q?.trim()}" />
    <g:set var="haveResults" value="${searchResult?.results}" />
        
        <div class="body">            
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            
            <div class="nav">            
            <!-- <span class="menuButton"><b>Lucene search</b></span> -->
            <span class="menuButton"><g:if test="${haveQuery && haveResults}">
          Results <strong>${searchResult.offset + 1}</strong> - <strong>${searchResult.results.size() + searchResult.offset}</strong> of <strong>${searchResult.total}</strong> total results for query "<strong>${params.q}</strong>"
        </g:if>
        <g:else>
        <b>Lucene search</b>
        </g:else>
            </span>
            
        	</div>            
            <div class="dialog">			
		    <g:form url='[controller: "search", action: "index"]' id="searchForm" name="searchForm" method="post" action="post">		    
		        <g:textField id="q" name="q" value="${params.q}" size="50"/> <input class="awesome small blue button" type="submit" value="Search!" />
    		</g:form>
    		
    		<div id="main">

    <div id="body">

    <g:if test="${haveQuery && !haveResults && !parseException}">
      <p>No results for this search - <strong>${params.q}</strong></p>      
    </g:if>

    <g:if test="${searchResult?.suggestedQuery}">
      <p>Did you mean <g:link controller="search" action="book" params="[q: searchResult.suggestedQuery]">${StringQueryUtils.highlightTermDiffs(params.q.trim(), searchResult.suggestedQuery)}</g:link> ?</p>
    </g:if>

    <g:if test="${parseException}">
      <p>Your query - <strong>${params.q}</strong> - is invalid.</p>
    </g:if>

    <g:if test="${haveResults}">
    <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <th><g:message code="document.id" default="Id"/></th>
                   	    <th><g:message code="document.documentDescription" default="Description"/></th>
                   	                            
                   	    <th><g:message code="document.documentType" default="Document type" /></th>    
                   	    <th><g:message code="document.documentStatus" default="Status"/></th>
						<th><g:message code="document.dateCreated" default="Date created"/></th>
                        
                        
                        </tr>
                    </thead>
                    <tbody>
                    
                    <g:each var="result" in="${searchResult.results}" status="index" status="i">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link controller="document" action="show" id="${result.id}">${result.id}</g:link></td>
                            <td>${result.documentDescription}</td>                        
                            <td>${result.documentType}</td>                        
                            <td>${result.documentStatus}</td>                                                    
                            <td>${result.dateCreated}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
      
        <div class="paginateButtons">
          <g:if test="${haveResults}">
              Page:
              <g:set var="totalPages" value="${Math.ceil(searchResult.total / searchResult.max)}" />
              <g:if test="${totalPages == 1}"><span class="currentStep">1</span></g:if>
              <g:else><g:paginate controller="search" action="index" params="[q: params.q]" total="${searchResult.total}" prev="&lt; prev" next="next &gt;"/></g:else>
          </g:if>
        </div>      
    </g:if>    
    </div>
  </div>
    		
    		<div style="clear: both; display: none;" class="hint">See <a href="http://lucene.apache.org/java/docs/queryparsersyntax.html">Lucene query syntax</a> for advanced queries</div>        
			</div>
                

        </div>

    </body>
</html>
