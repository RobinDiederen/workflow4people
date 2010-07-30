<html>
<head>
  <meta name="layout" content="main" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <g:set var="entityName" value="${message(code: 'newsletter.label', default: 'Newsletter')}" />
  
  <title>Form generator</title>
  
  <jq:jquery>
	$("#dialog").everyTime(500,function(i) {
		$.getJSON("${createLink(action:'progress')}",
        function(p){
          $("#count").html(p.count);
          $("#total").html(p.total);
          $("#message").html(p.message);
          $("#log").html(p.log);
          $("#progressbar").progressbar({
			value: p.pct
			});
		  if (p.completed) {
		  $("div.title h1").html("Generating forms completed");
		  }
        });
	});
  </jq:jquery>
</head>
<body>
 	<div class="body" sstyle="width:90%;">
  		<div class="nav" >
  		<span class="menuButton">&nbsp;</span>
  		</div>
 
 		 <g:if test="${flash.message}">
    		<div class="message">${flash.message}</div>
  		</g:if>
  
  		<div class="dialog" id="dialog">  		
		<table>
			<tbody>
			
				<tr class="prop">                            
					<td valign="top" class="name">Message</td>
					<td valign="top" class="value" id="message">[message]</td>
				</tr>
			
			
				<tr class="prop">                            
					<td valign="top" class="name">Progress</td>
					<td valign="top" class="value"><div id="progressbar"></div></td>
				</tr>
			                    
				<tr class="prop">                            
					<td valign="top" class="name">Total</td>
					<td valign="top" class="value" id="total">[total]</td>
				</tr>
				<tr class="prop">                            
					<td valign="top" class="name">Count</td>
					<td valign="top" class="value" id="count">[count]</td>
				</tr>
				

				
				<tr class="prop">                            
					<td valign="top" class="name">Log</td>
					<td valign="top" class="value" id="log">[log]</td>
				</tr>
				
								
			</tbody>
  		</table>
  		
  		
  			
  		</div>
  		<div class="buttons">
  		
  		              <g:form>
        <span class="button">
        &nbsp;
        <%--
        
        <g:actionSubmit class="awesome small blue button" action="abort" value="${message(code: 'default.button.abort.label', default: 'Abort')}" /> --%>
        
        </span>            
                </g:form>
  		
  		
  		</div>
  </div>
</body>
</html>
