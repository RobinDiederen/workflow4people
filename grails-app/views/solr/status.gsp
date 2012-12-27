<%@page import="org.workflow4people.Document"%>
<html>
<head>
	<meta name="layout" content="main" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<title>Solr status</title>
  
	<r:script type="text/javascript">
	$(document).ready(function() {
		$("#progressbar").progressbar({
			value: 100
		});
		var refreshId = setInterval(function(){
			var n= Math.floor((Math.random()*10000)+1);

			$.getJSON("${createLink(action:'progress')}?n="+n, function(p){
				<%-- Smooth progressBar --%>
				$("#progressbar .ui-progressbar-value").animate({
	  				width: p.percentage + "%"
				}, {queue: false});

				$("#total").html(p.total);
				$("#currentItemType").html(p.currentItemType);
				$("#count").html(p.current);
				$("#message").html(p.statusMsg);
				$("#ping").html(p.ping);
				if (p.running) {
					$("#running").html("running");
				} else {
					$("#running").html("idle");
				}
				$('#numDocsInSolr').html(p.numDocsInSolr);
				$('#numDocsInDb').html(p.numDocsInDb);
				
			});
		}, 500);
	});
	</r:script>
  
	</head>
	<body>
		<div class="body">
			
				<h2>Solr status</h2>

			<div id="progressStatus" class="well">  		
				<table class="">
					<tbody>
						<tr class="prop">                            
							<td valign="top" class="name">Progress</td>
							<td valign="top" class="value"><div id="progressbar"></div></td>
						</tr>
						
						<tr class="prop">                            
							<td valign="top" class="name">Item type</td>
							<td valign="top" class="value" id="currentItemType">[current item type]</td>
						</tr>
						
						<tr class="prop">                            
							<td valign="top" class="name">Number of items to be indexed</td>
							<td valign="top" class="value" id="total">[total]</td>
						</tr>
						<tr class="prop">                            
							<td valign="top" class="name">Number of items completed</td>
							<td valign="top" class="value" id="count">[number of documents indexed]</td>
						</tr>
						<tr class="prop">                            
							<td valign="top" class="name">Number of documents in database</td>
							<td valign="top" class="value" id="numDocsInDb">[]</td>
						</tr>
						
						<tr class="prop">                            
							<td valign="top" class="name">Number of documents in Solr</td>
							<td valign="top" class="value" id="numDocsInSolr">[]</td>
						</tr>
						
						<tr class="prop">                            
							<td valign="top" class="name">Running</td>
							<td valign="top" class="value" id="running">[running]</td>
						</tr>
						
						<tr class="prop">                            
							<td valign="top" class="name">Ping</td>
							<td valign="top" class="value" id="ping">[ping]</td>
						</tr>
						
						<tr class="prop">                            
							<td valign="top" class="name">Message</td>
							<td valign="top" class="value" id="message">[message]</td>
						</tr>
					</tbody>
				</table>
			</div>

 			<div>
				<g:form>
					<g:submitToRemote class="ui-button ui-widget" action="abort" value="${message(code: 'default.button.abort.label', default: 'Abort')}" />
				</g:form>
			</div>

		</div>
	</body>
</html>
